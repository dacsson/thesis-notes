# Source: SLPVectorizer/reductions.riscv64__v__zvfhmin__zvfbfmin_slp-vectorizer.ll
# Function: reduce_smin
# src = pre-opt (reduce_smin), tgt = post-opt (reduce_smin)
# Triple: riscv64, Attrs: +v,+zvfhmin,+zvfbfmin
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	lbu	a3, 0(a2)
	lbu	a0, 0(a1)
	and	a0, a0, a3
	slli	a0, a0, 56
	srai	a0, a0, 56
	lbu	a2, 1(a2)
	lbu	a1, 1(a1)
	and	a1, a1, a2
	slli	a1, a1, 56
	srai	a1, a1, 56
	sd	a1, 112(sp)                     # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	blt	a0, a1, .LBB10_2
# %bb.1:                                # %entry
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	sd	a0, 120(sp)                     # 8-byte Folded Spill
.LBB10_2:                               # %entry
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	lbu	a2, 2(a2)
	lbu	a1, 2(a1)
	and	a1, a1, a2
	slli	a1, a1, 56
	srai	a1, a1, 56
	sd	a1, 80(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB10_4
# %bb.3:                                # %entry
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 88(sp)                      # 8-byte Folded Spill
.LBB10_4:                               # %entry
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	lbu	a2, 3(a2)
	lbu	a1, 3(a1)
	and	a1, a1, a2
	slli	a1, a1, 56
	srai	a1, a1, 56
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB10_6
# %bb.5:                                # %entry
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a0, 72(sp)                      # 8-byte Folded Spill
.LBB10_6:                               # %entry
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	lbu	a2, 4(a2)
	lbu	a1, 4(a1)
	and	a1, a1, a2
	slli	a1, a1, 56
	srai	a1, a1, 56
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB10_8
# %bb.7:                                # %entry
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a0, 56(sp)                      # 8-byte Folded Spill
.LBB10_8:                               # %entry
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	lbu	a2, 5(a2)
	lbu	a1, 5(a1)
	and	a1, a1, a2
	slli	a1, a1, 56
	srai	a1, a1, 56
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB10_10
# %bb.9:                                # %entry
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a0, 40(sp)                      # 8-byte Folded Spill
.LBB10_10:                              # %entry
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	lbu	a2, 6(a2)
	lbu	a1, 6(a1)
	and	a1, a1, a2
	slli	a1, a1, 56
	srai	a1, a1, 56
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB10_12
# %bb.11:                               # %entry
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
.LBB10_12:                              # %entry
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	lbu	a2, 7(a2)
	lbu	a1, 7(a1)
	and	a1, a1, a2
	slli	a1, a1, 56
	srai	a1, a1, 56
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	blt	a0, a1, .LBB10_14
# %bb.13:                               # %entry
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
.LBB10_14:                              # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	src, .Lfunc_end10-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v10
	vsetivli	zero, 8, e8, mf2, tu, ma
	vle8.v	v10, (a0)
                                        # implicit-def: $v8
	vle8.v	v8, (a1)
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf2, ta, ma
	vand.vv	v9, v8, v10
	vmv1r.v	v10, v9
                                        # implicit-def: $v8
	vredmin.vs	v8, v9, v10
	vmv.x.s	a0, v8
	ret
.Lfunc_end10:
	.size	tgt, .Lfunc_end10-tgt
	.cfi_endproc
                                        # -- End function
