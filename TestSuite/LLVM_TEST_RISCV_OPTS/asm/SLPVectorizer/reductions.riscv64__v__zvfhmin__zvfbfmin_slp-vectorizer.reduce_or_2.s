# Source: SLPVectorizer/reductions.riscv64__v__zvfhmin__zvfbfmin_slp-vectorizer.ll
# Function: reduce_or_2
# src = pre-opt (reduce_or_2), tgt = post-opt (reduce_or_2)
# Triple: riscv64, Attrs: +v,+zvfhmin,+zvfbfmin
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_1
.LBB7_1:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_2
.LBB7_2:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_3
.LBB7_3:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_4
.LBB7_4:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_5
.LBB7_5:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_6
.LBB7_6:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_7
.LBB7_7:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_8
.LBB7_8:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_9
.LBB7_9:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_10
.LBB7_10:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_11
.LBB7_11:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_12
.LBB7_12:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_13
.LBB7_13:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_14
.LBB7_14:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_15
.LBB7_15:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_16
.LBB7_16:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_17
.LBB7_17:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_18
.LBB7_18:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_19
.LBB7_19:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_20
.LBB7_20:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_21
.LBB7_21:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_22
.LBB7_22:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_23
.LBB7_23:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_24
.LBB7_24:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_25
.LBB7_25:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_26
.LBB7_26:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_27
.LBB7_27:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_28
.LBB7_28:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_29
.LBB7_29:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_30
.LBB7_30:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_31
.LBB7_31:
	li	a0, 0
	bnez	a0, .LBB7_33
	j	.LBB7_32
.LBB7_32:
	ret
.LBB7_33:
	ret
.Lfunc_end7:
	.size	src, .Lfunc_end7-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	vsetivli	zero, 16, e8, m1, ta, ma
	vmclr.m	v8
	vcpop.m	a0, v8
	bnez	a0, .LBB7_2
	j	.LBB7_1
.LBB7_1:
	ret
.LBB7_2:
	ret
.Lfunc_end7:
	.size	tgt, .Lfunc_end7-tgt
	.cfi_endproc
                                        # -- End function
