# Dropped 32-bit sign-extension miscompile.
#
# Bug class: on RV64 every 32-bit (`*w`) result must be sign-extended into
# the full 64-bit register, and the i32 ABI requires that an `i32` value
# live in a register in sign-extended form. An optimization that lowers a
# 32-bit `add nsw i32 %x, 1` to a plain 64-bit `addi` drops both the 32-bit
# wraparound and the sign-extension.
#
# LLVM-IR (conceptual):
#   define i64 @src(i32 %x) { %a = add i32 %x, 1  %r = sext i32 %a to i64  ret i64 %r }
#   define i64 @tgt(i32 %x) { %r = add i64 (zext %x), 1                    ret i64 %r }  ; BUGGY
#
# `src` uses `addiw` (32-bit add, result sign-extended to 64 bits).
# `tgt` uses `addi` (full 64-bit add, no truncation/re-extension).
#
# Counterexample: x = 0x7FFFFFFF (INT32_MAX)
#   src:  addiw -> 0x80000000 truncated to i32, sign-extended -> 0xFFFFFFFF80000000
#   tgt:  addi  -> 0x0000000080000000
#
# Run:
#   ./run_bench.py supported/lost_sign_extend_BAD.s
#
# Expected: sat   (the two programs are NOT equivalent)

src:
    addiw a0, a0, 1
    ret

tgt:
    addi  a0, a0, 1
    ret
