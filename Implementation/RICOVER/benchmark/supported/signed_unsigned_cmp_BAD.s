# Signed-vs-unsigned comparison miscompile.
#
# Bug class: an optimization rewrites a *signed* less-than into an
# *unsigned* less-than (or fails to pick the signed comparison when
# lowering `icmp slt`). This is one of the most common signedness bugs
# Alive2 catches.
#
# LLVM-IR (conceptual):
#   define i1 @src(i64 %x, i64 %y) { %r = icmp slt i64 %x, %y  ret i1 %r }
#   define i1 @tgt(i64 %x, i64 %y) { %r = icmp ult i64 %x, %y  ret i1 %r }  ; BUGGY
#
# `src` uses `slt` (signed), `tgt` uses `sltu` (unsigned). They agree
# whenever both operands have the same sign bit, but diverge as soon as
# exactly one is negative.
#
# Counterexample: x = -1 (0xFFFF...FF), y = 0
#   src:  slt  -1, 0  -> 1   (signed: -1 < 0 is true)
#   tgt:  sltu -1, 0  -> 0   (unsigned: 2^64-1 < 0 is false)
#
# Run:
#   ./run_bench.py supported/signed_unsigned_cmp_BAD.s
#
# Expected: sat   (the two programs are NOT equivalent)

src:
    slt  a0, a0, a1
    ret

tgt:
    sltu a0, a0, a1
    ret
