# Compressed instruction equivalence — verifies that compressed (C_*)
# instructions are correctly expanded to their standard equivalents.
#
# `src` uses compressed instructions, `tgt` uses the standard equivalents.
# These are semantically identical.
#
# Run:
#   cargo run -- check-equiv \
#     --before benchmark/supported/compressed_equiv_SUCCESS.s \
#     --after  benchmark/supported/compressed_equiv_SUCCESS.s \
#     --before-fn src --after-fn tgt \
#     -f compressed_equiv \
#     --ir snapshot/rv64d.ir \
#     -o /tmp/compressed.smt2
#   z3 /tmp/compressed.smt2
#
# Expected: unsat   (the two programs are equivalent)

src:
    c.addi a0, 3
    c.mv a1, a0
    ret

tgt:
    addi a0, a0, 3
    add a1, zero, a0
    ret
