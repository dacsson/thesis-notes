//! RISC-V assembly parser.
//!
//! Parses .s files to extract function bodies as sequences of instructions
//! with their operands (registers, immediates).

use anyhow::{anyhow, Result};
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
}

/// A parsed assembly function: label + sequence of instructions.
#[derive(Debug, Clone)]
pub struct AsmFunction {
    pub name: String,
    pub instructions: Vec<AsmInstruction>,
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

    for line in contents.lines() {
        let trimmed = line.trim();

        // Skip blanks and comments
        if trimmed.is_empty() || trimmed.starts_with('#') || trimmed.starts_with("//") {
            continue;
        }

        // Check if this line is the function label we're looking for
        if trimmed.starts_with(&label) || trimmed == label.trim_end_matches(':') {
            in_function = true;
            continue;
        }

        // Another label means the function ended
        if in_function && !trimmed.starts_with('.') && trimmed.ends_with(':') {
            break;
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
    // Memory reference: offset(base) e.g. "24(sp)" or "-20(s0)"
    if let Some(paren_pos) = s.find('(') {
        if s.ends_with(')') {
            let offset_str = &s[..paren_pos];
            let base = &s[paren_pos + 1..s.len() - 1];
            let offset: i64 = offset_str.parse()
                .map_err(|_| anyhow!("bad offset in '{}'", s))?;
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
}
