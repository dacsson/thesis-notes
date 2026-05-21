# Source: SLPVectorizer/split-vectorize-parent-for-copyables.riscv32-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv32-unknown-linux-gnu, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	mv	a4, a2
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	mv	a1, a0
	lw	a0, 16(sp)                      # 4-byte Folded Reload
	li	a2, 0
	sub	a2, a2, a1
	sltu	a0, a2, a0
	slli	a3, a1, 1
	sw	a3, 20(sp)                      # 4-byte Folded Spill
	seqz	a5, a3
	sltu	a2, a2, a1
	sw	a2, 12(sp)                      # 4-byte Folded Spill
	or	a0, a0, a2
	or	a0, a0, a5
	sltu	a3, a3, a4
	or	a0, a0, a3
	or	a0, a0, a2
	sw	a0, 24(sp)                      # 4-byte Folded Spill
	mv	a0, a1
	call	__mulsi3
	lw	a3, 12(sp)                      # 4-byte Folded Reload
	lw	a2, 16(sp)                      # 4-byte Folded Reload
	lw	a1, 20(sp)                      # 4-byte Folded Reload
	mv	a4, a0
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	seqz	a4, a4
	or	a0, a0, a4
	or	a0, a0, a3
	sltu	a1, a1, a2
	or	a0, a0, a1
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 32
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
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	csrr	a3, vlenb
	slli	a3, a3, 1
	sub	sp, sp, a3
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 2 * vlenb
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	mv	a1, a0
                                        # implicit-def: $v9
	vsetivli	zero, 4, e32, m1, tu, ma
	vmv.v.x	v9, a1
	addi	a0, sp, 32
	vs1r.v	v9, (a0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, m1, ta, ma
	vrsub.vi	v8, v9, 0
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 32
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	slli	a0, a1, 1
	sw	a0, 24(sp)                      # 4-byte Folded Spill
	seqz	a3, a0
	sw	a3, 20(sp)                      # 4-byte Folded Spill
	sltu	a0, a0, a2
	sw	a0, 16(sp)                      # 4-byte Folded Spill
	mv	a0, a1
	call	__mulsi3
	lw	a2, 12(sp)                      # 4-byte Folded Reload
	lw	a4, 16(sp)                      # 4-byte Folded Reload
	lw	a3, 20(sp)                      # 4-byte Folded Reload
	addi	a1, sp, 32
	vl1r.v	v9, (a1)                        # vscale x 8-byte Folded Reload
	csrr	a1, vlenb
	add	a1, sp, a1
	addi	a1, a1, 32
	vl1r.v	v8, (a1)                        # vscale x 8-byte Folded Reload
	mv	a1, a0
	lw	a0, 24(sp)                      # 4-byte Folded Reload
	seqz	a1, a1
	vsetivli	zero, 4, e32, m1, tu, ma
	vmv.s.x	v9, a2
	vsetvli	zero, zero, e32, m1, ta, ma
	vmsltu.vv	v8, v8, v9
	sltu	a2, a0, a2
	vcpop.m	a0, v8
	snez	a0, a0
	or	a0, a0, a4
	or	a2, a2, a3
	or	a0, a0, a2
	or	a0, a0, a1
	csrr	a1, vlenb
	slli	a1, a1, 1
	add	sp, sp, a1
	.cfi_def_cfa sp, 48
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
