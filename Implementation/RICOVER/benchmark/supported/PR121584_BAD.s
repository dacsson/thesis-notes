# 1. Bug issue: https://github.com/llvm/llvm-project/issues/121584
#    [InstCombine] Miscompilation in `simplifyIRemMulShl`
#
# 2. Alive2 output: https://alive2.llvm.org/ce/z/rdeehL  (Transformation doesn't verify!)
#
# 3. LLVM-IR source:
#
#    define i8 @src(i8 noundef %X) {
#      %BO0 = mul nsw i8 %X, 127
#      %BO1 = shl nsw i8 %X, 7
#      %r   = srem i8 %BO1, %BO0
#      ret i8 %r
#    }
#    =>
#    define i8 @tgt(i8 noundef %X) {           ; BUGGY
#      %r = sub nsw i8 0, %X
#      ret i8 %r
#    }
#
#    InstCombine's simplifyIRemMulShl folds `srem (X<<7), (X*127)` to `-X`,
#    but the fold is unsound: srem(X<<7, X*127) != -X.
#
# 4. ERROR: Value mismatch
#    i8 %X = #xff (-1)
#      Source: srem(-1<<7, -1*127) = srem(-128, -127) = -1   (#xff)
#      Target: 0 - (-1)            = 1                        (#x01)
#
# RISC-V lowering — i8 values held sign-extended in 64-bit registers, so
# every i8 result is re-narrowed with `slli/srai 56` (the byte-sized analogue
# of the slli/srai 56 sequences in bench1_BAD.s).
#
# Run:
#   ./run_bench.py supported/PR121584_BAD.s
#
# Expected: sat   (the two programs are NOT equivalent)

src:                        # @src — srem(X<<7, X*127)
    li    a1, 127
    mul   a2, a0, a1        # a2 = X * 127
    slli  a2, a2, 56
    srai  a2, a2, 56        # a2 = sext8(X*127)   = BO0
    slli  a3, a0, 7         # a3 = X << 7
    slli  a3, a3, 56
    srai  a3, a3, 56        # a3 = sext8(X<<7)    = BO1
    rem   a0, a3, a2        # a0 = srem(BO1, BO0)
    slli  a0, a0, 56
    srai  a0, a0, 56        # a0 = sext8(r)
    ret

tgt:                        # @tgt — 0 - X   (BUGGY fold)
    sub   a0, zero, a0      # a0 = -X
    slli  a0, a0, 56
    srai  a0, a0, 56        # a0 = sext8(-X)
    ret
