use super::*;
use crate::asm_parse;
use crate::isla_ir;

const RISCV_IR: &str = include_str!("../../snapshot/rv64d.ir");
const FOO1_ASM: &str = include_str!("../../../../Examples/foo1.s");
const FOO2_ASM: &str = include_str!("../../../../Examples/foo2.s");
const COMPRESSED_ASM: &str = include_str!("../../benchmark/supported/compressed_equiv_SUCCESS.s");
const AMO_SWAP_ASM: &str = include_str!("../../benchmark/supported/amo_swap_SUCCESS.s");

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

    // With inlined semantics, no per-instruction declare-rel should appear.
    // Only block-level and function-level relations.
    assert!(!query.contains("declare-rel addi"), "addi should be inlined, not a separate relation");
    assert!(!query.contains("declare-rel jalr"), "jalr should be inlined");

    // Inlined instruction semantics: set_reg/get_reg/sign_extend appear
    // directly in block body rules, not in separate instruction rules.
    assert!(query.contains("set_reg"), "inlined semantics should use set_reg");
    assert!(query.contains("get_reg"), "inlined semantics should use get_reg");
    assert!(query.contains("sign_extend"), "inlined semantics should use sign_extend");
    assert!(query.contains("write_mem_dword"), "sd inlined semantics should use write_mem_dword");
    assert!(query.contains("mem_read_4"), "lw inlined semantics should use mem_read_4");

    // Check frame size computation (foo1 allocates 32 bytes)
    assert!(query.contains("bv32 64"));
}

#[test]
fn test_compressed_equiv() {
    let mut src = asm_parse::parse_asm(COMPRESSED_ASM, "src").expect("parse src");
    let mut tgt = asm_parse::parse_asm(COMPRESSED_ASM, "tgt").expect("parse tgt");
    src.name = "src".to_string();
    tgt.name = "tgt".to_string();
    let model = isla_ir::parse_ir(RISCV_IR).expect("failed to parse IR");
    let query = emit_equivalence_query(&src, &tgt, "compressed", Some(&model))
        .expect("emit compressed query");

    // With inlined semantics, no per-instruction relations
    assert!(!query.contains("declare-rel addi\n"), "addi should be inlined");
    assert!(!query.contains("declare-rel add\n"), "add should be inlined");

    // Inlined semantics should contain set_reg/get_reg from addi/add
    assert!(query.contains("set_reg"), "inlined addi/add should use set_reg");
    assert!(query.contains("bvadd"), "inlined addi should use bvadd");

    // No compressed instruction names should leak into the output
    assert!(!query.contains("c_addi"), "program should not use c_addi");
    assert!(!query.contains("c_mv"), "program should not use c_mv");
}

#[test]
fn emit_execute_produces_amo_rules() {
    let model = isla_ir::parse_ir(RISCV_IR).expect("failed to parse");
    let result = emit_instruction_chc(&model, &["execute".to_string()]);
    let chc = result.expect("failed to emit CHC");

    // AMO width-specialized rules should be emitted
    assert!(chc.contains("declare-rel amoswap_4"), "expected amoswap_4 from AMO");
    assert!(chc.contains("declare-rel amoswap_8"), "expected amoswap_8 from AMO");
    assert!(chc.contains("declare-rel amoadd_4"), "expected amoadd_4 from AMO");
    assert!(chc.contains("declare-rel amoadd_8"), "expected amoadd_8 from AMO");

    // AMO rules should use memory operations
    let amo_section = chc.split("declare-rel amoswap_4")
        .nth(1)
        .and_then(|s| s.split("declare-rel").next())
        .unwrap_or("");
    assert!(amo_section.contains("mem_read_") || amo_section.contains("write_mem_"),
        "AMO rule should include memory operations");
}

#[test]
fn test_amo_swap_equiv() {
    let mut src = asm_parse::parse_asm(AMO_SWAP_ASM, "src").expect("parse src");
    let mut tgt = asm_parse::parse_asm(AMO_SWAP_ASM, "tgt").expect("parse tgt");
    src.name = "src".to_string();
    tgt.name = "tgt".to_string();
    let model = isla_ir::parse_ir(RISCV_IR).expect("failed to parse IR");
    let query = emit_equivalence_query(&src, &tgt, "amo_swap", Some(&model))
        .expect("emit amo_swap query");

    // With inlined semantics, amoswap_4 is not a separate relation
    assert!(!query.contains("declare-rel amoswap_4"), "amoswap_4 should be inlined");

    // Inlined AMO semantics should contain memory read/write operations
    assert!(query.contains("mem_read_4") || query.contains("write_mem_word"),
        "inlined amoswap should include memory operations");
}
