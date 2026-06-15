# Source: LoopVectorize/predicated-reverse-store.riscv64-unknown-linux-gnu_loop-vectorize.ll
# Function: reverse_predicated_store
# src = pre-opt (reverse_predicated_store), tgt = post-opt (reverse_predicated_store)
# Triple: riscv64-unknown-linux-gnu, Attrs: none
#

	.globl	src                             # -- Begin function src
	.p2align	1
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	addi	a1, a1, -1
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	andi	a0, a0, 1
	beqz	a0, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	sh2add	a1, a0, a1
	li	a0, 0
	sw	a0, 0(a1)
	j	.LBB0_3
.LBB0_3:                                # %loop.latch
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_1
	j	.LBB0_4
.LBB0_4:                                # %exit
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

	.globl	tgt                             # -- Begin function tgt
	.p2align	1
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	csrr	a3, vlenb
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 1 * vlenb
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	addi	a0, a2, 1
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	andi	a1, a1, 1
                                        # implicit-def: $v8
	vsetvli	a2, zero, e8, mf2, tu, ma
	vmv.v.x	v8, a1
	vsetvli	zero, zero, e8, mf2, ta, ma
	vmsne.vi	v8, v8, 0
	addi	a1, sp, 64
	vs1r.v	v8, (a1)                        # vscale x 8-byte Folded Spill
	li	a1, 0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	ld	a4, 40(sp)                      # 8-byte Folded Reload
	ld	a5, 32(sp)                      # 8-byte Folded Reload
	addi	a2, sp, 64
	vl1r.v	v0, (a2)                        # vscale x 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	not	a3, a1
	add	a3, a3, a5
	sh2add	a3, a3, a4
                                        # implicit-def: $v8m2
	vsetvli	a4, zero, e32, m2, tu, ma
	vmv.v.i	v8, 0
	li	a4, -4
	vsetvli	zero, a2, e32, m2, ta, ma
	vsse32.v	v8, (a3), a4, v0.t
	add	a1, a1, a2
	sub	a0, a0, a2
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.LBB0_4:                                # %exit
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
