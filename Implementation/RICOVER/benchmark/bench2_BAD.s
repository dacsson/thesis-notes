# 1. Bug PR: https://github.com/llvm/llvm-project/issues/45123
#
# 2. LLVM-IR source: https://godbolt.org/z/3M1svTG7j
#
#define float @src(float %a, float %b) {
#%nsz = fmul nsz float %a, %b
#%add = fadd float %nsz, 0.000000
#ret float %add
#}
#
#define float @tgt(float %a, float %b) {
#%nsz = fmul nsz float %a, %b
#ret float %nsz
#}
#
# 3. Alive2 output: ?
#
define float @fold_fadd_cannot_be_neg0_nsz_src_x_0(float %a, float %b) {
%nsz = fmul nsz float %a, %b
%add = fadd float %nsz, 0.000000
ret float %add
}
=>
define float @fold_fadd_cannot_be_neg0_nsz_src_x_0(float %a, float %b) {
%nsz = fmul nsz float %a, %b
ret float %nsz
}
Transformation doesn't verify!
ERROR: Value mismatch

Example:
float %a = #x01e21080 (0.000000000000?)
float %b = #x00225d01 (0.000000000000?)

Source:
float %nsz = #x80000000 (-0.0)
float %add = #x00000000 (+0.0)

Target:
float %nsz = #x80000000 (-0.0)
Source value: #x00000000 (+0.0)
Target value: #x80000000 (-0.0)

src:                                    # @src
        fmul.s  fa5, fa0, fa1
        fmv.w.x fa4, zero
        fadd.s  fa0, fa5, fa4
        ret

tgt:                                    # @tgt
        fmul.s  fa0, fa0, fa1
        ret