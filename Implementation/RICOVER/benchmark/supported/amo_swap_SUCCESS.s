# AMO instruction equivalence — verifies that amoswap.w is correctly
# modeled as an atomic read-modify-write sequence.
#
# `src` uses amoswap.w which atomically swaps the register value with
# memory. `tgt` performs the same operation with separate load/store.
# Under our single-threaded execution model, these are equivalent.
#
# Run:
#   cargo run -- check-equiv \
#     --before benchmark/supported/amo_swap_SUCCESS.s \
#     --after  benchmark/supported/amo_swap_SUCCESS.s \
#     --before-fn src --after-fn tgt \
#     -f amo_swap \
#     --ir snapshot/rv64d.ir \
#     -o /tmp/amo_swap.smt2
#   z3 /tmp/amo_swap.smt2
#
# Expected: unsat   (the two programs are equivalent)

src:
    amoswap.w a0, a1, (a2)
    ret

tgt:
    lw a0, 0(a2)
    sw a1, 0(a2)
    ret
