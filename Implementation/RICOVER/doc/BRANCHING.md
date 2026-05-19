# Per-Block CHC Encoding for Branches and Loops

## Motivation

RICOVER encodes assembly programs as Constrained Horn Clauses (CHC) and asks a solver whether two programs can diverge. Straight-line code maps naturally to a single CHC rule chaining instruction relations. Branches and loops require a richer encoding.

A per-block encoding — where each basic block is its own CHC relation and control flow is expressed through composition rules — handles both forward branches and loops. Loops become recursive rules, which is exactly what CHC solvers (Z3/Spacer, Eldarica) are designed to solve via fixpoint computation and invariant discovery.

## Encoding overview

Given a function with basic blocks, the encoding produces two layers of CHC relations:

1. **Block body** `<func>_bb<N>(state_in, state_out)` — chains the block's data instructions (everything except the branch terminator, if any).
2. **Composition** `<func>_from_bb<N>(state_in, state_out)` — means "starting at block N, the function eventually reaches an exit with `state_out`". The entry block's composition relation IS the function summary `<func>(state_in, state_out)`.

### Naming convention

All relation names are prefixed with the function name to avoid collisions between `src` and `tgt` (which are suffixed as `src1`, `tgt2` by the equivalence emitter):

| Relation | Name | Example |
|---|---|---|
| Block body | `<func>_bb<N>` | `src1_bb0`, `tgt2_bb1` |
| Composition | `<func>_from_bb<N>` | `src1_from_bb1` |
| Function summary | `<func>` (= entry composition) | `src1` |

### Rule shapes by terminator type

**Exit block** (ends with `ret` or is the last block):
```smt2
(rule (=> (func_bb2 in out) (func_from_bb2 in out)))
```

**Fallthrough block** (falls through to the next block):
```smt2
(rule (=> (and (func_bb1 in mid) (func_from_bb2 mid out))
          (func_from_bb1 in out)))
```

**Branch block** (conditional branch — two rules, one per path):
```smt2
;; taken path
(rule (=> (and (func_bb0 in mid) <cond> (func_from_bb2 mid out))
          (func in out)))
;; fallthrough path
(rule (=> (and (func_bb0 in mid) (not <cond>) (func_from_bb1 mid out))
          (func in out)))
```

The branch condition `<cond>` reads registers from the block body's output state (`mid`), since the branch evaluates after the block's data instructions execute.

### Loop support

A back-edge creates a recursive composition rule. For a loop header at `bb1` with body `bb2` and exit at `bb3`:

```smt2
;; continue: header → body → back to header (recursive)
(rule (=> (and (func_bb1 in mid) <cond>
               (func_from_bb2 mid mid2) (func_from_bb1 mid2 out))
          (func_from_bb1 in out)))
;; exit
(rule (=> (and (func_bb1 in mid) (not <cond>) (func_from_bb3 mid out))
          (func_from_bb1 in out)))
```

The CHC solver discovers a loop invariant for `func_from_bb1` that is strong enough to prove (or disprove) equivalence.

## Concrete example

Assembly (PR44306 `src`):
```asm
    lw      a3, 0(a2)        ; bb0
    lw      a4, 0(a1)        ; bb0
    blt     a3, a4, .LBB0_2  ; bb0 terminator
    mv      a1, a2           ; bb1
.LBB0_2:
    ld      a1, 0(a1)        ; bb2
    sd      a1, 0(a0)        ; bb2
    ret                      ; bb2
```

CFG:
```
bb0 [lw, lw] --taken(a3<a4)--> bb2 [ld, sd, ret]
              \--fallthrough--> bb1 [mv] --> bb2
```

Generated CHC (simplified):
```smt2
;; Block bodies
(declare-rel src1_bb0 (State State))   ; lw a3; lw a4
(declare-rel src1_bb1 (State State))   ; mv a1, a2
(declare-rel src1_bb2 (State State))   ; ld a1; sd a1; ret

;; Composition declarations (all up front for Z3)
(declare-rel src1 (State State))
(declare-rel src1_from_bb1 (State State))
(declare-rel src1_from_bb2 (State State))

;; Exit: bb2 body IS the from-bb2-to-exit path
(rule (=> (src1_bb2 in out) (src1_from_bb2 in out)))

;; Fallthrough: bb1 → bb2
(rule (=> (and (src1_bb1 in mid) (src1_from_bb2 mid out))
          (src1_from_bb1 in out)))

;; Branch: bb0 → taken(bb2) or fallthrough(bb1)
(rule (=> (and (src1_bb0 in mid)
               (bvslt (get_reg mid a3) (get_reg mid a4))
               (src1_from_bb2 mid out))
          (src1 in out)))
(rule (=> (and (src1_bb0 in mid)
               (not (bvslt (get_reg mid a3) (get_reg mid a4)))
               (src1_from_bb1 mid out))
          (src1 in out)))
```

## Straight-line code

Functions without branches degenerate to one block and one composition rule — effectively the same as a single monolithic rule:

```smt2
(declare-rel func_bb0 (State State))
(declare-rel func (State State))
(rule (=> (and (instr1 ...) ... (instrN ...)) (func_bb0 in out)))
(rule (=> (func_bb0 in out) (func in out)))
```

## Implementation

- **`asm_parse.rs`**: `build_cfg()` splits a parsed function into `BasicBlock`s with `Terminator` variants (`Branch`, `Fallthrough`, `Exit`). Block boundaries are placed at label targets and after branch instructions.
- **`asm_emit.rs`**: `emit_program_rule()` calls `build_cfg`, then emits block body rules (`emit_block_body_rule`) and composition rules (`emit_composition_rules`). All `declare-rel` statements are emitted before any rules to satisfy Z3's forward-reference constraint.
