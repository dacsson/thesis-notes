# Source: ConstantHoisting/immediates.riscv64-unknown-elf_consthoist.ll
# Function: test4
# src = pre-opt (test4), tgt = post-opt (test4)
# Triple: riscv64-unknown-elf, Attrs: none
#

	.globl	src
	.p2align	2
	.type	src,@function
src:                                    # @src
# %bb.0:
	mv	a2, a0
	lui	a0, %hi(.LCPI3_0)
	ld	a0, %lo(.LCPI3_0)(a0)
	add	a0, a2, a0
	sltu	a2, a0, a2
	add	a1, a1, a2
	lui	a2, 326
	addi	a2, a2, -1963
	add	a1, a1, a2
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
                                        # -- End function

	.globl	tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
# %bb.0:
	mv	a3, a0
	lui	a0, %hi(.LCPI3_0)
	ld	a0, %lo(.LCPI3_0)(a0)
	add	a2, a3, a0
	sltu	a3, a2, a3
	add	a1, a1, a3
	add	a0, a2, a0
	sltu	a2, a0, a2
	add	a1, a1, a2
	lui	a2, 163
	addi	a2, a2, -982
	add	a1, a1, a2
	add	a1, a1, a2
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
                                        # -- End function
