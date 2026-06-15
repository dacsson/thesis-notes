# Flipped branch condition: min(x,y) miscompiled to max(x,y).
#
# Bug class: a branch-condition rewrite (e.g. canonicalizing a compare and
# forgetting to swap the arms) turns a signed-min select into a signed-max.
# This is the control-flow analogue of the select-operand bug in
# PR44306_BAD.s.
#
# LLVM-IR (conceptual):
#   define i64 @src(i64 %x, i64 %y) { %c = icmp slt i64 %x,%y  %r = select i1 %c, i64 %x, i64 %y  ret i64 %r }  ; min
#   define i64 @tgt(i64 %x, i64 %y) { %c = icmp sge i64 %x,%y  %r = select i1 %c, i64 %x, i64 %y  ret i64 %r }  ; max, BUGGY
#
# `src` keeps x when x < y  (result = min).
# `tgt` keeps x when x >= y (result = max).
#
# Counterexample: x = 1, y = 2
#   src (min): 1
#   tgt (max): 2
#
# Run:
#   ./run_bench.py supported/min_to_max_BAD.s
#
# Expected: sat   (the two programs are NOT equivalent)

src:                        # @src — min(x, y)
    blt a0, a1, .Lsrc       # if x < y, a0 already holds x
    mv  a0, a1              # else a0 = y
.Lsrc:
    ret

tgt:                        # @tgt — max(x, y), BUGGY
    bge a0, a1, .Ltgt       # if x >= y, a0 already holds x
    mv  a0, a1              # else a0 = y
.Ltgt:
    ret
