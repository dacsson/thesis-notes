# Source: SLPVectorizer/strided-stores-vectorized.riscv32-unknown-linux__v_slp-vectorizer_RV32.ll
# Function: store_reverse
# src = pre-opt (store_reverse), tgt = post-opt (store_reverse)
# Triple: riscv32-unknown-linux, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sw	a0, 48(sp)                      # 4-byte Folded Spill
	lw	a2, 0(a0)
	lw	a1, 4(a0)
	lw	a0, 64(a0)
	sll	a1, a1, a0
	not	a4, a0
	srli	a3, a2, 1
	srl	a3, a3, a4
	or	a1, a1, a3
	sll	a2, a2, a0
	sw	a2, 52(sp)                      # 4-byte Folded Spill
	addi	a0, a0, -32
	sw	a0, 56(sp)                      # 4-byte Folded Spill
	sw	a1, 60(sp)                      # 4-byte Folded Spill
	bltz	a0, .LBB0_2
# %bb.1:                                # %entry
	lw	a0, 52(sp)                      # 4-byte Folded Reload
	sw	a0, 60(sp)                      # 4-byte Folded Spill
.LBB0_2:                                # %entry
	lw	a0, 48(sp)                      # 4-byte Folded Reload
	lw	a2, 56(sp)                      # 4-byte Folded Reload
	lw	a3, 52(sp)                      # 4-byte Folded Reload
	lw	a1, 60(sp)                      # 4-byte Folded Reload
	srai	a2, a2, 31
	and	a2, a2, a3
	sw	a2, 56(a0)
	sw	a1, 60(a0)
	lw	a2, 8(a0)
	lw	a1, 12(a0)
	lw	a0, 72(a0)
	sll	a1, a1, a0
	not	a4, a0
	srli	a3, a2, 1
	srl	a3, a3, a4
	or	a1, a1, a3
	sll	a2, a2, a0
	sw	a2, 36(sp)                      # 4-byte Folded Spill
	addi	a0, a0, -32
	sw	a0, 40(sp)                      # 4-byte Folded Spill
	sw	a1, 44(sp)                      # 4-byte Folded Spill
	bltz	a0, .LBB0_4
# %bb.3:                                # %entry
	lw	a0, 36(sp)                      # 4-byte Folded Reload
	sw	a0, 44(sp)                      # 4-byte Folded Spill
.LBB0_4:                                # %entry
	lw	a0, 48(sp)                      # 4-byte Folded Reload
	lw	a2, 40(sp)                      # 4-byte Folded Reload
	lw	a3, 36(sp)                      # 4-byte Folded Reload
	lw	a1, 44(sp)                      # 4-byte Folded Reload
	srai	a2, a2, 31
	and	a2, a2, a3
	sw	a2, 48(a0)
	sw	a1, 52(a0)
	lw	a2, 16(a0)
	lw	a1, 20(a0)
	lw	a0, 80(a0)
	sll	a1, a1, a0
	not	a4, a0
	srli	a3, a2, 1
	srl	a3, a3, a4
	or	a1, a1, a3
	sll	a2, a2, a0
	sw	a2, 24(sp)                      # 4-byte Folded Spill
	addi	a0, a0, -32
	sw	a0, 28(sp)                      # 4-byte Folded Spill
	sw	a1, 32(sp)                      # 4-byte Folded Spill
	bltz	a0, .LBB0_6
# %bb.5:                                # %entry
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	sw	a0, 32(sp)                      # 4-byte Folded Spill
.LBB0_6:                                # %entry
	lw	a0, 48(sp)                      # 4-byte Folded Reload
	lw	a2, 28(sp)                      # 4-byte Folded Reload
	lw	a3, 24(sp)                      # 4-byte Folded Reload
	lw	a1, 32(sp)                      # 4-byte Folded Reload
	srai	a2, a2, 31
	and	a2, a2, a3
	sw	a2, 40(a0)
	sw	a1, 44(a0)
	lw	a2, 24(a0)
	lw	a1, 28(a0)
	lw	a0, 88(a0)
	sll	a1, a1, a0
	not	a4, a0
	srli	a3, a2, 1
	srl	a3, a3, a4
	or	a1, a1, a3
	sll	a2, a2, a0
	sw	a2, 12(sp)                      # 4-byte Folded Spill
	addi	a0, a0, -32
	sw	a0, 16(sp)                      # 4-byte Folded Spill
	sw	a1, 20(sp)                      # 4-byte Folded Spill
	bltz	a0, .LBB0_8
# %bb.7:                                # %entry
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	sw	a0, 20(sp)                      # 4-byte Folded Spill
.LBB0_8:                                # %entry
	lw	a1, 48(sp)                      # 4-byte Folded Reload
	lw	a2, 16(sp)                      # 4-byte Folded Reload
	lw	a3, 12(sp)                      # 4-byte Folded Reload
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	srai	a2, a2, 31
	and	a2, a2, a3
	sw	a2, 32(a1)
	sw	a0, 36(a1)
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
	mv	a2, a0
	addi	a1, a2, 64
	addi	a0, a2, 56
                                        # implicit-def: $v10m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vle64.v	v10, (a2)
                                        # implicit-def: $v12m2
	vle64.v	v12, (a1)
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vsll.vv	v8, v10, v12
	li	a1, -8
	vsse64.v	v8, (a0), a1
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
