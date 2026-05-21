# Source: SLPVectorizer/strided-unsupported-type.riscv64-unknown-linux-gnu__v_slp-vectorizer.ll
# Function: stores
# src = pre-opt (stores), tgt = post-opt (stores)
# Triple: riscv64-unknown-linux-gnu, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	mv	a1, a0
	ld	a3, 0(zero)
	ld	a4, 8(zero)
	ld	a0, 16(zero)
	ld	a2, 24(zero)
	sd	a4, 24(a1)
	sd	a3, 16(a1)
	sd	a2, 8(a1)
	sd	a0, 0(a1)
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	ld	a2, 24(zero)
	ld	a3, 16(zero)
	ld	a4, 8(zero)
	ld	a5, 0(zero)
	addi	a1, a0, 16
                                        # implicit-def: $v8m2
	vsetivli	zero, 4, e64, m2, tu, ma
	vmv.v.x	v8, a5
                                        # implicit-def: $v10m2
	vslide1down.vx	v10, v8, a4
                                        # implicit-def: $v8m2
	vslide1down.vx	v8, v10, a3
                                        # implicit-def: $v12m2
	vslide1down.vx	v12, v8, a2
	vmv1r.v	v9, v12
                                        # implicit-def: $v8
	vsetivli	zero, 1, e64, m1, ta, ma
	vslidedown.vi	v8, v9, 1
	vse64.v	v9, (a1)
	addi	a1, a0, 24
	vse64.v	v8, (a1)
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e64, m2, ta, ma
	vslidedown.vi	v8, v12, 2
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
                                        # implicit-def: $v10m2
	vslidedown.vi	v10, v12, 3
	vmv1r.v	v9, v10
	addi	a1, a0, 8
	vsetivli	zero, 1, e64, m1, ta, ma
	vse64.v	v9, (a1)
	vse64.v	v8, (a0)
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
