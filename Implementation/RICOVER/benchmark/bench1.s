# 1. Bug PR: https://github.com/llvm/llvm-project/issues/39208
#
# 2. LLVM-IR source:
#
# define i1 @src(i8 %x, i8 %y) {
#     %tmp0 = lshr i8 255, %y
#     %tmp1 = and i8 %tmp0, %x
#     %ret = icmp sge i8 %tmp1, %x
#     ret i1 %ret
# }
#
# define i1 @tgt(i8 %x, i8 %y) {
#     %tmp0 = lshr i8 255, %y
#     %1 = icmp sge i8 %tmp0, %x
#     ret i1 %1
# }
#
# 3. Alive2 output:
#
# define i1 @src(i8 %x, i8 %y) {
# #0:
#   %tmp0 = lshr i8 255, %y
#   %tmp1 = and i8 %tmp0, %x
#   %ret = icmp sge i8 %tmp1, %x
#   ret i1 %ret
# }
# =>
# define i1 @tgt(i8 %x, i8 %y) {
# #0:
#   %tmp0 = lshr i8 255, %y
#   %#1 = icmp sge i8 %tmp0, %x
#   ret i1 %#1
# }
# Transformation doesn't verify!
#
# ERROR: Value mismatch
#
# Example:
# i8 %x = #x00 (0)
# i8 %y = #x00 (0)
#
# Source:
# i8 %tmp0 = #xff (255, -1)
# i8 %tmp1 = #x00 (0)
# i1 %ret = #x1 (1)
#
# Target:
# i8 %tmp0 = #xff (255, -1)
# i1 %#1 = #x0 (0)
# Source value: #x1 (1)
# Target value: #x0 (0)

src:                                    # @src
    slli    a2, a0, 56
    sll     a0, a0, a1
    srai    a2, a2, 56
    zext.b  a0, a0
    srl     a0, a0, a1
    slli    a0, a0, 56
    srai    a0, a0, 56
    slt     a0, a0, a2
    xori    a0, a0, 1
    ret

tgt:                                    # @tgt
    slli    a0, a0, 56
    li      a2, 255
    srai    a0, a0, 56
    srl     a1, a2, a1
    slli    a1, a1, 56
    srai    a1, a1, 56
    slt     a0, a1, a0
    xori    a0, a0, 1
    ret
