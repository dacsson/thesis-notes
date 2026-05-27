# Source: InstCombine/libcall-arg-exts.riscv64_instcombine.ll
# Function: fun4
# src = pre-opt (fun4), tgt = post-opt (fun4)
# Triple: riscv64, Attrs: none
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	.cfi_offset ra, -8
	lui	a0, %hi(a)
	addi	a0, a0, %lo(a)
	lui	a1, %hi(b)
	addi	a1, a1, %lo(b)
	li	a2, 0
	li	a3, 60
	li	a4, -1
	call	__memccpy_chk
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	ra, 8(sp)                       # 8-byte Folded Spill
	.cfi_offset ra, -8
	lui	a0, %hi(a)
	addi	a0, a0, %lo(a)
	lui	a1, %hi(b)
	addi	a1, a1, %lo(b)
	li	a2, 0
	li	a3, 60
	call	memccpy
	ld	ra, 8(sp)                       # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
