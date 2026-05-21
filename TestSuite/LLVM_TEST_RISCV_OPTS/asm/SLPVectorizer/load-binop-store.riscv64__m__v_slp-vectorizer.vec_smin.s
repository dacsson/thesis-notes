# Source: SLPVectorizer/load-binop-store.riscv64__m__v_slp-vectorizer.ll
# Function: vec_smin
# src = pre-opt (vec_smin), tgt = post-opt (vec_smin)
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
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	lh	a0, 0(a1)
	lh	a1, 2(a1)
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	lh	a1, 0(a2)
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	lh	a2, 2(a2)
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB8_2
# %bb.1:                                # %entry
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	sd	a0, 56(sp)                      # 8-byte Folded Spill
.LBB8_2:                                # %entry
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 56(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB8_4
# %bb.3:                                # %entry
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
.LBB8_4:                                # %entry
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	sh	a2, 0(a1)
	sh	a0, 2(a1)
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	src, .Lfunc_end8-src
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
	vmin.vv	v8, v9, v10
	vse16.v	v8, (a0)
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
