# Source: PhaseOrdering/any-of-vectorization.riscv64__v_default_O2__function_riscv-codegenprepare_.ll
# Function: f
# src = pre-opt (f), tgt = post-opt (f)
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
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	sext.w	a0, a1
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	li	a1, 0
	mv	a2, a1
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB0_4
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sext.w	a2, a2
	slli	a2, a2, 2
	add	a0, a0, a2
	lw	a0, 0(a0)
	li	a2, 1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_3
# %bb.2:                                # %loop
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
.LBB0_3:                                # %loop
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	addiw	a0, a0, 1
	sext.w	a1, a1
	mv	a3, a0
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_4
.LBB0_4:                                # %exit
	ld	a0, 56(sp)                      # 8-byte Folded Reload
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
# %bb.0:                                # %entry
	addi	sp, sp, -64
	csrr	a2, vlenb
	slli	a2, a2, 1
	sub	sp, sp, a2
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	sext.w	a0, a1
	sd	a1, 48(sp)                      # 8-byte Folded Spill
	li	a1, 0
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	beqz	a0, .LBB0_4
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	slli	a0, a0, 32
	srli	a0, a0, 32
                                        # implicit-def: $v8
	vsetvli	a1, zero, e8, mf2, tu, ma
	vmv.v.i	v8, 0
	li	a1, 0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 64
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a3, 40(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 64
	vl1r.v	v8, (a2)                        # vscale x 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	slli	a4, a1, 2
	add	a3, a3, a4
                                        # implicit-def: $v10m2
	vsetvli	zero, a2, e32, m2, tu, ma
	vle32.v	v10, (a3)
	vsetvli	a3, zero, e32, m2, ta, ma
	vmseq.vi	v0, v10, 0
	vsetvli	zero, a2, e8, mf2, tu, ma
	vmerge.vim	v8, v8, 1, v0
                                        # implicit-def: $v9
	vsetvli	a3, zero, e8, mf2, ta, ma
	vand.vi	v9, v8, 1
	vmsne.vi	v9, v9, 0
	addi	a3, sp, 64
	vs1r.v	v9, (a3)                        # vscale x 8-byte Folded Spill
	add	a1, a1, a2
	sub	a0, a0, a2
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 64
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %exit.loopexit
	addi	a0, sp, 64
	vl1r.v	v8, (a0)                        # vscale x 8-byte Folded Reload
	vcpop.m	a0, v8
	snez	a0, a0
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_4
.LBB0_4:                                # %exit
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	sp, sp, a1
	addi	sp, sp, 64
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
                                        # -- End function
