# Source: LoopVectorize/pointer-induction.ll
# Function: ptr_induction
# src = pre-opt (ptr_induction), tgt = post-opt (ptr_induction)
# Triple: riscv64, Attrs: v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	li	a1, 0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	ld	a3, 24(sp)                      # 8-byte Folded Reload
	ld	a4, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 0(a4)
	sd	a2, 0(a3)
	addi	a3, a2, 1
	addi	a2, a0, 1
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %exit
	addi	sp, sp, 48
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
	csrr	a3, vlenb
	slli	a3, a3, 3
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 8 * vlenb
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	sub	a0, a2, a0
	addi	a0, a0, 1
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v8m2
	vsetvli	a3, zero, e64, m2, tu, ma
	vmv.v.x	v8, a2
	addi	a2, sp, 64
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
                                        # implicit-def: $v8m2
	vmv.v.x	v8, a1
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 64
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vid.v	v8
	csrr	a2, vlenb
	slli	a2, a2, 2
	add	a2, sp, a2
	addi	a2, a2, 64
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	csrr	a2, vlenb
	slli	a2, a2, 1
	mv	a3, a2
	slli	a2, a2, 1
	add	a2, a2, a3
	add	a2, sp, a2
	addi	a2, a2, 64
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 1
	mv	a3, a2
	slli	a2, a2, 1
	add	a2, a2, a3
	add	a2, sp, a2
	addi	a2, a2, 64
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, sp, a2
	addi	a2, a2, 64
	vl2r.v	v8, (a2)                        # vscale x 16-byte Folded Reload
	addi	a2, sp, 64
	vl2r.v	v14, (a2)                       # vscale x 16-byte Folded Reload
	csrr	a2, vlenb
	slli	a2, a2, 2
	add	a2, sp, a2
	addi	a2, a2, 64
	vl2r.v	v16, (a2)                       # vscale x 16-byte Folded Reload
                                        # implicit-def: $v12m2
	vadd.vx	v12, v16, a1
	vsetvli	a2, a0, e8, mf4, ta, ma
	li	a3, 0
	vsetvli	zero, a2, e64, m2, ta, ma
	vsoxei64.v	v12, (a3), v14
	vsetvli	zero, a2, e64, m2, ta, ma
	vsoxei64.v	v10, (a3), v8
	sub	a0, a0, a2
                                        # implicit-def: $v8m2
	vsetvli	a3, zero, e64, m2, ta, ma
	vadd.vx	v8, v10, a2
	add	a1, a1, a2
	csrr	a2, vlenb
	slli	a2, a2, 1
	mv	a3, a2
	slli	a2, a2, 1
	add	a2, a2, a3
	add	a2, sp, a2
	addi	a2, a2, 64
	vs2r.v	v8, (a2)                        # vscale x 16-byte Folded Spill
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %exit
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
