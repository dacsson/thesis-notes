# Source: LoopVectorize/iv-select-cmp.riscv64__v.ll
# Function: find_last_trunc_iv
# src = pre-opt (find_last_trunc_iv), tgt = post-opt (find_last_trunc_iv)
# Triple: riscv64, Attrs: +v
#

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
	li	a1, 0
	mv	a0, a1
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	slli	a2, a1, 2
	add	a0, a0, a2
	lw	a0, 0(a0)
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB0_3
# %bb.2:                                # %loop
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
.LBB0_3:                                # %loop
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	addi	a3, a0, 1
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_4
.LBB0_4:                                # %exit
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 64
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	csrr	a2, vlenb
	slli	a2, a2, 3
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 8 * vlenb
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	addi	a0, a1, 1
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	vsetvli	a1, zero, e8, mf2, ta, ma
	vmclr.m	v10
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmv.v.i	v12, 0
	li	a1, 0
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vid.v	v8
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 1
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v12, (a1)                       # vscale x 16-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 2
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs1r.v	v10, (a1)                       # vscale x 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	mv	a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 48(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 1
	mv	a4, a2
	slli	a2, a2, 1
	add	a2, a2, a4
	add	a2, sp, a2
	addi	a2, a2, 64
	vl2r.v	v14, (a2)                       # vscale x 16-byte Folded Reload
	csrr	a2, vlenb
	slli	a4, a2, 2
	add	a2, a4, a2
	add	a2, sp, a2
	addi	a2, a2, 64
	vl1r.v	v11, (a2)                       # vscale x 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a4, a2, 1
	add	a2, a4, a2
	add	a2, sp, a2
	addi	a2, a2, 64
	vl2r.v	v8, (a2)                        # vscale x 16-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	slli	a4, a1, 2
	add	a3, a3, a4
                                        # implicit-def: $v16m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vle32.v	v16, (a3)
	vsetvli	a3, zero, e32, m2, ta, ma
	vmseq.vi	v12, v16, 0
                                        # implicit-def: $v16m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vid.v	v16
	vmsltu.vx	v10, v16, a2
	vmand.mm	v10, v10, v12
	vcpop.m	a3, v10
	snez	a3, a3
                                        # implicit-def: $v12
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.v.x	v12, a3
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmsne.vi	v0, v12, 0
	vmand.mm	v10, v10, v0
	vmandn.mm	v11, v11, v0
	vmor.mm	v10, v10, v11
	addi	a3, sp, 64
	vs1r.v	v10, (a3)                       # vscale x 8-byte Folded Spill
                                        # implicit-def: $v12m2
	vsetvli	zero, zero, e32, m2, tu, ma
	vmerge.vvm	v12, v8, v14, v0
	csrr	a3, vlenb
	add	a3, sp, a3
	addi	a3, a3, 64
	vs2r.v	v12, (a3)                       # vscale x 16-byte Folded Spill
	add	a1, a2, a1
	sub	a0, a0, a2
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m2, ta, ma
	vadd.vx	v8, v14, a2
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 1
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v12, (a1)                       # vscale x 16-byte Folded Spill
	csrr	a1, vlenb
	slli	a2, a1, 2
	add	a1, a2, a1
	add	a1, sp, a1
	addi	a1, a1, 64
	vs1r.v	v10, (a1)                       # vscale x 8-byte Folded Spill
	csrr	a1, vlenb
	slli	a1, a1, 1
	mv	a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	add	a1, sp, a1
	addi	a1, a1, 64
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	mv	a1, a0
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	addi	a0, sp, 64
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 64
	vl2r.v	v12, (a0)                       # vscale x 16-byte Folded Reload
                                        # implicit-def: $v24m4
	vsetvli	zero, zero, e64, m4, ta, ma
	vid.v	v24
                                        # implicit-def: $v20m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vmv.v.i	v20, 0
	vmv1r.v	v0, v8
                                        # implicit-def: $v16m4
	vmerge.vvm	v16, v20, v24, v0
	vmv1r.v	v10, v16
                                        # implicit-def: $v9
	vsetvli	zero, zero, e64, m4, ta, ma
	vredmaxu.vs	v9, v16, v10
	vmv.x.s	a0, v9
                                        # implicit-def: $v10m2
	vsetivli	zero, 1, e32, m2, ta, ma
	vslidedown.vx	v10, v12, a0
	vmv1r.v	v9, v10
	vmv.x.s	a1, v9
	vsetvli	a0, zero, e8, mf2, ta, ma
	vcpop.m	a0, v8
	seqz	a0, a0
	addi	a0, a0, -1
	and	a0, a0, a1
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_4
.LBB0_4:                                # %exit
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 3
	add	sp, sp, a1
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
