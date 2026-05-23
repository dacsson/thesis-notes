# Source: ConstantHoisting/immediates.riscv32-unknown-elf_consthoist.ll
# Function: test4
# src = pre-opt (test4), tgt = post-opt (test4)
# Triple: riscv32-unknown-elf, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	addi	sp, sp, -32
	mv	a2, a1
	lw	a1, 12(a2)
	sw	a1, 4(sp)                       # 4-byte Folded Spill
	lw	a1, 8(a2)
	sw	a1, 8(sp)                       # 4-byte Folded Spill
	lw	a1, 4(a2)
	lw	a2, 0(a2)
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	lui	a0, 349260
	addi	a0, a0, -772
	add	a0, a2, a0
	sw	a0, 16(sp)                      # 4-byte Folded Spill
	sltu	a2, a0, a2
	add	a0, a1, a2
	lui	a3, 349525
	addi	a3, a3, 1365
	add	a0, a0, a3
	sw	a0, 20(sp)                      # 4-byte Folded Spill
	sltu	a3, a0, a1
	sw	a3, 24(sp)                      # 4-byte Folded Spill
	sw	a2, 28(sp)                      # 4-byte Folded Spill
	beq	a0, a1, .LBB3_2
# %bb.1:
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	sw	a0, 28(sp)                      # 4-byte Folded Spill
.LBB3_2:
	lw	a1, 12(sp)                      # 4-byte Folded Reload
	lw	a3, 20(sp)                      # 4-byte Folded Reload
	lw	a4, 16(sp)                      # 4-byte Folded Reload
	lw	a0, 4(sp)                       # 4-byte Folded Reload
	lw	a7, 8(sp)                       # 4-byte Folded Reload
	lw	a2, 28(sp)                      # 4-byte Folded Reload
	lui	a5, 326
	addi	a5, a5, -1963
	add	a6, a7, a5
	add	a2, a6, a2
	sltu	a5, a2, a6
	sltu	a6, a6, a7
	add	a0, a0, a6
	add	a0, a0, a5
	sw	a4, 0(a1)
	sw	a3, 4(a1)
	sw	a2, 8(a1)
	sw	a0, 12(a1)
	addi	sp, sp, 32
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	addi	sp, sp, -80
	mv	a2, a1
	lw	a1, 12(a2)
	sw	a1, 40(sp)                      # 4-byte Folded Spill
	lw	a1, 8(a2)
	sw	a1, 44(sp)                      # 4-byte Folded Spill
	lw	a1, 4(a2)
	lw	a2, 0(a2)
	sw	a0, 48(sp)                      # 4-byte Folded Spill
	lui	a0, 698918
	addi	a0, a0, -386
	sw	a0, 52(sp)                      # 4-byte Folded Spill
	add	a0, a2, a0
	sw	a0, 56(sp)                      # 4-byte Folded Spill
	sltu	a2, a0, a2
	add	a0, a1, a2
	sw	a0, 60(sp)                      # 4-byte Folded Spill
	lui	a3, 699051
	addi	a3, a3, -1366
	sw	a3, 64(sp)                      # 4-byte Folded Spill
	add	a0, a0, a3
	sw	a0, 68(sp)                      # 4-byte Folded Spill
	sltu	a3, a0, a1
	sw	a3, 72(sp)                      # 4-byte Folded Spill
	sw	a2, 76(sp)                      # 4-byte Folded Spill
	beq	a0, a1, .LBB3_2
# %bb.1:
	lw	a0, 72(sp)                      # 4-byte Folded Reload
	sw	a0, 76(sp)                      # 4-byte Folded Spill
.LBB3_2:
	lw	a1, 60(sp)                      # 4-byte Folded Reload
	lw	a4, 68(sp)                      # 4-byte Folded Reload
	lw	a3, 64(sp)                      # 4-byte Folded Reload
	lw	a2, 56(sp)                      # 4-byte Folded Reload
	lw	a0, 52(sp)                      # 4-byte Folded Reload
	lw	a5, 40(sp)                      # 4-byte Folded Reload
	lw	t0, 44(sp)                      # 4-byte Folded Reload
	lw	a6, 76(sp)                      # 4-byte Folded Reload
	lui	a7, 163
	addi	a7, a7, -982
	sw	a7, 12(sp)                      # 4-byte Folded Spill
	add	a7, t0, a7
	add	a6, a7, a6
	sw	a6, 16(sp)                      # 4-byte Folded Spill
	sltu	a6, a6, a7
	sltu	a7, a7, t0
	add	a5, a5, a7
	add	a5, a5, a6
	sw	a5, 20(sp)                      # 4-byte Folded Spill
	add	a0, a2, a0
	sw	a0, 24(sp)                      # 4-byte Folded Spill
	sltu	a2, a0, a2
	add	a0, a4, a2
	add	a3, a0, a3
	sw	a3, 28(sp)                      # 4-byte Folded Spill
	sltu	a3, a3, a4
	sw	a3, 32(sp)                      # 4-byte Folded Spill
	sw	a2, 36(sp)                      # 4-byte Folded Spill
	beq	a0, a1, .LBB3_4
# %bb.3:
	lw	a0, 32(sp)                      # 4-byte Folded Reload
	sw	a0, 36(sp)                      # 4-byte Folded Spill
.LBB3_4:
	lw	a1, 48(sp)                      # 4-byte Folded Reload
	lw	a3, 28(sp)                      # 4-byte Folded Reload
	lw	a4, 24(sp)                      # 4-byte Folded Reload
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	lw	a7, 16(sp)                      # 4-byte Folded Reload
	lw	a5, 12(sp)                      # 4-byte Folded Reload
	lw	a2, 36(sp)                      # 4-byte Folded Reload
	add	a6, a7, a5
	add	a2, a6, a2
	sltu	a5, a2, a6
	sltu	a6, a6, a7
	add	a0, a0, a6
	add	a0, a0, a5
	sw	a4, 0(a1)
	sw	a3, 4(a1)
	sw	a2, 8(a1)
	sw	a0, 12(a1)
	addi	sp, sp, 80
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
                                        # -- End function
