# Source: SLPVectorizer/long-gep-chains.riscv64-unknown-linux__v_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %bb
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	add	a1, a1, a2
	lbu	a1, 0(a1)
	call	__muldi3
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	lbu	a1, 15(a1)
	call	__muldi3
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	lbu	a1, 14(a1)
	call	__muldi3
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	lbu	a1, 13(a1)
	call	__muldi3
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	or	a0, a0, a3
	or	a0, a0, a2
	or	a0, a0, a1
	slli	a0, a0, 32
	srli	a0, a0, 32
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
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
# %bb.0:                                # %bb
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	add	a1, a1, a2
	sd	a1, 0(sp)                       # 8-byte Folded Spill
	add	a1, a1, a2
	lbu	a1, 0(a1)
	call	__muldi3
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	lbu	a1, 15(a1)
	call	__muldi3
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	lbu	a1, 14(a1)
	call	__muldi3
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	mv	a2, a0
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	lbu	a1, 13(a1)
	call	__muldi3
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	mv	a1, a0
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	or	a0, a0, a3
	or	a0, a0, a2
	or	a0, a0, a1
	slli	a0, a0, 32
	srli	a0, a0, 32
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
