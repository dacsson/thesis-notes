# Source: LoopVectorize/strided-accesses.riscv64__v_loop-vectorize_COMMON_2.ll
# Function: interleaved_load_instead_of_strided
# src = pre-opt (interleaved_load_instead_of_strided), tgt = post-opt (interleaved_load_instead_of_strided)
# Triple: riscv64, Attrs: +v
#

                                        # -- End function
	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	j	.LBB10_1
.LBB10_1:                               # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a1, 0(sp)                       # 8-byte Folded Reload
	slli	a2, a0, 4
	add	a2, a1, a2
	lw	a1, 0(a2)
	lw	a4, 4(a2)
	lw	a3, 12(a2)
	addw	a1, a1, a4
	addw	a1, a1, a3
	sw	a1, 0(a2)
	addi	a0, a0, 1
	li	a1, 1024
	mv	a2, a0
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	bne	a0, a1, .LBB10_1
	j	.LBB10_2
.LBB10_2:                               # %exit
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	src, .Lfunc_end10-src
	.cfi_endproc
                                        # -- End function

                                        # -- End function
	.globl	tgt                             # -- Begin function tgt
	.p2align	2
	.type	tgt,@function
tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	csrr	a1, vlenb
	slli	a1, a1, 2
	mv	a2, a1
	slli	a1, a1, 1
	add	a1, a1, a2
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x0c, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 12 * vlenb
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	j	.LBB10_1
.LBB10_1:                               # %vector.ph
	li	a0, 1024
                                        # implicit-def: $v8m4
	vsetvli	a1, zero, e64, m4, ta, ma
	vid.v	v8
	addi	a1, sp, 32
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB10_2
.LBB10_2:                               # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 24(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 32
	vl4r.v	v12, (a1)                       # vscale x 32-byte Folded Reload
	vsetvli	a1, a0, e8, mf2, ta, ma
                                        # implicit-def: $v16m4
	vsetvli	a3, zero, e64, m4, ta, ma
	vsll.vi	v16, v12, 4
                                        # implicit-def: $v8m4
	vadd.vx	v8, v16, a2
                                        # kill: def $v8 killed $v8 killed $v8m4 killed $vtype
	vmv.x.s	a3, v8
	slli	a4, a1, 2
                                        # implicit-def: $v24m8
	vsetvli	zero, a4, e32, m8, tu, ma
	vle32.v	v24, (a3)
	csrr	a3, vlenb
	slli	a3, a3, 2
	add	a3, sp, a3
	addi	a3, a3, 32
	vsetvli	a4, zero, e32, m8, ta, ma
	vse32.v	v24, (a3)
                                        # implicit-def: $v24m2_v26m2_v28m2_v30m2
	vsetvli	a4, zero, e32, m2, ta, ma
	vlseg4e32.v	v24, (a3)
	vmv2r.v	v20, v30
	vmv2r.v	v22, v26
	vmv2r.v	v8, v24
                                        # implicit-def: $v10m2
	vadd.vv	v10, v8, v22
                                        # implicit-def: $v8m2
	vadd.vv	v8, v10, v20
	vsetvli	zero, a1, e32, m2, ta, ma
	vsoxei64.v	v8, (a2), v16
	sub	a0, a0, a1
                                        # implicit-def: $v8m4
	vsetvli	a2, zero, e64, m4, ta, ma
	vadd.vx	v8, v12, a1
	addi	a1, sp, 32
	vs4r.v	v8, (a1)                        # vscale x 32-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	bnez	a0, .LBB10_2
	j	.LBB10_3
.LBB10_3:                               # %middle.block
	j	.LBB10_4
.LBB10_4:                               # %exit
	csrr	a0, vlenb
	slli	a0, a0, 2
	mv	a1, a0
	slli	a0, a0, 1
	add	a0, a0, a1
	add	sp, sp, a0
	.cfi_def_cfa sp, 32
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end10:
	.size	tgt, .Lfunc_end10-tgt
	.cfi_endproc
                                        # -- End function
