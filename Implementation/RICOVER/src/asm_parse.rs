//! RISC-V assembly parser.
//!
//! Parses .s files to extract function bodies as sequences of instructions
//! with their operands (registers, immediates).

use anyhow::{anyhow, Result};
use std::collections::HashMap;
use std::ops::Range;
use std::path::Path;

/// A single RISC-V instruction with its operands.
#[derive(Debug, Clone)]
pub struct AsmInstruction {
    pub opcode: String,
    pub operands: Vec<Operand>,
}

/// An operand in a RISC-V instruction.
#[derive(Debug, Clone)]
pub enum Operand {
    /// Register name (e.g., sp, a0, ra, s0, zero)
    Reg(String),
    /// Immediate value
    Imm(i64),
    /// Memory reference: offset(base_reg)
    MemRef { offset: i64, base: String },
    /// Branch target label (e.g., ".LBB0_2")
    Label(String),
}

/// A parsed assembly function: label + sequence of instructions.
#[derive(Debug, Clone)]
pub struct AsmFunction {
    pub name: String,
    pub instructions: Vec<AsmInstruction>,
    /// Intra-function labels: label name → index of first instruction after that label.
    pub labels: HashMap<String, usize>,
}

/// A basic block within a function's control-flow graph.
#[derive(Debug, Clone)]
pub struct BasicBlock {
    pub id: usize,
    /// Data instruction indices (excludes branch terminator, if any).
    pub instr_range: Range<usize>,
    pub terminator: Terminator,
}

#[derive(Debug, Clone)]
pub enum Terminator {
    /// Conditional branch: taken → one block, not-taken → another.
    Branch {
        branch_instr_idx: usize,
        taken_block: usize,
        fallthrough_block: usize,
    },
    /// Unconditional fall-through to the next block.
    Fallthrough(usize),
    /// Function exit (block ends with `ret` or is the last block).
    Exit,
}

/// Return true if the opcode is a conditional branch.
pub fn is_branch(opcode: &str) -> bool {
    matches!(
        opcode,
        "beq" | "bne" | "blt" | "bge" | "bltu" | "bgeu"
            | "beqz" | "bnez" | "bltz" | "bgez" | "blez" | "bgtz"
    )
}

pub fn is_memory_op(opcode: &str) -> bool {
    matches!(
        opcode,
        "lb" | "lbu" | "lh" | "lhu" | "lw" | "lwu" | "ld"
            | "sb" | "sh" | "sw" | "sd"
            | "c.lw" | "c.lwsp" | "c.ld" | "c.ldsp" | "c.lh" | "c.lhu" | "c.lbu"
            | "c.sw" | "c.swsp" | "c.sd" | "c.sdsp" | "c.sh" | "c.sb"
    )
}

pub fn count_mem_ops(func: &AsmFunction) -> usize {
    func.instructions.iter().filter(|i| is_memory_op(&i.opcode)).count()
}

pub fn is_store(opcode: &str) -> bool {
    matches!(
        opcode,
        "sb" | "sh" | "sw" | "sd"
            | "c.sw" | "c.swsp" | "c.sd" | "c.sdsp" | "c.sh" | "c.sb"
    )
}

pub fn is_load(opcode: &str) -> bool {
    matches!(
        opcode,
        "lb" | "lbu" | "lh" | "lhu" | "lw" | "lwu" | "ld"
            | "c.lw" | "c.lwsp" | "c.ld" | "c.ldsp" | "c.lh" | "c.lhu" | "c.lbu"
    )
}

pub fn mem_op_width(opcode: &str) -> Option<u8> {
    match opcode {
        "lb" | "lbu" | "sb" | "c.lbu" | "c.sb" => Some(1),
        "lh" | "lhu" | "sh" | "c.lh" | "c.lhu" | "c.sh" => Some(2),
        "lw" | "lwu" | "sw" | "c.lw" | "c.lwsp" | "c.sw" | "c.swsp" => Some(4),
        "ld" | "sd" | "c.ld" | "c.ldsp" | "c.sd" | "c.sdsp" => Some(8),
        _ => None,
    }
}

/// Return true if the opcode is an unconditional jump (no fallthrough).
pub fn is_unconditional_jump(opcode: &str) -> bool {
    matches!(opcode, "j" | "c.j")
}

/// Extract the target label from a branch instruction.
pub fn branch_target(instr: &AsmInstruction) -> Result<String> {
    let label_op = instr
        .operands
        .last()
        .ok_or_else(|| anyhow!("{}: branch has no operands", instr.opcode))?;
    match label_op {
        Operand::Label(l) => Ok(l.clone()),
        _ => Err(anyhow!("{}: last operand is not a label", instr.opcode)),
    }
}

/// Build a control-flow graph from a parsed function.
///
/// Each basic block gets a contiguous range of data instructions and a
/// terminator (branch, fallthrough, or exit). Block boundaries are placed
/// at label targets and after branch instructions.
pub fn build_cfg(func: &AsmFunction) -> Result<Vec<BasicBlock>> {
    let instrs = &func.instructions;
    if instrs.is_empty() {
        return Ok(vec![]);
    }

    // Collect block-start indices
    let mut starts: Vec<usize> = vec![0];
    for &idx in func.labels.values() {
        starts.push(idx);
    }
    for (i, instr) in instrs.iter().enumerate() {
        if (is_branch(&instr.opcode) || is_unconditional_jump(&instr.opcode))
            && i + 1 < instrs.len()
        {
            starts.push(i + 1);
        }
    }
    starts.sort_unstable();
    starts.dedup();
    starts.retain(|&idx| idx < instrs.len());

    let idx_to_block: HashMap<usize, usize> = starts
        .iter()
        .enumerate()
        .map(|(block_id, &start)| (start, block_id))
        .collect();

    let num_blocks = starts.len();
    let mut blocks = Vec::new();

    for (block_id, &start) in starts.iter().enumerate() {
        let end = if block_id + 1 < num_blocks {
            starts[block_id + 1]
        } else {
            instrs.len()
        };

        let last_idx = end - 1;
        let last_instr = &instrs[last_idx];

        let (instr_range, terminator) = if is_unconditional_jump(&last_instr.opcode) {
            let target_label = branch_target(last_instr)?;
            let target_idx = *func.labels.get(&target_label).ok_or_else(|| {
                anyhow!("unknown jump target label: {}", target_label)
            })?;
            let target_block = *idx_to_block.get(&target_idx).ok_or_else(|| {
                anyhow!(
                    "jump target {} (idx {}) is not a block start",
                    target_label,
                    target_idx
                )
            })?;
            (start..last_idx, Terminator::Fallthrough(target_block))
        } else if is_branch(&last_instr.opcode) {
            let target_label = branch_target(last_instr)?;
            let target_idx = *func.labels.get(&target_label).ok_or_else(|| {
                anyhow!("unknown branch target label: {}", target_label)
            })?;
            let taken_block = *idx_to_block.get(&target_idx).ok_or_else(|| {
                anyhow!(
                    "branch target {} (idx {}) is not a block start",
                    target_label,
                    target_idx
                )
            })?;
            let fallthrough_block = if block_id + 1 < num_blocks {
                block_id + 1
            } else {
                return Err(anyhow!("branch at end of function with no fallthrough"));
            };
            (
                start..last_idx,
                Terminator::Branch {
                    branch_instr_idx: last_idx,
                    taken_block,
                    fallthrough_block,
                },
            )
        } else if last_instr.opcode == "ret" || block_id + 1 >= num_blocks {
            (start..end, Terminator::Exit)
        } else {
            (start..end, Terminator::Fallthrough(block_id + 1))
        };

        blocks.push(BasicBlock {
            id: block_id,
            instr_range,
            terminator,
        });
    }

    Ok(blocks)
}

/// Parse a .s file and extract the named function.
pub fn parse_asm_file(path: &Path, function_name: &str) -> Result<AsmFunction> {
    let contents = std::fs::read_to_string(path)?;
    parse_asm(&contents, function_name)
}

/// Parse assembly text and extract the named function.
///
/// Scans for a label matching `function_name:`, then collects instructions
/// until the next label or EOF. Skips directives (lines starting with `.`)
/// and comments (`#`, `//`).
pub fn parse_asm(contents: &str, function_name: &str) -> Result<AsmFunction> {
    let label = format!("{}:", function_name);
    let mut in_function = false;
    let mut instructions = Vec::new();
    let mut labels = HashMap::new();

    for line in contents.lines() {
        // Strip inline comments so trailing `# @label` annotations don't
        // hide the `:` from the next-label check below.
        let no_comment = line.split('#').next().unwrap_or("");
        let trimmed = no_comment.trim();

        if trimmed.is_empty() || trimmed.starts_with("//") {
            continue;
        }

        // Check if this line is the function label we're looking for
        if trimmed.starts_with(&label) || trimmed == label.trim_end_matches(':') {
            in_function = true;
            continue;
        }

        // Another label means the function ended (non-dot labels only)
        if in_function && !trimmed.starts_with('.') && trimmed.ends_with(':') {
            break;
        }

        // Intra-function labels (e.g. .LBB0_2:) — record position
        if in_function && trimmed.starts_with('.') && trimmed.ends_with(':') {
            let lbl = trimmed.trim_end_matches(':').to_string();
            labels.insert(lbl, instructions.len());
            continue;
        }

        // Skip assembler directives (.globl, .type, etc.)
        if trimmed.starts_with('.') {
            continue;
        }

        if in_function {
            if let Some(instr) = parse_instruction(trimmed)? {
                instructions.push(instr);
            }
        }
    }

    if !in_function {
        return Err(anyhow!("function '{}' not found in input", function_name));
    }

    Ok(AsmFunction {
        name: function_name.to_string(),
        instructions,
        labels,
    })
}

/// Parse a single assembly line into an instruction.
///
/// Examples:
///   "addi sp, sp, -32"  → Opcode("addi"), [Reg("sp"), Reg("sp"), Imm(-32)]
///   "sd ra, 24(sp)"     → Opcode("sd"),   [Reg("ra"), MemRef{24, "sp"}]
///   "lw a0, -20(s0)"    → Opcode("lw"),   [Reg("a0"), MemRef{-20, "s0"}]
///   "ret"               → Opcode("ret"),   []
fn parse_instruction(line: &str) -> Result<Option<AsmInstruction>> {
    let line = line.trim();
    // Strip inline comments
    let line = line.split('#').next().unwrap().trim();
    if line.is_empty() {
        return Ok(None);
    }

    // Split opcode from operands at first whitespace
    let (opcode, rest) = match line.split_once(char::is_whitespace) {
        Some((op, rest)) => (op.trim(), rest.trim()),
        None => (line, ""),
    };

    // `ret` is a pseudo-instruction (jalr zero, 0(ra)) with no operands
    if opcode == "ret" {
        return Ok(Some(AsmInstruction {
            opcode: "ret".to_string(),
            operands: vec![],
        }));
    }

    let operands = parse_operands(rest)?;
    Ok(Some(AsmInstruction {
        opcode: opcode.to_string(),
        operands,
    }))
}

/// Split comma-separated operands and parse each one.
fn parse_operands(s: &str) -> Result<Vec<Operand>> {
    if s.is_empty() {
        return Ok(vec![]);
    }
    s.split(',').map(|part| parse_one_operand(part.trim())).collect()
}

/// Parse a single operand string.
///
/// Recognizes three forms:
///   - Memory reference: "24(sp)", "-20(s0)"  → MemRef { offset, base }
///   - Immediate:        "-32", "1"           → Imm(i64)
///   - Register:         "sp", "a0", "zero"   → Reg(String)
fn parse_one_operand(s: &str) -> Result<Operand> {
    // Branch target label (e.g. ".LBB0_2")
    if s.starts_with('.') {
        return Ok(Operand::Label(s.to_string()));
    }

    // Memory reference: offset(base) e.g. "24(sp)" or "-20(s0)"
    if let Some(paren_pos) = s.find('(') {
        if s.ends_with(')') {
            let offset_str = &s[..paren_pos];
            let base = &s[paren_pos + 1..s.len() - 1];
            let offset: i64 = if offset_str.is_empty() {
                0
            } else {
                offset_str.parse()
                    .map_err(|_| anyhow!("bad offset in '{}'", s))?
            };
            return Ok(Operand::MemRef {
                offset,
                base: base.to_string(),
            });
        }
    }

    // Try as immediate (bare integer)
    if let Ok(n) = s.parse::<i64>() {
        return Ok(Operand::Imm(n));
    }

    // Otherwise it's a register name
    Ok(Operand::Reg(s.to_string()))
}

/// Convert ABI register name to its 5-bit hardware index.
///
/// E.g. "zero" → 0, "ra" → 1, "sp" → 2, "a0" → 10, "s0"/"fp" → 8
pub fn reg_index(name: &str) -> Result<u8> {
    match name {
        "zero" | "x0" => Ok(0),
        "ra" | "x1" => Ok(1),
        "sp" | "x2" => Ok(2),
        "gp" | "x3" => Ok(3),
        "tp" | "x4" => Ok(4),
        "t0" | "x5" => Ok(5),
        "t1" | "x6" => Ok(6),
        "t2" | "x7" => Ok(7),
        "s0" | "fp" | "x8" => Ok(8),
        "s1" | "x9" => Ok(9),
        "a0" | "x10" => Ok(10),
        "a1" | "x11" => Ok(11),
        "a2" | "x12" => Ok(12),
        "a3" | "x13" => Ok(13),
        "a4" | "x14" => Ok(14),
        "a5" | "x15" => Ok(15),
        "a6" | "x16" => Ok(16),
        "a7" | "x17" => Ok(17),
        "s2" | "x18" => Ok(18),
        "s3" | "x19" => Ok(19),
        "s4" | "x20" => Ok(20),
        "s5" | "x21" => Ok(21),
        "s6" | "x22" => Ok(22),
        "s7" | "x23" => Ok(23),
        "s8" | "x24" => Ok(24),
        "s9" | "x25" => Ok(25),
        "s10" | "x26" => Ok(26),
        "s11" | "x27" => Ok(27),
        "t3" | "x28" => Ok(28),
        "t4" | "x29" => Ok(29),
        "t5" | "x30" => Ok(30),
        "t6" | "x31" => Ok(31),
        _ => Err(anyhow!("unknown register: {}", name)),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    const FOO1: &str = include_str!("../../../Examples/foo1.s");
    const FOO2: &str = include_str!("../../../Examples/foo2.s");

    #[test]
    fn parse_foo1() {
        let func = parse_asm(FOO1, "foo").unwrap();
        assert_eq!(func.name, "foo");
        // 14 instructions: addi, sd, sd, addi, addi, sw, lw, addiw, sw, lw, ld, ld, addi, ret
        assert_eq!(func.instructions.len(), 14);
        assert_eq!(func.instructions[0].opcode, "addi");
        assert_eq!(func.instructions[13].opcode, "ret");
    }

    #[test]
    fn parse_foo2() {
        let func = parse_asm(FOO2, "foo").unwrap();
        assert_eq!(func.name, "foo");
        // 2 instructions: addi, ret
        assert_eq!(func.instructions.len(), 2);
    }

    #[test]
    fn parse_memref() {
        let op = parse_one_operand("-20(s0)").unwrap();
        match op {
            Operand::MemRef { offset, base } => {
                assert_eq!(offset, -20);
                assert_eq!(base, "s0");
            }
            _ => panic!("expected MemRef"),
        }
    }

    #[test]
    fn parse_label_operand() {
        let op = parse_one_operand(".LBB0_2").unwrap();
        match op {
            Operand::Label(l) => assert_eq!(l, ".LBB0_2"),
            _ => panic!("expected Label"),
        }
    }

    const PR44306: &str = include_str!("../benchmark/supported/PR44306_BAD.s");

    #[test]
    fn parse_branch_function_src() {
        let func = parse_asm(PR44306, "src").unwrap();
        assert_eq!(func.instructions.len(), 7);
        assert_eq!(func.instructions[0].opcode, "lw");
        assert_eq!(func.instructions[2].opcode, "blt");
        assert_eq!(func.instructions[3].opcode, "mv");
        assert_eq!(func.instructions[4].opcode, "ld");
        assert_eq!(func.instructions[6].opcode, "ret");
        assert_eq!(func.labels.get(".LBB0_2"), Some(&4));
    }

    #[test]
    fn parse_branch_function_tgt() {
        let func = parse_asm(PR44306, "tgt").unwrap();
        assert_eq!(func.instructions.len(), 6);
        assert_eq!(func.instructions[2].opcode, "blt");
        assert_eq!(func.instructions[4].opcode, "sw");
        assert_eq!(func.labels.get(".LBB0_2"), Some(&4));
    }

    #[test]
    fn parse_foo1_no_labels() {
        let func = parse_asm(FOO1, "foo").unwrap();
        assert!(func.labels.is_empty());
    }

    // ── CFG construction tests ──────────────────────────────────────

    #[test]
    fn cfg_straight_line_foo1() {
        let func = parse_asm(FOO1, "foo").unwrap();
        let cfg = build_cfg(&func).unwrap();
        assert_eq!(cfg.len(), 1);
        assert_eq!(cfg[0].instr_range, 0..14);
        assert!(matches!(cfg[0].terminator, Terminator::Exit));
    }

    #[test]
    fn cfg_straight_line_foo2() {
        let func = parse_asm(FOO2, "foo").unwrap();
        let cfg = build_cfg(&func).unwrap();
        assert_eq!(cfg.len(), 1);
        assert_eq!(cfg[0].instr_range, 0..2);
        assert!(matches!(cfg[0].terminator, Terminator::Exit));
    }

    #[test]
    fn cfg_pr44306_src() {
        let func = parse_asm(PR44306, "src").unwrap();
        let cfg = build_cfg(&func).unwrap();
        assert_eq!(cfg.len(), 3);

        // bb0: lw, lw (branch terminator excluded)
        assert_eq!(cfg[0].instr_range, 0..2);
        match cfg[0].terminator {
            Terminator::Branch { branch_instr_idx, taken_block, fallthrough_block } => {
                assert_eq!(branch_instr_idx, 2);
                assert_eq!(taken_block, 2);
                assert_eq!(fallthrough_block, 1);
            }
            _ => panic!("expected Branch terminator for bb0"),
        }

        // bb1: mv (fallthrough to bb2)
        assert_eq!(cfg[1].instr_range, 3..4);
        assert!(matches!(cfg[1].terminator, Terminator::Fallthrough(2)));

        // bb2: ld, sd, ret (exit)
        assert_eq!(cfg[2].instr_range, 4..7);
        assert!(matches!(cfg[2].terminator, Terminator::Exit));
    }

    #[test]
    fn cfg_pr44306_tgt() {
        let func = parse_asm(PR44306, "tgt").unwrap();
        let cfg = build_cfg(&func).unwrap();
        assert_eq!(cfg.len(), 3);

        // bb0: lw, lw (branch)
        assert_eq!(cfg[0].instr_range, 0..2);
        match cfg[0].terminator {
            Terminator::Branch { taken_block, fallthrough_block, .. } => {
                assert_eq!(taken_block, 2);
                assert_eq!(fallthrough_block, 1);
            }
            _ => panic!("expected Branch"),
        }

        // bb1: mv (fallthrough)
        assert_eq!(cfg[1].instr_range, 3..4);

        // bb2: sw, ret (exit)
        assert_eq!(cfg[2].instr_range, 4..6);
        assert!(matches!(cfg[2].terminator, Terminator::Exit));
    }
}
