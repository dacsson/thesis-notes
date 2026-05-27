# Source: VectorCombine/fold-signbit-reduction-cmp.riscv64__v_vector-combine.ll
# Function: negative_ashr_add_sgt_0
# src = pre-opt (negative_ashr_add_sgt_0), tgt = post-opt (negative_ashr_add_sgt_0)
# Triple: riscv64, Attrs: +v
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
	csrr	a1, vlenb
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 1 * vlenb
	ld	a1, 8(a0)
	ld	a2, 0(a0)
                                        # implicit-def: $v8
	vsetivli	zero, 8, e8, mf2, tu, ma
	vmv.v.x	v8, a2
                                        # implicit-def: $v9
	vslide1down.vx	v9, v8, a1
	ld	a1, 16(a0)
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a1
	ld	a1, 24(a0)
                                        # implicit-def: $v9
	vslide1down.vx	v9, v8, a1
	ld	a0, 32(a0)
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf2, ta, ma
	vslidedown.vi	v9, v8, 3
                                        # implicit-def: $v8
	vsll.vi	v8, v9, 5
                                        # implicit-def: $v9
	vsra.vi	v9, v8, 5
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.v.i	v8, 2
	li	a0, -32
                                        # implicit-def: $v0
	vmv.s.x	v0, a0
	addi	a0, sp, 16
	vs1r.v	v0, (a0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v10
	vmerge.vim	v10, v8, 0, v0
	addi	a0, sp, 16
	vl1r.v	v0, (a0)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, ta, ma
	vsra.vv	v8, v9, v10
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.v.i	v9, -1
                                        # implicit-def: $v10
	vmerge.vim	v10, v9, 0, v0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf2, ta, ma
	vand.vv	v9, v8, v10
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a1, v8
	slli	a1, a1, 61
	srai	a1, a1, 61
	slt	a0, a0, a1
	csrr	a1, vlenb
	add	sp, sp, a1
	.cfi_def_cfa sp, 16
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end41:
	.size	src, .Lfunc_end41-src
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
	csrr	a1, vlenb
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 1 * vlenb
	ld	a1, 8(a0)
	ld	a2, 0(a0)
                                        # implicit-def: $v8
	vsetivli	zero, 8, e8, mf2, tu, ma
	vmv.v.x	v8, a2
                                        # implicit-def: $v9
	vslide1down.vx	v9, v8, a1
	ld	a1, 16(a0)
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a1
	ld	a1, 24(a0)
                                        # implicit-def: $v9
	vslide1down.vx	v9, v8, a1
	ld	a0, 32(a0)
                                        # implicit-def: $v8
	vslide1down.vx	v8, v9, a0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf2, ta, ma
	vslidedown.vi	v9, v8, 3
                                        # implicit-def: $v8
	vsll.vi	v8, v9, 5
                                        # implicit-def: $v9
	vsra.vi	v9, v8, 5
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.v.i	v8, 2
	li	a0, -32
                                        # implicit-def: $v0
	vmv.s.x	v0, a0
	addi	a0, sp, 16
	vs1r.v	v0, (a0)                        # vscale x 8-byte Folded Spill
                                        # implicit-def: $v10
	vmerge.vim	v10, v8, 0, v0
	addi	a0, sp, 16
	vl1r.v	v0, (a0)                        # vscale x 8-byte Folded Reload
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, ta, ma
	vsra.vv	v8, v9, v10
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.v.i	v9, -1
                                        # implicit-def: $v10
	vmerge.vim	v10, v9, 0, v0
                                        # implicit-def: $v9
	vsetvli	zero, zero, e8, mf2, ta, ma
	vand.vv	v9, v8, v10
	li	a0, 0
                                        # implicit-def: $v10
	vsetvli	zero, zero, e8, mf2, tu, ma
	vmv.s.x	v10, a0
                                        # implicit-def: $v8
	vsetvli	zero, zero, e8, mf2, ta, ma
	vredsum.vs	v8, v9, v10
	vmv.x.s	a1, v8
	slli	a1, a1, 61
	srai	a1, a1, 61
	slt	a0, a0, a1
	csrr	a1, vlenb
	add	sp, sp, a1
	.cfi_def_cfa sp, 16
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end41:
	.size	tgt, .Lfunc_end41-tgt
	.cfi_endproc
                                        # -- End function
