	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0_zca1p0_zcd1p0"
	.file	"test1.c"
	.text
	.globl	DumbHash                        # -- Begin function DumbHash
	.p2align	1
	.type	DumbHash,@function
DumbHash:                               # @DumbHash
# %bb.0:
.Lpcrel_hi0:
	auipc	a1, %pcrel_hi(context)
	ld	a2, %pcrel_lo(.Lpcrel_hi0)(a1)
	add	a0, a0, a2
	lui	a2, 338043
	slli	a2, a2, 1
	addi	a2, a2, -1296
	xor	a0, a0, a2
	sd	a0, %pcrel_lo(.Lpcrel_hi0)(a1)
	ret
.Lfunc_end0:
	.size	DumbHash, .Lfunc_end0-DumbHash
                                        # -- End function
	.globl	func_33691508                   # -- Begin function func_33691508
	.p2align	1
	.type	func_33691508,@function
func_33691508:                          # @func_33691508
# %bb.0:
.Lpcrel_hi1:
	auipc	a0, %pcrel_hi(DEPTH)
	ld	a0, %pcrel_lo(.Lpcrel_hi1)(a0)
	li	a1, 5
	blt	a0, a1, .LBB1_2
# %bb.1:
	lui	a0, 393486
	addi	a0, a0, -431
	ret
.LBB1_2:
	lui	a0, 5
	addi	a0, a0, 1967
	ret
.Lfunc_end1:
	.size	func_33691508, .Lfunc_end1-func_33691508
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:
	addi	sp, sp, -16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
.Lpcrel_hi2:
	auipc	a0, %pcrel_hi(context)
	ld	a1, %pcrel_lo(.Lpcrel_hi2)(a0)
.Lpcrel_hi3:
	auipc	a0, %pcrel_hi(.L.str)
	addi	a0, a0, %pcrel_lo(.Lpcrel_hi3)
	call	printf
	li	a0, 0
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	addi	sp, sp, 16
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
