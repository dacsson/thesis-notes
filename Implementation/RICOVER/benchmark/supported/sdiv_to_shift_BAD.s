# Signed-division-to-shift miscompile:  sdiv X, 2  -->  ashr X, 1
#
# Provenance: this is the canonical *unsound* strength reduction (Alive2's
# standard teaching example, and a real historical compiler bug class).
# Unlike PR121584_BAD.s it is not tied to a single open LLVM issue — it is
# the textbook reason a correct compiler must NOT lower `sdiv X, 2^k` to a
# bare arithmetic shift, but instead add a rounding bias first:
#     sdiv X, 2^k  ==  ashr (X + ((X >>s 63) u>> (64-k))), k
#
# LLVM-IR (conceptual):
#   define i64 @src(i64 %x) { %r = sdiv i64 %x, 2  ret i64 %r }
#   define i64 @tgt(i64 %x) { %r = ashr i64 %x, 1  ret i64 %r }   ; BUGGY
#
# The two agree for non-negative X but diverge for negative odd X, because
# sdiv rounds toward zero while ashr rounds toward -infinity.
#
# Counterexample: x = -1
#   src:  sdiv(-1, 2) = 0    (rounds toward zero)
#   tgt:  ashr(-1, 1) = -1   (rounds toward -inf)
#
# Run:
#   ./run_bench.py supported/sdiv_to_shift_BAD.s
#
# Expected: sat   (the two programs are NOT equivalent)

src:                        # @src — sdiv X, 2
    li   a1, 2
    div  a0, a0, a1         # a0 = X /s 2   (signed division)
    ret

tgt:                        # @tgt — ashr X, 1   (BUGGY)
    srai a0, a0, 1          # a0 = X >>s 1  (arithmetic shift)
    ret
