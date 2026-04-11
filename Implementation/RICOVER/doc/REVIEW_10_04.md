# Review of Isla IR to CHC Transpiler

Reviewed target: `Implementation/RICOVER/src/`

Scope: code review of the Isla IR to CHC transpiler, focusing on semantic correctness of the generated SMT/CHC rather than style.

## Findings

### 1. High: `EXTS` / `EXTZ` are lowered with a hardcoded 12-bit source width

In `Implementation/RICOVER/src/chc_emit.rs:157`, the lowering for `EXTS(target_width, val)` computes the extension amount as `target_width.saturating_sub(12)`. `EXTZ` in `Implementation/RICOVER/src/chc_emit.rs:169` does the same.

This is only correct when the source bitvector is exactly 12 bits wide. It happens to work for the current `addi` immediate path, but it is wrong for any other source width. Since the IR uses `EXTS` and `EXTZ` as generic helpers, this will silently miscompile other instructions and helper code.

Impact:
- incorrect bitvector widths in emitted SMT
- incorrect semantics for instructions that extend values not originating from 12-bit immediates

### 2. High: bitvector literals wider than 64 bits are silently truncated

In `Implementation/RICOVER/src/chc_emit.rs:33`, `Exp::Bits` is emitted using `bv.lower_u64()` while preserving the original width in the SMT literal.

For bitvectors wider than 64 bits, this drops the upper bits and emits a literal with the right width but the wrong value. That is a direct semantic bug in the generated CHC.

Impact:
- wrong constants in emitted SMT for any IR literal above 64 bits
- silent corruption rather than a translation failure

### 3. High: the IR-side transpiler does not model memory writes

`translate_path` in `Implementation/RICOVER/src/chc_emit.rs:345` only special-cases `ReadMem` and `WriteReg`. Then `emit_variant_chc` in `Implementation/RICOVER/src/chc_emit.rs:506` unconditionally emits ` (= mem1 mem0) `.

As a result, any Isla instruction that performs a store or other memory mutation will be translated as memory-preserving. That makes the emitted CHC unsound for store instructions and for any instruction whose semantics include an architectural memory effect.

Impact:
- store instructions become semantically incorrect
- equivalence or safety proofs over the emitted CHC can be invalid

### 4. Medium: `read_mem` width handling collapses almost everything to 8-byte reads

In `Implementation/RICOVER/src/chc_emit.rs:396`, the translator parses the width argument and then chooses `read_mem_word` only when the width is exactly `4`; everything else becomes `read_mem_dword`.

`call_to_smt` in `Implementation/RICOVER/src/chc_emit.rs:180` has the same issue. Widths such as 1, 2, 16, or any non-literal width are therefore lowered incorrectly.

Even in an RV64 setting, this breaks byte and halfword loads as soon as they are introduced into the translated subset.

Impact:
- wrong semantics for non-4-byte, non-8-byte reads
- hidden miscompilation when the IR subset expands

### 5. Medium: unsupported operators/calls are emitted as comments instead of causing translation failure

Several fallback branches return strings such as `;; TODO: ...` or `;; unknown call: ...`:

- `Implementation/RICOVER/src/chc_emit.rs:69`
- `Implementation/RICOVER/src/chc_emit.rs:86`
- `Implementation/RICOVER/src/chc_emit.rs:202`

This lets the transpiler appear to succeed while embedding placeholders into expressions. Depending on where those strings land, the output is either malformed SMT or silently missing semantics.

This should be treated as a hard error rather than a recoverable formatting fallback.

Impact:
- translator can report success on semantically unsupported IR
- failures become late and hard to diagnose

## Notes

I also generated the current `execute` output and checked that the present toy subset parses in Z3. That does not reduce the findings above: the current success depends on a narrow IR subset that avoids the unsupported or incorrectly generalized cases.

## Summary

The current transpiler is viable as a prototype for a very small subset, but it is not yet semantically robust as a general Isla IR to CHC translation pipeline. The most important issues are the hardcoded extension width, truncation of wide bitvector literals, and the complete absence of memory-write modeling.

---

• Findings

1. High: read_mem is still lowered with the wrong semantics for the IR helper it is matching. In Sail IR, zread_mem returns a generic %bv and forwards to zMEMr(..., zwidth, ...) without sign-extending the loaded value, as shown in /
   home/safonoff/Documents/Obsidian%20Vault/Thesis/Optimization%20equivalence/Tools/Sail/Data/riscv.ir:172. The new lowering in /home/safonoff/Documents/Obsidian%20Vault/Thesis/Optimization%20equivalence/Implementation/RICOVER/src/
   chc_emit.rs:515 maps widths 1/2/4/8 to read_mem_byte/half/word/dword, and those stdlib helpers for 1/2/4 already sign-extend to 64 bits. It then unconditionally records the result width as 64 bits at /home/safonoff/Documents/
   Obsidian%20Vault/Thesis/Optimization%20equivalence/Implementation/RICOVER/src/chc_emit.rs:531. That is fine for the current 8-byte load example, but it is not semantically faithful for the generic IR helper and will miscompile any
   path that expects the raw width-sized memory value and extends it later.
2. High: memory writes are only reflected in the final mem1 constraint, so the translator still gets the wrong semantics for any variant with a store followed by another memory operation. translate_path records a single mem_write at /
   home/safonoff/Documents/Obsidian%20Vault/Thesis/Optimization%20equivalence/Implementation/RICOVER/src/chc_emit.rs:534, but every read_mem in the same path still reads from mem0 at /home/safonoff/Documents/Obsidian%20Vault/Thesis/
   Optimization%20equivalence/Implementation/RICOVER/src/chc_emit.rs:530, and the emitted rule applies the write only once at the end in /home/safonoff/Documents/Obsidian%20Vault/Thesis/Optimization%20equivalence/Implementation/RICOVER/
   src/chc_emit.rs:666. So a path with write_mem(...); read_mem(...) or multiple writes will not see sequential memory effects.