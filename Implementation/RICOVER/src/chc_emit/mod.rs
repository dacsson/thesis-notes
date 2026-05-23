mod format;
mod smt;
mod known_calls;
mod variant_discovery;
mod ir_translate;
mod ir_emit;
mod asm_emit;
mod equiv;

const STDLIB: &str = include_str!("../../chc_stdlib/stdlib.smt2");

/// State type signature used in declare-rel and forall bindings.
const STATE_TYPES: &str = "(Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)";

pub use ir_emit::emit_instruction_chc;
pub use equiv::emit_equivalence_query;

#[cfg(test)]
mod tests;
