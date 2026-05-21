# Source: SLPVectorizer/minbw-with-and-and-scalar-trunc.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: test
# src = pre-opt (test), tgt = post-opt (test)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	lui	a0, %hi(c)
	addi	a0, a0, %lo(c)
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	lhu	a1, 0(a0)
	lui	a2, 16
	addi	a2, a2, -1
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	xor	a1, a1, a2
	lhu	a0, 24(a0)
	xor	a0, a0, a2
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_2
# %bb.1:                                # %entry
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a0, 56(sp)                      # 8-byte Folded Spill
.LBB0_2:                                # %entry
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	lhu	a0, 48(a0)
	xor	a0, a0, a2
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_4
# %bb.3:                                # %entry
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a0, 24(sp)                      # 8-byte Folded Spill
.LBB0_4:                                # %entry
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	lhu	a0, 72(a0)
	xor	a0, a0, a2
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_6
# %bb.5:                                # %entry
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
.LBB0_6:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
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
	lui	a0, %hi(c)
	addi	a0, a0, %lo(c)
	li	a1, 24
                                        # implicit-def: $v10m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vlse64.v	v10, (a0), a1
                                        # implicit-def: $v9
	vsetvli	zero, zero, e32, m1, ta, ma
	vnsrl.wi	v9, v10, 0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf2, ta, ma
	vnsrl.wi	v8, v9, 0
                                        # implicit-def: $v9
	vnot.v	v9, v8
	vmv1r.v	v10, v9
                                        # implicit-def: $v8
	vredmaxu.vs	v8, v9, v10
	vmv.x.s	a0, v8
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
