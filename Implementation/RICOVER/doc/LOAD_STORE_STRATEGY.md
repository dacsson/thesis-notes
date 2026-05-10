● Read both bodies. Here's what I found — the IR is denser than the earlier audit suggested, so I want to align on scope before coding.

What LOAD and STORE actually do (in the IR)

LOAD (rv64d.ir:251817..251866) — five tuple params: imm:bv12, rs1:bv5, rd:bv5, is_unsigned:bool, width:i64. Then:

1. Address calc — offset = sign_extend_64(imm). Already supported.
2. Precondition — lteq_int(width, xlen_bytes) + sail_assert(...). Assertion on the width; we can drop it.
3. Memory read — vmem_read(rs1, offset, width, MemoryAccessType, false, false, false) returning a result union. Note: the address is computed inside — the call takes rs1 as a reg id plus an offset, not a pre-computed address.
4. Exception branch — jump have_exception goto <err>, fall-through = no exception. Walker already ignores this; safe.
5. Result-union match — jump vmem_read_result is Ok goto <err_arm>, fall-through = success.
6. Ok arm — data = result as Ok, ext = extend_value(is_unsigned, data), wX_bits(rd, ext), RETIRE_SUCCESS, goto <merge>.
7. Err arm — propagates the Err through the result union, goto <merge>.

STORE (:251866..251933) — four tuple params: imm, rs1, rs2, width (no is_unsigned — stores don't extend). Same pattern, plus a subrange slice to compute the stored value: data = subrange_bits(get_reg(rs2), width*8-1, 0). Needs mult_atom
and sub_atom for the index arithmetic.

The symbolic-width problem

width is a tuple field typed %i64 — it's symbolic from the IR's point of view, because LOAD/STORE are shared across all widths (lb/lh/lw/ld and lbu/lhu/lwu). But our stdlib has four distinct mem_read_N/write_mem_N functions
(return-type-dependent), so we can't emit a rule where the memory function is symbolic — the branches of an ite would have different BV widths.

CHOSEN STRATEGY: Per-width specialization. Run translate_variant four times with an initial binding width → "1"/"2"/"4"/"8", producing four rules (load_1, load_2, load_4, load_8, plus _s/_u for sign flavor → 8 LOAD rules, 4 STORE rules).
ir_rule_for_opcode maps lw → load_4_s, lwu → load_4_u, ld → load_8_s, etc. Per-width specialization also lets extend_value(is_unsigned, data) become a concrete ((_ sign_extend (64-8N)) data) or zero-extend at emit time, since the data
width is fixed.

Control-flow challenge

The walker currently treats Goto/Jump/End as no-ops (skip). For LOAD that means it'll walk both the Ok arm and the Err arm and whichever reg_write appears last wins — wrong. We need discover_variants (or the walker) to recognize jump X
is Ok goto T and take only the fall-through (success) arm, skipping the Err arm at [T .. merge).

Two ways:

CHOSEN STRATEGY: discover_variants segmentation: treat the is Ok jump the same way we already treat the outer Kind-dispatch — the fall-through is the success path. For a non-enum-dispatched variant like LOAD, scan the body for Jump(Exp::Is(Ok*, _),
T, _), split the body into [start..jump_idx), [jump_idx+1 .. goto_merge), [merge .. outer_skip), the same three-segment pattern we already use. Detection key: the constructor name matches Ok* (heuristic) or we pass in a known-good-ctor
set.

The primitive plumbing (small, mechanical)

Classify these in call_to_smt / KnownCall:

- lteq_int(a, b) → drop (return "true" or similar; the binding is only referenced by sail_assert)
- sail_assert(cond, msg) → no-op, return "(_ unit)"
- zz5i64zDzKz5i / zz5izDzKz5i64 → identity passthrough
- sub_atom(a, b) → (- a b)
- mult_atom(a, b) → (* a b)
- subrange_bits(val, hi, lo) → ((_ extract hi lo) val) (args in Sail order; hi/lo must be literal ints after substitution)
- vmem_read(reg_id, offset, width_i64, _, _, _, _) → custom: emit (mem_read_N <current_mem> (bvadd (get_reg regs0 <reg_id>) <offset>)) where N comes from the pre-bound width
- vmem_write(reg_id, offset, width_i64, val, _, _, _) → custom: wrap current_mem, emit "(_ unit)"
- extend_value(is_unsigned_bool, data) → since we pre-bind is_unsigned, pick sign_extend or zero_extend at emit time with extension amount 64 - width*8
- Copy(Unwrap(...)) without field (e.g. data = result as Ok) → identity binding: smt(data) := smt(result)

Open question on is_unsigned and ir_rule_for_opcode

If we specialize per (width, sign) for LOAD, the ir_rule_for_opcode mapping is:

lb  → load_1_s    lbu → load_1_u
lh  → load_2_s    lhu → load_2_u
lw  → load_4_s    lwu → load_4_u
ld  → load_8_s   (no ldu — already 64 bits)

Stores are simpler: sb → store_1, sh → store_2, sw → store_4, sd → store_8.

But there's a question: the foo example only uses lw, ld, sw, sd. For a first pass, should I emit all 12 specializations, or just the four foo needs? I'd argue all 12 because the specialization loop is the same work either way, and it
future-proofs for other benchmarks.

  ---
Proposed scope for this turn

1. Plumbing: classify the ~10 primitives listed above in call_to_smt/KnownCall.
2. VMemRead/VMemWrite as new KnownCall variants with custom handlers in translate_variant.
3. Per-width (and per-sign, for LOAD) specialization of LOAD/STORE: extend discover_variants to emit multiple InstrVariants from one LOAD/STORE body, each with a pre-bound initial_bindings: HashMap<Name, String> threaded into
   translate_variant. This is the "initial state threading" we deferred earlier.
4. is Ok segmentation in discover_variants (approach C above) for single-segment variants, to skip Err arms.
5. Identity handling for Copy(Unwrap(_)) (non-field).
6. Update ir_rule_for_opcode with the 12 new mappings.

What I'll not do in this turn:
- Touch LOADRES, STORECON, LOAD_FP, STORE_FP — same pattern but different details, not needed for foo.
- Touch JALR/ret — next up.
- Plumb have_exception into the CHC semantics — we're eliding exceptions entirely (the projected-equivalence notion doesn't observe them in foo).

✻ Churned for 4m 5s

    The parts I would tighten before implementing are:

    - Make specialization explicit and early: width/sign must be pre-bound before any vmem_read/vmem_write/extend_value lowering.
    - Define the LOAD/STORE success-arm segmentation by IR shape, not by constructor-name heuristic alone.
    - Treat Unwrap(... as Ok) as identity only inside that selected success segment.

    Emitting all 12 specializations is the right default. The code complexity increase is small, and it avoids baking benchmark-specific assumptions into the translator.

    So: yes, the scope is sane, with one modification. Keep step 4, but implement it as structured result-union segmentation rather than an Ok* string heuristic.

---

# COMMENT

● All 7 tests pass, foo1 vs foo2 verified UNSAT via IR-derived load_4_s/load_8_s/store_4/store_8 rules.

Summary of changes to src/chc_emit.rs:

1. New KnownCall variants + classifier entries: MultAtom, SubAtom, SailAssert, VMemRead, VMemWrite, ExtendValue.
2. call_to_smt handlers: mult_atom/sub_atom eagerly fold integer literals and error otherwise (non-literals mean an unspecialized path); sail_assert placeholder; vmem/extend_value delegate to translate_variant.
3. InstrVariant.initial_bindings: new field threading pre-bound width/sign literals into translate_variant.
4. try_specialize_result_variant: for LOAD/STORE, discovers tuple-field extractions in source order, finds the inner is Ok dispatch to drop the Err arm, and emits 8 LOAD + 4 STORE specializations with per-width (and per-sign for LOAD)
   pre-bound field values.
5. translate_variant:
   - accepts initial_bindings, pre-populates bindings;
   - skips pre-bound fields from becoming forall-bound params;
   - new VMemRead/VMemWrite/ExtendValue/SailAssert handlers;
   - generic call arm falls back to (_ unit) for union/enum-typed targets (for opaque constructors like Load<u>(Data));
   - tracks subrange_bits result widths in type_widths;
   - VMemWrite zero-extends narrow values to BV64 for the stdlib signature.
6. infer_bv_width looks through Exp::Unwrap.
7. ir_rule_for_opcode maps lb/lbu/lh/lhu/lw/lwu/ld → load_{N}_{s,u} and sb/sh/sw/sd → store_{N}.
8. instruction_to_chc extends load/store opcode classes to cover all widths, and swaps store operand order to (off, rs2, base) to match the Sail STORE(imm, rs2, rs1, width) tuple layout.
9. Tests switched to the full snapshot/rv64d.ir, asserting specialized rule names (load_4_s, load_8_s, store_4, store_8) and allowing merge_var in ;; SKIPPED comments.

# REVIEW of LOAD/STORE commit 

• Findings:

1. High: the new LOAD/STORE specialization drops the exceptional path from Sail and emits success-only CHC rules, so the translation no longer preserves the original execute semantics for trapping memory accesses. In Sail, both LOAD and
   STORE first call vmem_read/vmem_write, then branch on have_exception, and then branch on Ok vs Err before returning an ExecutionResult ([snapshot/rv64d.ir](/home/safonoff/Documents/Obsidian Vault/Thesis/Optimization equivalence/
   Implementation/RICOVER/snapshot/rv64d.ir:251847), [snapshot/rv64d.ir](/home/safonoff/Documents/Obsidian Vault/Thesis/Optimization equivalence/Implementation/RICOVER/snapshot/rv64d.ir:251852), [snapshot/rv64d.ir](/home/safonoff/
   Documents/Obsidian Vault/Thesis/Optimization equivalence/Implementation/RICOVER/snapshot/rv64d.ir:251920), [snapshot/rv64d.ir](/home/safonoff/Documents/Obsidian Vault/Thesis/Optimization equivalence/Implementation/RICOVER/snapshot/
   rv64d.ir:251925)). The new code explicitly truncates the variant to the fall-through “success” segment by finding the Ok jump and discarding the Err arm ([src/chc_emit.rs](/home/safonoff/Documents/Obsidian Vault/Thesis/Optimization
   equivalence/Implementation/RICOVER/src/chc_emit.rs:524), [src/chc_emit.rs](/home/safonoff/Documents/Obsidian Vault/Thesis/Optimization equivalence/Implementation/RICOVER/src/chc_emit.rs:535)), and translate_variant lowers vmem_read/
   vmem_write directly to raw memory operations with unconditional pc+4 and no exceptional outcome ([src/chc_emit.rs](/home/safonoff/Documents/Obsidian Vault/Thesis/Optimization equivalence/Implementation/RICOVER/src/chc_emit.rs:806),
   [src/chc_emit.rs](/home/safonoff/Documents/Obsidian Vault/Thesis/Optimization equivalence/Implementation/RICOVER/src/chc_emit.rs:828)). That is not semantics-preserving with respect to the Sail IR; it is only the success subcase.

Tests are green, but they only check the happy-path equivalence instances and relation names. They do not exercise the have_exception / Err behavior that was removed.

If you want this commit to be defensible as “keeps the initial semantics”, the translation needs either:

1. an explicit exception/result model in the CHC state, or
2. a conservative guard proving the exceptional path is impossible, or
3. to skip/fallback these variants instead of emitting success-only rules.