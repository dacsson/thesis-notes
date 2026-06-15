# Source: LoopVectorize/preserve-dbg-loc.riscv64__v_debugify_loop-vectorize_DEBUGLOC.ll
# Function: vp_select
# src = pre-opt (vp_select), tgt = post-opt (vp_select)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -80
	.cfi_def_cfa_offset 80
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 72(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	ld	a0, 48(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a2, 72(sp)                      # 8-byte Folded Reload
	sd	a2, 0(sp)                       # 8-byte Folded Spill
	slli	a2, a2, 2
	sd	a2, 8(sp)                       # 8-byte Folded Spill
	add	a1, a1, a2
	lw	a1, 0(a1)
	sd	a1, 16(sp)                      # 8-byte Folded Spill
	add	a0, a0, a2
	lw	a0, 0(a0)
	li	a2, 0
	sub	a2, a2, a0
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	mv	a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	blt	a0, a1, .LBB0_3
# %bb.2:                                # %loop
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	sd	a0, 32(sp)                      # 8-byte Folded Spill
.LBB0_3:                                # %loop
                                        #   in Loop: Header=BB0_1 Depth=1
	ld	a1, 40(sp)                      # 8-byte Folded Reload
	ld	a0, 0(sp)                       # 8-byte Folded Reload
	ld	a3, 64(sp)                      # 8-byte Folded Reload
	ld	a4, 8(sp)                       # 8-byte Folded Reload
	ld	a5, 16(sp)                      # 8-byte Folded Reload
	ld	a2, 32(sp)                      # 8-byte Folded Reload
	addw	a2, a2, a5
	add	a3, a3, a4
	sw	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 72(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_4
.LBB0_4:                                # %exit
	addi	sp, sp, 80
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
	.file	1 "/" "/tmp/tmp3edju81v.ll"
	.loc	1 1 0                           # /tmp/tmp3edju81v.ll:1:0
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -144
	.cfi_def_cfa_offset 144
	sd	a3, 88(sp)                      # 8-byte Folded Spill
	sd	a2, 96(sp)                      # 8-byte Folded Spill
	sd	a1, 104(sp)                     # 8-byte Folded Spill
	sd	a0, 112(sp)                     # 8-byte Folded Spill
	sd	a2, 120(sp)                     # 8-byte Folded Spill
	sd	a1, 128(sp)                     # 8-byte Folded Spill
	sd	a0, 136(sp)                     # 8-byte Folded Spill
.Ltmp0:
	.loc	1 1 1 prologue_end              # /tmp/tmp3edju81v.ll:1:1
	j	.LBB0_1
.LBB0_1:                                # %vector.memcheck
	.loc	1 0 1 is_stmt 0                 # /tmp/tmp3edju81v.ll:0:1
	ld	a2, 136(sp)                     # 8-byte Folded Reload
	ld	a3, 120(sp)                     # 8-byte Folded Reload
	ld	a0, 128(sp)                     # 8-byte Folded Reload
	.loc	1 1 1                           # /tmp/tmp3edju81v.ll:1:1
	csrr	a1, vlenb
	slli	a1, a1, 1
	sd	a1, 72(sp)                      # 8-byte Folded Spill
	sub	a0, a2, a0
	sub	a2, a2, a3
	sd	a2, 80(sp)                      # 8-byte Folded Spill
	.loc	1 2 1 is_stmt 1                 # /tmp/tmp3edju81v.ll:2:1
	bltu	a0, a1, .LBB0_6
	j	.LBB0_2
.LBB0_2:                                # %vector.memcheck
	.loc	1 0 1 is_stmt 0                 # /tmp/tmp3edju81v.ll:0:1
	ld	a0, 80(sp)                      # 8-byte Folded Reload
	ld	a1, 72(sp)                      # 8-byte Folded Reload
	.loc	1 2 1                           # /tmp/tmp3edju81v.ll:2:1
	bltu	a0, a1, .LBB0_6
	j	.LBB0_3
.LBB0_3:                                # %vector.ph
	.loc	1 0 1                           # /tmp/tmp3edju81v.ll:0:1
	ld	a0, 88(sp)                      # 8-byte Folded Reload
	li	a1, 0
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	.loc	1 2 1                           # /tmp/tmp3edju81v.ll:2:1
	j	.LBB0_4
.LBB0_4:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	.loc	1 0 1                           # /tmp/tmp3edju81v.ll:0:1
	ld	a0, 64(sp)                      # 8-byte Folded Reload
	ld	a1, 56(sp)                      # 8-byte Folded Reload
	ld	a3, 112(sp)                     # 8-byte Folded Reload
	ld	a5, 96(sp)                      # 8-byte Folded Reload
	ld	a6, 104(sp)                     # 8-byte Folded Reload
	vsetvli	a2, a0, e8, mf2, ta, ma
	.loc	1 3 1 is_stmt 1                 # /tmp/tmp3edju81v.ll:3:1
	slli	a4, a1, 2
	add	a6, a6, a4
                                        # implicit-def: $v12m2
	.loc	1 4 1                           # /tmp/tmp3edju81v.ll:4:1
	vsetvli	zero, a2, e32, m2, tu, ma
	vle32.v	v12, (a6)
	.loc	1 5 1                           # /tmp/tmp3edju81v.ll:5:1
	add	a5, a5, a4
                                        # implicit-def: $v14m2
	.loc	1 6 1                           # /tmp/tmp3edju81v.ll:6:1
	vsetvli	zero, a2, e32, m2, tu, ma
	vle32.v	v14, (a5)
	.loc	1 7 1                           # /tmp/tmp3edju81v.ll:7:1
	vsetvli	a5, zero, e32, m2, ta, ma
	vmslt.vv	v0, v14, v12
                                        # implicit-def: $v8m2
	.loc	1 8 1                           # /tmp/tmp3edju81v.ll:8:1
	vrsub.vi	v8, v14, 0
                                        # implicit-def: $v10m2
	.loc	1 9 1                           # /tmp/tmp3edju81v.ll:9:1
	vsetvli	zero, zero, e32, m2, tu, ma
	vmerge.vvm	v10, v8, v14, v0
                                        # implicit-def: $v8m2
	.loc	1 10 1                          # /tmp/tmp3edju81v.ll:10:1
	vsetvli	zero, zero, e32, m2, ta, ma
	vadd.vv	v8, v10, v12
	.loc	1 11 1                          # /tmp/tmp3edju81v.ll:11:1
	add	a3, a3, a4
	.loc	1 12 1                          # /tmp/tmp3edju81v.ll:12:1
	vsetvli	zero, a2, e32, m2, ta, ma
	vse32.v	v8, (a3)
	.loc	1 2 1                           # /tmp/tmp3edju81v.ll:2:1
	add	a1, a2, a1
	sub	a0, a0, a2
	sd	a1, 56(sp)                      # 8-byte Folded Spill
	mv	a1, a0
	sd	a1, 64(sp)                      # 8-byte Folded Spill
	.loc	1 15 1                          # /tmp/tmp3edju81v.ll:15:1
	bnez	a0, .LBB0_4
	j	.LBB0_5
.LBB0_5:                                # %middle.block
	j	.LBB0_10
.LBB0_6:                                # %scalar.ph
	.loc	1 0 1 is_stmt 0                 # /tmp/tmp3edju81v.ll:0:1
	li	a0, 0
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	.loc	1 1 1 is_stmt 1                 # /tmp/tmp3edju81v.ll:1:1
	j	.LBB0_7
.LBB0_7:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	.loc	1 0 1 is_stmt 0                 # /tmp/tmp3edju81v.ll:0:1
	ld	a0, 96(sp)                      # 8-byte Folded Reload
	ld	a1, 104(sp)                     # 8-byte Folded Reload
	ld	a2, 48(sp)                      # 8-byte Folded Reload
	sd	a2, 8(sp)                       # 8-byte Folded Spill
.Ltmp1:
	#DEBUG_VALUE: vp_select:1 <- [DW_OP_plus_uconst 8] [$x2+0]
	#DEBUG_VALUE: vp_select:1 <- $x12
	.loc	1 3 1 is_stmt 1                 # /tmp/tmp3edju81v.ll:3:1
	slli	a2, a2, 2
.Ltmp2:
	.loc	1 0 1 is_stmt 0                 # /tmp/tmp3edju81v.ll:0:1
	sd	a2, 16(sp)                      # 8-byte Folded Spill
	.loc	1 3 1                           # /tmp/tmp3edju81v.ll:3:1
	add	a1, a1, a2
.Ltmp3:
	#DEBUG_VALUE: vp_select:2 <- $x11
	.loc	1 4 1 is_stmt 1                 # /tmp/tmp3edju81v.ll:4:1
	lw	a1, 0(a1)
.Ltmp4:
	.loc	1 0 1 is_stmt 0                 # /tmp/tmp3edju81v.ll:0:1
	sd	a1, 24(sp)                      # 8-byte Folded Spill
.Ltmp5:
	#DEBUG_VALUE: vp_select:3 <- [DW_OP_plus_uconst 24] [$x2+0]
	#DEBUG_VALUE: vp_select:3 <- $x11
	.loc	1 5 1 is_stmt 1                 # /tmp/tmp3edju81v.ll:5:1
	add	a0, a0, a2
.Ltmp6:
	#DEBUG_VALUE: vp_select:4 <- $x10
	.loc	1 6 1                           # /tmp/tmp3edju81v.ll:6:1
	lw	a0, 0(a0)
.Ltmp7:
	#DEBUG_VALUE: vp_select:5 <- $x10
	.loc	1 8 1                           # /tmp/tmp3edju81v.ll:8:1
	li	a2, 0
.Ltmp8:
	#DEBUG_VALUE: vp_select:6 <- undef
	sub	a2, a2, a0
	sd	a2, 32(sp)                      # 8-byte Folded Spill
.Ltmp9:
	#DEBUG_VALUE: vp_select:7 <- [DW_OP_plus_uconst 32] [$x2+0]
	#DEBUG_VALUE: vp_select:7 <- $x12
	.loc	1 0 1 is_stmt 0                 # /tmp/tmp3edju81v.ll:0:1
	mv	a2, a0
.Ltmp10:
	sd	a2, 40(sp)                      # 8-byte Folded Spill
.Ltmp11:
	#DEBUG_VALUE: vp_select:7 <- [DW_OP_plus_uconst 32] [$x2+0]
	#DEBUG_VALUE: vp_select:3 <- [DW_OP_plus_uconst 24] [$x2+0]
	#DEBUG_VALUE: vp_select:1 <- [DW_OP_plus_uconst 8] [$x2+0]
	.loc	1 9 1 is_stmt 1                 # /tmp/tmp3edju81v.ll:9:1
	blt	a0, a1, .LBB0_9
.Ltmp12:
# %bb.8:                                # %loop
                                        #   in Loop: Header=BB0_7 Depth=1
	#DEBUG_VALUE: vp_select:7 <- [DW_OP_plus_uconst 32] [$x2+0]
	#DEBUG_VALUE: vp_select:5 <- $x10
	#DEBUG_VALUE: vp_select:3 <- [DW_OP_plus_uconst 24] [$x2+0]
	#DEBUG_VALUE: vp_select:1 <- [DW_OP_plus_uconst 8] [$x2+0]
	.loc	1 0 1 is_stmt 0                 # /tmp/tmp3edju81v.ll:0:1
	ld	a0, 32(sp)                      # 8-byte Folded Reload
.Ltmp13:
	sd	a0, 40(sp)                      # 8-byte Folded Spill
.Ltmp14:
.LBB0_9:                                # %loop
                                        #   in Loop: Header=BB0_7 Depth=1
	#DEBUG_VALUE: vp_select:7 <- [DW_OP_plus_uconst 32] [$x2+0]
	#DEBUG_VALUE: vp_select:3 <- [DW_OP_plus_uconst 24] [$x2+0]
	#DEBUG_VALUE: vp_select:1 <- [DW_OP_plus_uconst 8] [$x2+0]
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	ld	a3, 112(sp)                     # 8-byte Folded Reload
	ld	a4, 16(sp)                      # 8-byte Folded Reload
	ld	a5, 24(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
.Ltmp15:
	#DEBUG_VALUE: vp_select:8 <- $x12
	.loc	1 10 1 is_stmt 1                # /tmp/tmp3edju81v.ll:10:1
	addw	a2, a2, a5
.Ltmp16:
	#DEBUG_VALUE: vp_select:9 <- $x12
	.loc	1 11 1                          # /tmp/tmp3edju81v.ll:11:1
	add	a3, a3, a4
.Ltmp17:
	#DEBUG_VALUE: vp_select:10 <- $x13
	.loc	1 12 1                          # /tmp/tmp3edju81v.ll:12:1
	sw	a2, 0(a3)
	.loc	1 13 1                          # /tmp/tmp3edju81v.ll:13:1
	addi	a0, a0, 1
.Ltmp18:
	#DEBUG_VALUE: vp_select:11 <- $x10
	#DEBUG_VALUE: vp_select:12 <- undef
	.loc	1 0 1 is_stmt 0                 # /tmp/tmp3edju81v.ll:0:1
	mv	a2, a0
.Ltmp19:
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	.loc	1 15 1 is_stmt 1                # /tmp/tmp3edju81v.ll:15:1
	bne	a0, a1, .LBB0_7
	j	.LBB0_10
.Ltmp20:
.LBB0_10:                               # %exit
	.loc	1 16 1 epilogue_begin           # /tmp/tmp3edju81v.ll:16:1
	addi	sp, sp, 144
	.cfi_def_cfa_offset 0
	ret
.Ltmp21:
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
