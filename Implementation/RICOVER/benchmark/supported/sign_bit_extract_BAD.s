# Logical-vs-arithmetic shift miscompile (lshr -> ashr).
#
# Bug class: extracting the sign bit of a 64-bit value is `lshr x, 63`,
# which yields 0 or 1. An optimization that rewrites this to `ashr x, 63`
# (arithmetic shift) instead yields 0 or -1 (all ones). The two agree for
# non-negative inputs but diverge for every negative input.
#
# LLVM-IR (conceptual):
#   define i64 @src(i64 %x) { %r = lshr i64 %x, 63  ret i64 %r }
#   define i64 @tgt(i64 %x) { %r = ashr i64 %x, 63  ret i64 %r }  ; BUGGY
#
# `src` uses `srli` (logical), `tgt` uses `srai` (arithmetic).
#
# Counterexample: x = -1 (0xFFFF...FF), i.e. any x with the sign bit set
#   src:  srli -> 0x0000000000000001
#   tgt:  srai -> 0xFFFFFFFFFFFFFFFF
#
# Run:
#   ./run_bench.py supported/sign_bit_extract_BAD.s
#
# Expected: sat   (the two programs are NOT equivalent)

src:
    srli a0, a0, 63
    ret

tgt:
    srai a0, a0, 63
    ret
