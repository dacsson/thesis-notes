	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0_zca1p0_zcd1p0"
	.file	"test1.c"
	.text
	.globl	DumbHash                        # -- Begin function DumbHash
	.p2align	1
	.type	DumbHash,@function
DumbHash:                               # @DumbHash
# %bb.0:
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 32
                                        # kill: def $x12 killed $x11
	sd	a0, -24(s0)
	sw	a1, -28(s0)
	ld	a2, -24(s0)
.Lpcrel_hi0:
	auipc	a0, %pcrel_hi(context)
	addi	a1, a0, %pcrel_lo(.Lpcrel_hi0)
	ld	a0, 0(a1)
	add	a0, a0, a2
	sd	a0, 0(a1)
	ld	a0, 0(a1)
	lui	a2, 338043
	slli	a2, a2, 1
	addi	a2, a2, -1296
	xor	a0, a0, a2
	sd	a0, 0(a1)
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end0:
	.size	DumbHash, .Lfunc_end0-DumbHash
                                        # -- End function
	.globl	func_33691508                   # -- Begin function func_33691508
	.p2align	1
	.type	func_33691508,@function
func_33691508:                          # @func_33691508
# %bb.0:
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 32
.Lpcrel_hi1:
	auipc	a0, %pcrel_hi(DEPTH)
	addi	a0, a0, %pcrel_lo(.Lpcrel_hi1)
	ld	a1, 0(a0)
	li	a0, 4
	blt	a0, a1, .LBB1_2
	j	.LBB1_1
.LBB1_1:
.Lpcrel_hi2:
	auipc	a0, %pcrel_hi(DEPTH)
	addi	a1, a0, %pcrel_lo(.Lpcrel_hi2)
	ld	a0, 0(a1)
	addi	a0, a0, 1
	sd	a0, 0(a1)
	lui	a0, 8
	addi	a0, a0, -230
	sh	a0, -22(s0)
	lui	a0, 5
	addi	a0, a0, 1967
	sh	a0, -24(s0)
	li	a0, -1753
	sh	a0, -22(s0)
	ld	a0, 0(a1)
	addi	a0, a0, -1
	sd	a0, 0(a1)
	lhu	a0, -24(s0)
	sw	a0, -20(s0)
	j	.LBB1_3
.LBB1_2:
	lui	a0, 393486
	addi	a0, a0, -431
	sw	a0, -20(s0)
	j	.LBB1_3
.LBB1_3:
	lw	a0, -20(s0)
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end1:
	.size	func_33691508, .Lfunc_end1-func_33691508
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:
	addi	sp, sp, -48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	sd	s0, 32(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 48
                                        # kill: def $x12 killed $x10
	li	a2, 0
	sw	a2, -28(s0)
	sw	a0, -32(s0)
	sd	a1, -40(s0)
.Lpcrel_hi3:
	auipc	a0, %pcrel_hi(DEPTH)
	addi	a0, a0, %pcrel_lo(.Lpcrel_hi3)
	ld	a1, 0(a0)
	li	a0, 4
	blt	a0, a1, .LBB2_2
	j	.LBB2_1
.LBB2_1:
.Lpcrel_hi4:
	auipc	a0, %pcrel_hi(DEPTH)
	addi	a1, a0, %pcrel_lo(.Lpcrel_hi4)
	ld	a0, 0(a1)
	addi	a0, a0, 1
	sd	a0, 0(a1)
	lui	a0, 8
	addi	a0, a0, -230
	sh	a0, -22(s0)
	lui	a0, 5
	addi	a0, a0, 1967
	sh	a0, -24(s0)
	li	a0, -1753
	sh	a0, -22(s0)
	ld	a0, 0(a1)
	addi	a0, a0, -1
	sd	a0, 0(a1)
	lhu	a0, -24(s0)
	sw	a0, -20(s0)
	j	.LBB2_3
.LBB2_2:
	lui	a0, 393486
	addi	a0, a0, -431
	sw	a0, -20(s0)
	j	.LBB2_3
.LBB2_3:
.Lpcrel_hi5:
	auipc	a0, %pcrel_hi(context)
	addi	a0, a0, %pcrel_lo(.Lpcrel_hi5)
	ld	a1, 0(a0)
.Lpcrel_hi6:
	auipc	a0, %pcrel_hi(.L.str)
	addi	a0, a0, %pcrel_lo(.Lpcrel_hi6)
	call	printf
	li	a0, 0
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	ld	s0, 32(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        # -- End function
	.type	context,@object                 # @context
	.bss
	.globl	context
	.p2align	3, 0x0
context:
	.quad	0                               # 0x0
	.size	context, 8

	.type	DEPTH,@object                   # @DEPTH
	.globl	DEPTH
	.p2align	3, 0x0
DEPTH:
	.quad	0                               # 0x0
	.size	DEPTH, 8

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%d\n"
	.size	.L.str, 4

	.ident	"clang version 21.1.6"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym printf
	.addrsig_sym context
	.addrsig_sym DEPTH
