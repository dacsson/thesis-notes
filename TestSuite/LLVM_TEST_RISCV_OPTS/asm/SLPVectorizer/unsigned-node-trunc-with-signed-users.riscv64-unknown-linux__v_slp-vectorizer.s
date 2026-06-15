# Source: SLPVectorizer/unsigned-node-trunc-with-signed-users.riscv64-unknown-linux__v_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	slli	a1, a1, 48
	srli	a1, a1, 48
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	lhu	a2, 0(a0)
	lhu	a0, 16(a0)
	sub	a0, a0, a2
	lui	a2, 1
	addi	a2, a2, -767
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	add	a0, a0, a2
	call	__muldi3
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	mv	a4, a0
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	slli	a5, a4, 32
	srli	a3, a5, 32
	srli	a6, a5, 28
	add	a3, a3, a6
	srli	a6, a5, 26
	add	a6, a3, a6
	srli	a3, a5, 22
	sub	a3, a3, a6
	srli	a5, a5, 20
	add	a3, a3, a5
	srli	a5, a3, 24
	slliw	a3, a5, 8
	addw	a6, a5, a3
	slliw	a3, a5, 10
	subw	a3, a3, a6
	slliw	a6, a5, 12
	subw	a3, a3, a6
	slliw	a5, a5, 16
	addw	a3, a3, a5
	addw	a4, a3, a4
	slli	a3, a4, 48
	lui	a5, 1045247
	slli	a5, a5, 36
	sd	a5, 16(sp)                      # 8-byte Folded Spill
	add	a3, a3, a5
	srai	a5, a3, 48
	srli	a3, a5, 15
	and	a3, a3, a4
	li	a4, 0
	sd	a4, 24(sp)                      # 8-byte Folded Spill
	slt	a6, a4, a5
	subw	a4, a4, a6
	and	a4, a4, a5
	or	a3, a3, a4
	sh	a3, 0(a0)
	lhu	a3, 2(a0)
	lhu	a0, 18(a0)
	sub	a0, a0, a3
	add	a0, a0, a2
	call	__muldi3
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	mv	a4, a0
	slli	a5, a4, 32
	srli	a0, a5, 32
	srli	a6, a5, 28
	add	a0, a0, a6
	srli	a6, a5, 26
	add	a6, a0, a6
	srli	a0, a5, 22
	sub	a0, a0, a6
	srli	a5, a5, 20
	add	a0, a0, a5
	srli	a5, a0, 24
	slliw	a0, a5, 8
	addw	a6, a5, a0
	slliw	a0, a5, 10
	subw	a0, a0, a6
	slliw	a6, a5, 12
	subw	a0, a0, a6
	slliw	a5, a5, 16
	addw	a0, a0, a5
	addw	a4, a0, a4
	slli	a0, a4, 48
	add	a0, a0, a3
	srai	a3, a0, 48
	srli	a0, a3, 15
	and	a0, a0, a4
	slt	a4, a2, a3
	subw	a2, a2, a4
	and	a2, a2, a3
	or	a0, a0, a2
	sh	a0, 2(a1)
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
# %bb.0:
	slli	a1, a1, 48
	srli	a2, a1, 48
	addi	a1, a0, 16
                                        # implicit-def: $v10
	vsetivli	zero, 2, e16, mf4, tu, ma
	vle16.v	v10, (a0)
                                        # implicit-def: $v9
	vle16.v	v9, (a1)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf4, ta, ma
	vwsubu.vv	v8, v9, v10
	lui	a1, 1
	addi	a3, a1, -767
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, mf2, ta, ma
	vadd.vx	v9, v8, a3
                                        # implicit-def: $v8
	vmul.vx	v8, v9, a2
	addi	a1, a1, 943
                                        # implicit-def: $v10
	vwmulu.vx	v10, v8, a1
                                        # implicit-def: $v9
	vnsrl.wi	v9, v10, 24
	lui	a1, 15
	addi	a1, a1, 767
	vmadd.vx	v9, a1, v8
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf4, ta, ma
	vnsrl.wi	v8, v9, 0
	lui	a1, 1048575
	addi	a1, a1, 767
                                        # implicit-def: $v10
	vadd.vx	v10, v8, a1
	vmsle.vi	v0, v10, -1
	li	a1, 0
                                        # implicit-def: $v9
	vmax.vx	v9, v10, a1
                                        # implicit-def: $v10
	vor.vv	v10, v9, v8
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf4, tu, ma
	vmerge.vvm	v8, v9, v10, v0
	vse16.v	v8, (a0)
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
