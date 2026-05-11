# Opcode translation audit — 2026-04-12

Target: the opcodes that the `foo` worked example uses and that `check-equiv` still warns about when run against `snapshot/rv64d.ir`:

```
warning: falling back to hand-written CHC rules for opcodes not covered by the IR: ld, lw, ret, sd, sw
```

(`addi` no longer appears in the warning list, but see §ADDI below — it translates to a **broken** rule, which is worse.)

## Method

```bash
cargo run -- translate-ir \
  -i snapshot/rv64d.ir \
  -o /tmp/ricover_rv64d.smt2 \
  -f execute 2> /tmp/ricover_stderr.log
```

Then grep `/tmp/ricover_rv64d.smt2` for `declare-rel <opcode>` and `SKIPPED variant`, and cross-reference against the ITYPE/LOAD/STORE/JALR bodies in `zexecute` (line 251154+ of `rv64d.ir`).

Target opcode → IR variant mapping:

| asm opcode | IR variant | outcome |
|---|---|---|
| `addi`  | ITYPE | translates (but rule is semantically empty — see §ADDI) |
| `addiw` | ADDIW | translates correctly |
| `ld`    | LOAD  | SKIPPED — `lteq_int(p4, xlen_bytes)` |
| `lw`    | LOAD  | SKIPPED — same |
| `sd`    | STORE | SKIPPED — `lteq_int(p3, xlen_bytes)` |
| `sw`    | STORE | SKIPPED — same |
| `ret`   | JALR  | SKIPPED — `update_elp_state(p1)` (+ `ret` is a pseudo-insn, no dedicated variant anyway) |

## §ADDI — translates, but the rule is wrong

The emitted rule (`/tmp/ricover_rv64d.smt2:240`):

```smt2
;; --- ADDI instruction (from Isla IR [309..328]) ---
(declare-rel addi
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)))

(rule
  (forall ((regs0 …) (mem0 …) (pc0 …) (regs1 …) (mem1 …) (pc1 …))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (addi regs0 mem0 pc0 regs1 mem1 pc1))))
```

Problems:

1. **6-arity signature, not 9-arity.** No `imm`, `rs1`, `rd` parameters. The operand triple has been silently dropped.
2. **Body is a no-op.** `regs1 = regs0`, `mem1 = mem0`, `pc1 = pc0 + 4`. There is no `set_reg`, no `bvadd`, nothing that reflects `rd := rs1 + sign_extend(imm)`.
3. **Arity mismatch in the equivalence query.** `emit_program_rule` still emits 9-argument calls (`(addi regs0 mem0 pc0 regs1 mem1 pc1 (_ bv4064 12) reg_sp reg_sp)` — `/tmp/ricover_foo_query.smt2:2696`), so the query combines a 6-arity `declare-rel` with 9-arity callsites. Z3 will reject it outright.

Compare this with **ADDIW** (`/tmp/ricover_rv64d.smt2:295`), which translates correctly:

```smt2
(declare-rel addiw
  (… BV12 BV5 BV5))

(rule
  (forall (… (p0 (_ BitVec 12)) (p1 (_ BitVec 5)) (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2
                      ((_ sign_extend 32)
                       ((_ extract 31 0)
                        (bvadd (get_reg regs0 p1) ((_ sign_extend 52) p0))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (addiw regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))
```

— 9-arity, real `set_reg`/`bvadd`/`sign_extend`/`extract`, exactly what we want.

### Why ADDIW works and ADDI doesn't

They sit inside the same `zexecute` function but arrive there by different routes. In `rv64d.ir` (line 251434):

```
jump zmergez3var is zITYPE goto 383
  zz4110 : %bv12    ; imm
  zz4111 : %bv5     ; rs1
  zz4112 : %bv5     ; rd
  zz4113 : %enum ziop
  zz4113 = … as ITYPE.…ziop3              ; <— enum operand
  … state init (pc += 4, sign_extend imm) …
  jump @neq(zADDI, zz4113) goto 309       ; <— inner dispatch
    zz4120 = zrX_bits(zz4111)             ; rs1
    zz4123 = zadd_bits(zz4120, zz4114)    ; rs1 + imm
    zz4119 = zz4123
    goto 378
  jump @neq(zSLTI, zz4113) goto 328
    …SLTI body…
  jump @neq(zANDI, zz4113) goto 347
    …
  … [the actual writeback `wX_bits(rd, result)` lives past label 378]
```

ADDIW, by contrast, is its **own outer variant**: the stderr line `found ADDIW: jump Kind(…) to 825` shows that variant discovery recognized ADDIW as a standalone dispatch target, so its body is a single straight-line block from start-of-variant to end-of-variant. `translate_path` walks it and all the operand reads and the writeback are in range.

For ADDI, two independent issues combine to produce the empty rule:

1. **The `iop` enum parameter has type `Ty::Enum(Name { id: 467 })`.** `ty_to_smt` has no mapping for enum types, so when the variant's parameter list is built, `iop` is omitted. But variant discovery also somehow drops `imm`/`rs1`/`rd` from the parameter list — likely because it's using a synthetic ADDI variant whose operand list was derived from walking only the inner `@neq(zADDI, …)` arm header, which lost the bindings.
2. **The actual ADDI computation (`rX_bits`/`add_bits`/`wX_bits`) lives inside the `@neq(zADDI, …) goto 309` arm.** `translate_path` is linear; it walks instruction indices `[body_start..body_end]` and does not follow `goto` edges. When it reaches the `jump @neq` it either falls through (skipping the inner arm entirely) or treats the guard as a dead precondition. Either way, the ADDI-specific stmts never reach the emitter. All that survives is the shared prologue: the `sign_extend` of the immediate (a dead let, since no `p0` param exists to bind it to) and the implicit `pc += 4`.

Net effect: the variant discovery emits **something** called "ADDI", but it has no operands and no computation — essentially a NOP rule. Because it type-checks as HORN on its own, the transpiler reports success and no warning is printed; the breakage only becomes visible when the program rule calls it with the real 9-arity signature.

This is strictly worse than a fallback: a fallback produces a working rule, whereas this produces a silently-wrong rule that also makes the query malformed. **Fixing this should take priority over any of the skipped variants below.**

### What needs to change for ADDI specifically

- Variant discovery must either (a) reject synthetic variants produced from nested `@neq`-dispatch arms, so ADDI falls back cleanly, or (b) actually follow the `@neq` arm as its own linear subpath and emit the full 9-arity rule with operand parameters.
- Option (b) is the real fix and also unlocks SLTI/SLTIU/ANDI/ORI/XORI from ITYPE, plus the whole RTYPE/BTYPE/UTYPE/SHIFTIWOP/SHIFTIOP families, all of which use the same inner-enum-dispatch pattern in the full IR.

## §LOAD → `ld`, `lw` — SKIPPED

IR body starts at `rv64d.ir:251817`. The first thing it does, before any memory access:

```
zz4277 : %i64                                ; width in bytes
zz4283 = zz5i64zDzKz5i(zz4277)               ; i64 → %i  (unclassified)
zz4284 = zz5i64zDzKz5i(zxlen_bytes)          ; i64 → %i
zz4282 = zlteq_int(zz4283, zz4284)           ; <— fails here
zz4285 = $zsail_assert(zz4282, "…:289.28-289.29")
```

`lteq_int` is not in `classify_call`, so `call_to_smt` raises `unsupported Sail function call: lteq_int(p4, xlen_bytes)` and the whole LOAD variant is abandoned by the per-variant error recovery.

Even if we classify `lteq_int` and `sail_assert` (as a no-op), LOAD will hit two further unclassified constructs before it completes:

```
zz4286 = zvmem_read(rs1, addr, width, zLoadzIuzK(zData),
                    false, false, false)        ; 7-arg mem read
jump have_exception goto 695                    ; global exception flag
jump zz4286 is zOkzIbzCUExecutionResultzK       ; result-union pattern match
zz4290 = zextend_value(is_unsigned, data)       ; runtime sign/zero switch
zwX_bits(rd, zz4290)
```

So the full list of blockers for LOAD is:

1. `lteq_int` — integer `≤`, not classified.
2. `zz5i64zDzKz5i` — `%i64 → %i` coercion, not classified.
3. `sail_assert` — runtime assertion primitive, not classified. Cleanest fix: treat as a precondition, or drop.
4. `vmem_read` — 7-argument virtual-memory read. Takes a `MemoryAccessType` union (`zLoadzIuzK(zData)`) and returns a `result` union. Not classified, and our memory model speaks `mem_read_N`/`read_mem_word` directly, so we need a bridge.
5. `jump have_exception` — branches on a global exception flag. Exception state isn't modeled.
6. `jump zz4286 is zOkzIbzCUExecutionResultzK` — pattern match on a `result` union. `translate_path` only handles union dispatch at the *outer* variant level.
7. `extend_value(is_unsigned, bytes)` — runtime choice between `sign_extend` and `zero_extend` driven by a bool operand. Not classified.

Minimum work to land `ld` and `lw`:

- Classify `lteq_int` and i64↔i conversions. Treat `sail_assert` as a no-op.
- Add a `vmem_read` → `mem_read_N` bridge that (a) discards the access-type union tag, (b) assumes no exception (i.e. takes only the `Ok` arm).
- Handle the `Ok`/`Err` union pattern match either by pre-simplifying when one arm goes to an exception handler, or by emitting two rule variants.
- Handle `extend_value` by expanding to `ite` on the bool, or by emitting a dispatch on the param at rule-emit time.

Widths (for both `lw` and `ld`) come from the `p4 : i64` operand, so a single LOAD rule parameterized on `p4` covers both as long as our memory bridge can handle a variable `N` — or we emit N=4 and N=8 specializations.

## §STORE → `sd`, `sw` — SKIPPED

IR body at `rv64d.ir:251866`. Exact same blocker pattern as LOAD:

```
zlteq_int(p3, xlen_bytes)          ; width precondition
$zsail_assert(…)
zvmem_write(…, MemoryAccessType, …)  ; writes, returns result union
jump have_exception …
jump … is zOkzIbzCUExecutionResultzK
```

Same fixes as LOAD plus a `vmem_write` → `mem_write_N` bridge. Unlocking LOAD automatically unblocks ~90% of STORE.

## §JALR → `ret` — SKIPPED

IR body at `rv64d.ir:252696`. The very first statement is:

```
update_elp_state(p1)    ; CFI / shadow-stack / landing-pad tracking
```

`update_elp_state` is a side-effecting call on a Zicfilp-related CSR. Not classified. Beyond that, JALR also has the `have_exception`/result-union machinery that LOAD/STORE use, and calls `get_next_pc`/`handle_illegal`.

`ret` has an additional wrinkle: it's a pseudo-instruction (`jalr zero, 0(ra)`), not an IR variant of its own. So even when JALR translates, `ir_rule_for_opcode` will need a `ret` → `jalr` alias that binds `rd=zero`, `rs1=ra`, `imm=0`.

Minimum work to land `ret`:

- Stub `update_elp_state` as a no-op (Zicfilp is outside our observable equivalence notion).
- Classify `get_next_pc` / `get_arch_pc` (also responsible for blocking LUI and JAL — see the stderr log).
- Fix the same result-union/exception handling that LOAD/STORE need.
- Add `ret` → `jalr(zero, ra, 0)` alias in `ir_rule_for_opcode`.

LUI and JAL, which `foo` doesn't use, share the `get_arch_pc`/`get_next_pc` blocker with JALR and would come along for free.

## Priority ordering

In ascending order of blast radius (what unlocks the most instructions per unit of work):

1. **Fix ADDI first.** It's actively producing a broken rule that makes check-equiv queries malformed. Either teach variant discovery to follow inner `@neq` arms as sub-variants (real fix, unlocks all of ITYPE/RTYPE/BTYPE/UTYPE/SHIFTIWOP/SHIFTIOP), or reject the synthetic ADDI variant so it falls back cleanly.
2. **LOAD/STORE bridge.** The `lteq_int` + `sail_assert` + `vmem_read`/`vmem_write` + result-union + `extend_value` cluster. Unlocks `ld`, `lw`, `sd`, `sw` together — all four foo memory ops — plus C.LW/C.LD/C.SW/C.SD (see the stderr log, those are skipped on `creg2reg_idx` which is a second-order blocker behind LOAD/STORE).
3. **JALR + pseudo-insn alias.** Unlocks `ret`, plus LUI/JAL which share the `get_arch_pc`/`get_next_pc` classification.

Steps 2 and 3 share the `have_exception` / result-union infrastructure, so doing them together is cheaper than doing them separately.

## Appendix — full skipped-variant list from this run

See `/tmp/ricover_stderr.log` (339 lines, ~350 variants skipped out of 390). The frequency analysis of skip reasons is left for a follow-up, but the dominant ones in order of occurrence are:

- `unsupported IR type in SMT translation: Enum(…)` — inner-enum-dispatch families
- `get_sew((_ unit))` — vector instructions (SEW = standard element width)
- `lteq_int(…)` / `sub_atom(…)` / `mult_atom(…)` — integer-domain guards and arithmetic
- `creg2reg_idx(p…)` — compressed instructions (C.*)
- `count_ones` / `count_leading_zeros` / `count_trailing_zeros` / `rev8` / `carryless_mul` — Zbb/Zbc primitives
- Floating-point helpers (`_get_Fcsr_FRM`, `rF_or_X_*`, `select_instr_or_fcsr_rm`) — F/D/Zfh
- CSR / privilege-mode helpers (`eq_anything<EPrivilege%>`, `cur_privilege`) — system instructions
