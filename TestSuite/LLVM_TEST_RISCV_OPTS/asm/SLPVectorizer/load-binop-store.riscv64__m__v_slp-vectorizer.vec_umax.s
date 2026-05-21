# Source: SLPVectorizer/load-binop-store.riscv64__m__v_slp-vectorizer.ll
# Function: vec_umax
# src = pre-opt (vec_umax), tgt = post-opt (vec_umax)
# Triple: riscv64, Attrs: +m,+v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	lhu	a1, 0(a0)
	lhu	a0, 2(a0)
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	lhu	a0, 0(a2)
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	lhu	a2, 2(a2)
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB9_2
# %bb.1:                                # %entry
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 56(sp)                      # 8-byte Folded Spill
.LBB9_2:                                # %entry
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	mv	a2, a1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bltu	a0, a1, .LBB9_4
# %bb.3:                                # %entry
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a0, 8(sp)                       # 8-byte Folded Spill
.LBB9_4:                                # %entry
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 0(sp)                       # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	sh	a2, 0(a1)
	sh	a0, 2(a1)
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	src, .Lfunc_end9-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v9
	vsetivli	zero, 2, e16, mf4, tu, ma
	vle16.v	v9, (a1)
                                        # implicit-def: $v10
	vle16.v	v10, (a2)
                                        # implicit-def: $v8
	vsetvli	zero, zero, e16, mf4, ta, ma
	vmaxu.vv	v8, v9, v10
	vse16.v	v8, (a0)
	ret
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
	.cfi_endproc
                                        # -- End function
