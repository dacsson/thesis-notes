# Source: LoopVectorize/tail-folding-reduction.riscv64__v__f_loop-vectorize_IF-EVL.ll
# Function: fminimum
# src = pre-opt (fminimum), tgt = post-opt (fminimum)
# Triple: riscv64, Attrs: +v,+f
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	fsw	fa0, 60(sp)                     # 4-byte Folded Spill
	j	.LBB13_1
.LBB13_1:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	flw	fa5, 60(sp)                     # 4-byte Folded Reload
	fsw	fa5, 12(sp)                     # 4-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 2
	add	a0, a0, a1
	flw	fa4, 0(a0)
	fsw	fa4, 24(sp)                     # 4-byte Folded Spill
	feq.s	a0, fa4, fa4
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
	bnez	a0, .LBB13_3
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB13_1 Depth=1
	flw	fa5, 24(sp)                     # 4-byte Folded Reload
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
.LBB13_3:                               # %for.body
                                        #   in Loop: Header=BB13_1 Depth=1
	flw	fa5, 24(sp)                     # 4-byte Folded Reload
	flw	fa4, 12(sp)                     # 4-byte Folded Reload
	flw	fa3, 28(sp)                     # 4-byte Folded Reload
	fsw	fa3, 4(sp)                      # 4-byte Folded Spill
	feq.s	a0, fa4, fa4
	fsw	fa5, 8(sp)                      # 4-byte Folded Spill
	bnez	a0, .LBB13_5
# %bb.4:                                # %for.body
                                        #   in Loop: Header=BB13_1 Depth=1
	flw	fa5, 12(sp)                     # 4-byte Folded Reload
	fsw	fa5, 8(sp)                      # 4-byte Folded Spill
.LBB13_5:                               # %for.body
                                        #   in Loop: Header=BB13_1 Depth=1
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	flw	fa5, 4(sp)                      # 4-byte Folded Reload
	flw	fa4, 8(sp)                      # 4-byte Folded Reload
	fmin.s	fa5, fa5, fa4
	fsw	fa5, 0(sp)                      # 4-byte Folded Spill
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	fsw	fa5, 60(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB13_1
	j	.LBB13_6
.LBB13_6:                               # %for.end
	flw	fa0, 0(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end13:
	.size	src, .Lfunc_end13-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -128
	.cfi_def_cfa_offset 128
	csrr	a2, vlenb
	slli	a2, a2, 3
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0x80, 0x01, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 128 + 8 * vlenb
	fsw	fa0, 92(sp)                     # 4-byte Folded Spill
	sd	a1, 96(sp)                      # 8-byte Folded Spill
	sd	a0, 104(sp)                     # 8-byte Folded Spill
	li	a2, 0
	li	a0, 16
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	fsw	fa0, 124(sp)                    # 4-byte Folded Spill
	bltu	a1, a0, .LBB13_6
	j	.LBB13_1
.LBB13_1:                               # %vector.ph
	flw	fa5, 92(sp)                     # 4-byte Folded Reload
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	andi	a0, a0, -16
	sd	a0, 72(sp)                      # 8-byte Folded Spill
                                        # implicit-def: $v8m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vfmv.v.f	v8, fa5
	li	a0, 0
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	vmv2r.v	v10, v8
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	a0, sp, a0
	addi	a0, a0, 128
	vs2r.v	v10, (a0)                       # vscale x 16-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	mv	a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	a0, sp, a0
	addi	a0, a0, 128
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	j	.LBB13_2
.LBB13_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	ld	a2, 104(sp)                     # 8-byte Folded Reload
	csrr	a3, vlenb
	slli	a3, a3, 1
	mv	a4, a3
	slli	a3, a3, 1
	add	a3, a3, a4
	add	a3, sp, a3
	addi	a3, a3, 128
	vl2r.v	v8, (a3)                        # vscale x 16-byte Folded Reload
	csrr	a3, vlenb
	slli	a3, a3, 2
	add	a3, sp, a3
	addi	a3, a3, 128
	vl2r.v	v10, (a3)                       # vscale x 16-byte Folded Reload
	slli	a3, a0, 2
	add	a3, a2, a3
	addi	a2, a3, 32
                                        # implicit-def: $v18m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vle32.v	v18, (a3)
                                        # implicit-def: $v16m2
	vle32.v	v16, (a2)
	vsetvli	zero, zero, e32, m2, ta, ma
	vmfeq.vv	v0, v18, v18
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmerge.vvm	v12, v18, v10, v0
	vsetvli	zero, zero, e32, m2, ta, ma
	vmfeq.vv	v0, v10, v10
                                        # implicit-def: $v14m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmerge.vvm	v14, v10, v18, v0
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vfmin.vv	v10, v12, v14
	addi	a2, sp, 128
	vs2r.v	v10, (a2)                       # vscale x 16-byte Folded Spill
	vmfeq.vv	v0, v16, v16
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmerge.vvm	v12, v16, v8, v0
	vsetvli	zero, zero, e32, m2, ta, ma
	vmfeq.vv	v0, v8, v8
                                        # implicit-def: $v14m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmerge.vvm	v14, v8, v16, v0
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vfmin.vv	v8, v12, v14
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 128
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	addi	a0, a0, 16
	mv	a2, a0
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 2
	add	a2, sp, a2
	addi	a2, a2, 128
	vs2r.v	v10, (a2)                       # vscale x 16-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	mv	a3, a2
	slli	a2, a2, 1
	add	a2, a2, a3
	add	a2, sp, a2
	addi	a2, a2, 128
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	bne	a0, a1, .LBB13_2
	j	.LBB13_3
.LBB13_3:                               # %middle.block
	addi	a0, sp, 128
	vl2r.v	v14, (a0)                       # vscale x 16-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, sp, a0
	addi	a0, a0, 128
	vl2r.v	v10, (a0)                       # vscale x 16-byte Folded Reload
	vmfeq.vv	v0, v14, v14
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmerge.vvm	v12, v14, v10, v0
	vsetvli	zero, zero, e32, m2, ta, ma
	vmfeq.vv	v0, v10, v10
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmerge.vvm	v8, v10, v14, v0
                                        # implicit-def: $v10m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vfmin.vv	v10, v8, v12
	vmv1r.v	v9, v10
                                        # implicit-def: $v8
	vfredmin.vs	v8, v10, v9
	vfmv.f.s	fa5, v8
	vmfne.vv	v8, v10, v10
	vcpop.m	a0, v8
	lui	a1, 523264
	fmv.w.x	fa4, a1
	fsw	fa4, 64(sp)                     # 4-byte Folded Spill
	fsw	fa5, 68(sp)                     # 4-byte Folded Spill
	beqz	a0, .LBB13_5
# %bb.4:                                # %middle.block
	flw	fa5, 64(sp)                     # 4-byte Folded Reload
	fsw	fa5, 68(sp)                     # 4-byte Folded Spill
.LBB13_5:                               # %middle.block
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	flw	fa5, 68(sp)                     # 4-byte Folded Reload
	mv	a2, a1
	sd	a2, 112(sp)                     # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 124(sp)                    # 4-byte Folded Spill
	fsw	fa5, 60(sp)                     # 4-byte Folded Spill
	beq	a0, a1, .LBB13_12
	j	.LBB13_6
.LBB13_6:                               # %scalar.ph
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	flw	fa5, 124(sp)                    # 4-byte Folded Reload
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	fsw	fa5, 56(sp)                     # 4-byte Folded Spill
	j	.LBB13_7
.LBB13_7:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	flw	fa5, 56(sp)                     # 4-byte Folded Reload
	fsw	fa5, 28(sp)                     # 4-byte Folded Spill
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 2
	add	a0, a0, a1
	flw	fa4, 0(a0)
	fsw	fa4, 40(sp)                     # 4-byte Folded Spill
	feq.s	a0, fa4, fa4
	fsw	fa5, 44(sp)                     # 4-byte Folded Spill
	bnez	a0, .LBB13_9
# %bb.8:                                # %for.body
                                        #   in Loop: Header=BB13_7 Depth=1
	flw	fa5, 40(sp)                     # 4-byte Folded Reload
	fsw	fa5, 44(sp)                     # 4-byte Folded Spill
.LBB13_9:                               # %for.body
                                        #   in Loop: Header=BB13_7 Depth=1
	flw	fa5, 40(sp)                     # 4-byte Folded Reload
	flw	fa4, 28(sp)                     # 4-byte Folded Reload
	flw	fa3, 44(sp)                     # 4-byte Folded Reload
	fsw	fa3, 20(sp)                     # 4-byte Folded Spill
	feq.s	a0, fa4, fa4
	fsw	fa5, 24(sp)                     # 4-byte Folded Spill
	bnez	a0, .LBB13_11
# %bb.10:                               # %for.body
                                        #   in Loop: Header=BB13_7 Depth=1
	flw	fa5, 28(sp)                     # 4-byte Folded Reload
	fsw	fa5, 24(sp)                     # 4-byte Folded Spill
.LBB13_11:                              # %for.body
                                        #   in Loop: Header=BB13_7 Depth=1
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	flw	fa5, 20(sp)                     # 4-byte Folded Reload
	flw	fa4, 24(sp)                     # 4-byte Folded Reload
	fmin.s	fa5, fa5, fa4
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	fmv.s	fa4, fa5
	fsw	fa4, 56(sp)                     # 4-byte Folded Spill
	fsw	fa5, 60(sp)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB13_7
	j	.LBB13_12
.LBB13_12:                              # %for.end
	flw	fa0, 60(sp)                     # 4-byte Folded Reload
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	sp, sp, a0
	.cfi_def_cfa sp, 128
	addi	sp, sp, 128
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end13:
	.size	tgt, .Lfunc_end13-tgt
	.cfi_endproc
                                        # -- End function
