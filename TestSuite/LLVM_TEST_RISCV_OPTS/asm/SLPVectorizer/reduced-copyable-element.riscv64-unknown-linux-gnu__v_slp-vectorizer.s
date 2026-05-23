# Source: SLPVectorizer/reduced-copyable-element.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: main
# src = pre-opt (main), tgt = post-opt (main)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	lui	a0, %hi(n)
	addi	a0, a0, %lo(n)
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	lw	a1, 32(a0)
	srai	a0, a1, 63
	and	a0, a0, a1
	li	a1, 1
	slli	a1, a1, 34
	sd	a1, 32(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 40(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_2
# %bb.1:                                # %entry
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a0, 40(sp)                      # 8-byte Folded Spill
.LBB0_2:                                # %entry
	ld	a1, 32(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	addiw	a2, a2, 1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	lw	a2, 0(a0)
	srai	a0, a2, 63
	and	a0, a0, a2
	mv	a2, a0
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	bltu	a0, a1, .LBB0_4
# %bb.3:                                # %entry
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	sd	a0, 16(sp)                      # 8-byte Folded Spill
.LBB0_4:                                # %entry
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 16(sp)                      # 8-byte Folded Reload
	or	a0, a0, a1
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
# %bb.0:                                # %entry
	lui	a0, %hi(n)
	addi	a0, a0, %lo(n)
	li	a1, 32
                                        # implicit-def: $v9
	vsetivli	zero, 2, e64, m1, tu, ma
	vlse64.v	v9, (a0), a1
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, mf2, ta, ma
	vnsrl.wi	v8, v9, 0
	li	a0, 0
                                        # implicit-def: $v9
	vmin.vx	v9, v8, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e64, m1, ta, ma
	vsext.vf2	v8, v9
	li	a0, 1
	slli	a0, a0, 34
                                        # implicit-def: $v9
	vminu.vx	v9, v8, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e32, mf2, ta, ma
	vnsrl.wi	v8, v9, 0
                                        # implicit-def: $v10
	vid.v	v10
                                        # implicit-def: $v9
	vadd.vv	v9, v8, v10
	vmv1r.v	v10, v9
                                        # implicit-def: $v8
	vredor.vs	v8, v9, v10
	vmv.x.s	a0, v8
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
