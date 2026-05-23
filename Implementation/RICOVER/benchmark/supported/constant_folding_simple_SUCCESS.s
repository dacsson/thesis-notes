# Constant folding — simple regression case.
#
# C source (conceptually):
#   int foo() {
#       int x = 1;
#       int y = x + 2;
#       return y;
#   }
#
# `src` is the unoptimized -O0 lowering with a stack frame, two stack slots,
# a load/store round-trip and a 32-bit add. `tgt` is the constant-folded
# lowering: a single `addi a0, zero, 3; ret`. The two functions are
# semantically equivalent under the ABI-register projection, so RICOVER
# should report UNSAT (no counterexample exists).
#
# Run:
#   cargo run -- check-equiv \
#     --before benchmark/constant_folding_simple_SUCCESS.s \
#     --after  benchmark/constant_folding_simple_SUCCESS.s \
#     --before-fn src --after-fn tgt \
#     -f constant_folding_simple \
#     --ir snapshot/rv64d.ir \
#     -o /tmp/cfs.smt2
#   z3 /tmp/cfs.smt2
#
# Expected: unsat   (the two programs are equivalent)

src:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    addi s0, sp, 32
    addi a0, zero, 1
    sw a0, -20(s0)
    lw a0, -20(s0)
    addiw a0, a0, 2
    sw a0, -24(s0)
    lw a0, -24(s0)
    ld ra, 24(sp)
    ld s0, 16(sp)
    addi sp, sp, 32
    ret

tgt:
    addi a0, zero, 3
    ret
