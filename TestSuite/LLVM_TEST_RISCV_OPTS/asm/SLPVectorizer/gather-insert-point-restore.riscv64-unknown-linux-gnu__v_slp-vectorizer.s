# Source: SLPVectorizer/gather-insert-point-restore.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -240
	.cfi_def_cfa_offset 240
	lui	a1, 32
	addi	a1, a1, 1788
	add	a1, a0, a1
	sd	a1, 192(sp)                     # 8-byte Folded Spill
	lui	a1, 34
	addi	a1, a1, -1490
	add	a1, a0, a1
	sd	a1, 200(sp)                     # 8-byte Folded Spill
	lui	a1, 35
	addi	a1, a1, -672
	add	a1, a0, a1
	sd	a1, 208(sp)                     # 8-byte Folded Spill
	lui	a1, 36
	addi	a1, a1, 146
	add	a1, a0, a1
	sd	a1, 216(sp)                     # 8-byte Folded Spill
	lui	a1, 37
	addi	a1, a1, 964
	add	a1, a0, a1
	sd	a1, 224(sp)                     # 8-byte Folded Spill
	lui	a1, 38
	addi	a1, a1, 1782
	add	a0, a0, a1
	sd	a0, 232(sp)                     # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.cond5.us
	ld	a1, 232(sp)                     # 8-byte Folded Reload
	ld	a2, 224(sp)                     # 8-byte Folded Reload
	ld	a3, 216(sp)                     # 8-byte Folded Reload
	ld	a4, 208(sp)                     # 8-byte Folded Reload
	ld	a5, 200(sp)                     # 8-byte Folded Reload
	ld	a0, 192(sp)                     # 8-byte Folded Reload
	lhu	a0, 0(a0)
	sd	a0, 144(sp)                     # 8-byte Folded Spill
	lhu	a5, 0(a5)
	sd	a5, 152(sp)                     # 8-byte Folded Spill
	lhu	a4, 0(a4)
	sd	a4, 160(sp)                     # 8-byte Folded Spill
	lhu	a3, 0(a3)
	sd	a3, 168(sp)                     # 8-byte Folded Spill
	lhu	a2, 0(a2)
	sd	a2, 176(sp)                     # 8-byte Folded Spill
	lhu	a1, 0(a1)
	mv	a2, a1
	sd	a2, 184(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_3
# %bb.2:                                # %for.cond5.us
	ld	a0, 144(sp)                     # 8-byte Folded Reload
	sd	a0, 184(sp)                     # 8-byte Folded Spill
.LBB0_3:                                # %for.cond5.us
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	ld	a0, 184(sp)                     # 8-byte Folded Reload
	sd	a0, 128(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 136(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_5
# %bb.4:                                # %for.cond5.us
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	sd	a0, 136(sp)                     # 8-byte Folded Spill
.LBB0_5:                                # %for.cond5.us
	ld	a1, 160(sp)                     # 8-byte Folded Reload
	ld	a0, 136(sp)                     # 8-byte Folded Reload
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_7
# %bb.6:                                # %for.cond5.us
	ld	a0, 112(sp)                     # 8-byte Folded Reload
	sd	a0, 120(sp)                     # 8-byte Folded Spill
.LBB0_7:                                # %for.cond5.us
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	ld	a0, 120(sp)                     # 8-byte Folded Reload
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_9
# %bb.8:                                # %for.cond5.us
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	sd	a0, 104(sp)                     # 8-byte Folded Spill
.LBB0_9:                                # %for.cond5.us
	ld	a1, 160(sp)                     # 8-byte Folded Reload
	ld	a0, 104(sp)                     # 8-byte Folded Reload
	sd	a0, 80(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 88(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_11
# %bb.10:                               # %for.cond5.us
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	sd	a0, 88(sp)                      # 8-byte Folded Spill
.LBB0_11:                               # %for.cond5.us
	ld	a1, 168(sp)                     # 8-byte Folded Reload
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_13
# %bb.12:                               # %for.cond5.us
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	sd	a0, 72(sp)                      # 8-byte Folded Spill
.LBB0_13:                               # %for.cond5.us
	ld	a1, 176(sp)                     # 8-byte Folded Reload
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_15
# %bb.14:                               # %for.cond5.us
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a0, 56(sp)                      # 8-byte Folded Spill
.LBB0_15:                               # %for.cond5.us
	ld	a1, 144(sp)                     # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_17
# %bb.16:                               # %for.cond5.us
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a0, 40(sp)                      # 8-byte Folded Spill
.LBB0_17:                               # %for.cond5.us
	ld	a1, 152(sp)                     # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_19
# %bb.18:                               # %for.cond5.us
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
.LBB0_19:                               # %for.cond5.us
	ld	a1, 176(sp)                     # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_21
# %bb.20:                               # %for.cond5.us
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
.LBB0_21:                               # %for.cond5.us
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 240
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	csrr	a1, vlenb
	slli	a1, a1, 1
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 2 * vlenb
	lui	a1, 34
	addi	a1, a1, -1490
                                        # implicit-def: $v8m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vmv.v.x	v8, a1
                                        # implicit-def: $v0
	vsetivli	zero, 1, e8, mf8, tu, ma
	vmv.v.i	v0, 5
	lui	a1, 32
	addi	a1, a1, 1788
                                        # implicit-def: $v10m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vmerge.vxm	v10, v8, a1, v0
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vadd.vx	v8, v10, a0
	addi	a1, sp, 32
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	lui	a1, 35
	addi	a1, a1, -672
	add	a0, a0, a1
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.cond5.us
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 32
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
	lui	a1, 1
	addi	a1, a1, 818
                                        # implicit-def: $v9
	vsetvli	zero, zero, e16, mf2, tu, ma
	vlse16.v	v9, (a0), a1
	li	a0, 0
                                        # implicit-def: $v8
	vluxei64.v	v8, (a0), v10
	vsetivli	zero, 8, e16, m1, ta, ma
	vslideup.vi	v9, v8, 4
                                        # implicit-def: $v8
	vredmaxu.vs	v8, v9, v9
	vmv.x.s	a0, v8
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	sp, sp, a1
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
