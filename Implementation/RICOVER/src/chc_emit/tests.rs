use super::*;
use crate::asm_parse;
use crate::isla_ir;

const RISCV_IR: &str = include_str!("../../snapshot/rv64d.ir");
const FOO1_ASM: &str = include_str!("../../../../Examples/foo1.s");
const FOO2_ASM: &str = include_str!("../../../../Examples/foo2.s");

#[test]
fn emit_execute_produces_chc() {
    let model = isla_ir::parse_ir(RISCV_IR).expect("failed to parse");
    let result = emit_instruction_chc(&model, &["execute".to_string()]);
    let chc = result.expect("failed to emit CHC");
    assert!(chc.contains("set-logic HORN"));
    assert!(chc.contains("declare-rel addi"), "expected addi relation from ITYPE/RISCV_ADDI variant");
    // LOAD/STORE are specialized per width (and per sign, for LOAD).
    assert!(chc.contains("declare-rel load_4_s"), "expected specialized load_4_s (lw)");
    assert!(chc.contains("declare-rel load_8_s"), "expected specialized load_8_s (ld)");
    assert!(chc.contains("declare-rel store_4"), "expected specialized store_4 (sw)");
    assert!(chc.contains("declare-rel store_8"), "expected specialized store_8 (sd)");
    // CHC rule body uses stdlib functions
    assert!(chc.contains("get_reg"));
    assert!(chc.contains("set_reg"));
    assert!(chc.contains("sign_extend"));
    assert!(chc.contains("bvadd"));
    // Parameters are forall-bound, not raw field names
    assert!(chc.contains("(p0 "), "expected forall-bound parameter p0");
    // Raw field names may appear in `;; SKIPPED` comments (where they come
    // from the underlying error message), but must never leak into an
    // actual emitted rule.
    let leaks_merge_var = chc
        .lines()
        .filter(|l| !l.trim_start().starts_with(";;"))
        .any(|l| l.contains("merge_var"));
    assert!(!leaks_merge_var, "raw field names should not appear in CHC rules");
}

#[test]
fn emit_foo_equivalence_query() {
    let mut foo1 = asm_parse::parse_asm(FOO1_ASM, "foo").expect("parse foo (before)");
    let mut foo2 = asm_parse::parse_asm(FOO2_ASM, "foo").expect("parse foo (after)");
    // The CLI auto-suffixes the two sides so the emitted rules don't collide.
    foo1.name = "foo1".to_string();
    foo2.name = "foo2".to_string();
    let model = isla_ir::parse_ir(RISCV_IR).expect("failed to parse");
    let query = emit_equivalence_query(&foo1, &foo2, "foo", Some(&model)).expect("emit query");
    println!("{}", query);

    // Check structure
    assert!(query.contains("set-logic HORN"));
    assert!(query.contains("declare-rel foo1"));
    assert!(query.contains("declare-rel foo2"));
    assert!(query.contains("declare-rel bad"));
    assert!(query.contains("obs_addr"));
    assert!(query.contains("query bad"));

    // IR-derived rules from the full rv64d.ir: addi, addiw, and the
    // specialized load/store variants needed by foo (lw/sw/ld/sd).
    assert!(query.contains("declare-rel addi"), "addi should come from IR");
    assert!(query.contains("declare-rel addiw"), "addiw should come from IR");
    assert!(query.contains("declare-rel load_4_s"), "lw should map to IR load_4_s");
    assert!(query.contains("declare-rel load_8_s"), "ld should map to IR load_8_s");
    assert!(query.contains("declare-rel store_4"), "sw should map to IR store_4");
    assert!(query.contains("declare-rel store_8"), "sd should map to IR store_8");
    // The asm-level opcode names should not appear as standalone rules --
    // they're mapped to the IR-derived rules, not emitted as fallbacks.
    assert!(!query.contains("declare-rel ld\n"));
    assert!(!query.contains("declare-rel lw\n"));
    assert!(!query.contains("declare-rel sd\n"));
    assert!(!query.contains("declare-rel sw\n"));
    // ret is still a fallback (JALR not yet handled).
    assert!(query.contains("declare-rel ret"));

    // Check frame size computation (foo1 allocates 32 bytes)
    assert!(query.contains("bv32 64"));
}
