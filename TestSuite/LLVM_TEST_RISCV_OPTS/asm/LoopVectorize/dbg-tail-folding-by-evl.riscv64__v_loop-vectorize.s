# Source: LoopVectorize/dbg-tail-folding-by-evl.riscv64__v_loop-vectorize.ll
# Function: reverse_store
# src = pre-opt (reverse_store), tgt = post-opt (reverse_store)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
.Lfunc_begin0:
	.file	1 "/test/file/path" "dbg-tail-folding-by-evl.cpp"
	.loc	1 1 0                           # dbg-tail-folding-by-evl.cpp:1:0
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	.loc	1 1 0 prologue_end              # dbg-tail-folding-by-evl.cpp:1:0
	sd	a0, 0(sp)                       # 8-byte Folded Spill
	sd	a1, 8(sp)                       # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 8(sp)                       # 8-byte Folded Reload
	ld	a0, 0(sp)                       # 8-byte Folded Reload
.Ltmp0:
	.loc	1 2 0                           # dbg-tail-folding-by-evl.cpp:2
	addi	a2, a1, -1
	.loc	1 3 7                           # dbg-tail-folding-by-evl.cpp:3:7
	slli	a3, a2, 3
	add	a0, a0, a3
	.loc	1 3 12 is_stmt 0                # dbg-tail-folding-by-evl.cpp:3:12
	sd	a2, 0(a0)
	.loc	1 2 27 is_stmt 1                # dbg-tail-folding-by-evl.cpp:2:27
	li	a0, 1
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	.loc	1 2 5 is_stmt 0                 # dbg-tail-folding-by-evl.cpp:2:5
	bltu	a0, a1, .LBB0_1
	j	.LBB0_2
.Ltmp1:
.LBB0_2:                                # %exit
	.loc	1 0 5                           # dbg-tail-folding-by-evl.cpp:0:5
	addi	sp, sp, 16
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
.Lfunc_begin0:
	.file	1 "/test/file/path" "dbg-tail-folding-by-evl.cpp"
	.loc	1 1 0                           # dbg-tail-folding-by-evl.cpp:1:0
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	csrr	a2, vlenb
	slli	a2, a2, 1
	sub	sp, sp, a2
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x30, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 48 + 2 * vlenb
	.loc	1 1 0 prologue_end              # dbg-tail-folding-by-evl.cpp:1:0
	sd	a1, 24(sp)                      # 8-byte Folded Spill
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	snez	a0, a1
	sub	a0, a1, a0
	addi	a0, a0, 1
	sd	a0, 40(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %vector.ph
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	ld	a1, 24(sp)                      # 8-byte Folded Reload
                                        # implicit-def: $v10m2
	vsetvli	a2, zero, e64, m2, tu, ma
	vmv.v.x	v10, a1
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e64, m2, ta, ma
	vid.v	v8
	li	a1, -1
	vmadd.vx	v8, a1, v10
	addi	a1, sp, 48
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	sd	a0, 16(sp)                      # 8-byte Folded Spill
	j	.LBB0_2
.LBB0_2:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	addi	a1, sp, 48
	vl2r.v	v10, (a1)                       # vscale x 16-byte Folded Reload
	vsetvli	a2, a0, e8, mf4, ta, ma
	li	a1, 0
	sub	a1, a1, a2
                                        # implicit-def: $v8m2
.Ltmp0:
	.loc	1 2 0                           # dbg-tail-folding-by-evl.cpp:2
	vsetvli	a4, zero, e64, m2, ta, ma
	vadd.vi	v8, v10, -1
	vmv1r.v	v12, v8
	vmv.x.s	a4, v12
	.loc	1 3 7                           # dbg-tail-folding-by-evl.cpp:3:7
	slli	a4, a4, 3
	add	a3, a3, a4
	.loc	1 3 12 is_stmt 0                # dbg-tail-folding-by-evl.cpp:3:12
	li	a4, -8
	vsetvli	zero, a2, e64, m2, ta, ma
	vsse64.v	v8, (a3), a4
	sub	a0, a0, a2
                                        # implicit-def: $v8m2
	vsetvli	a2, zero, e64, m2, ta, ma
	vadd.vx	v8, v10, a1
	addi	a1, sp, 48
	vs2r.v	v8, (a1)                        # vscale x 16-byte Folded Spill
	mv	a1, a0
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	.loc	1 2 5 is_stmt 1                 # dbg-tail-folding-by-evl.cpp:2:5
	bnez	a0, .LBB0_2
	j	.LBB0_3
.LBB0_3:                                # %middle.block
	j	.LBB0_4
.Ltmp1:
.LBB0_4:                                # %exit
	.loc	1 0 5 is_stmt 0                 # dbg-tail-folding-by-evl.cpp:0:5
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	sp, sp, a0
	.cfi_def_cfa sp, 48
	addi	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
