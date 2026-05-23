# Source: LoopVectorize/clmul.riscv64__v_loop-vectorize.ll
# Function: clmul_loop
# src = pre-opt (clmul_loop), tgt = post-opt (clmul_loop)
# Triple: riscv64, Attrs: +v
#

	.globl	src                             # -- Begin function src
	.p2align	2
	.type	src,@function
src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a4, 48(sp)                      # 8-byte Folded Reload
	slli	a5, a0, 3
	add	a4, a4, a5
	add	a2, a2, a5
	add	a3, a3, a5
	ld	a5, 0(a4)
	sd	a5, 0(sp)                       # 8-byte Folded Spill
	ld	a4, 0(a2)
	sd	a4, 8(sp)                       # 8-byte Folded Spill
	slli	a6, a5, 1
	andi	a2, a4, 2
	seqz	a2, a2
	addi	a2, a2, -1
	and	a6, a2, a6
	andi	a2, a4, 1
	seqz	a2, a2
	addi	a2, a2, -1
	and	a2, a2, a5
	xor	a2, a2, a6
	slli	a7, a5, 2
	andi	a6, a4, 4
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	a7, a5, 3
	andi	a6, a4, 8
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	a7, a5, 4
	andi	a6, a4, 16
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	a7, a5, 5
	andi	a6, a4, 32
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	a7, a5, 6
	andi	a6, a4, 64
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	a7, a5, 7
	andi	a6, a4, 128
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	a7, a5, 8
	andi	a6, a4, 256
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	a7, a5, 9
	andi	a6, a4, 512
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	a7, a5, 10
	andi	a6, a4, 1024
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	t0, a5, 11
	li	a6, 1
	sd	a6, 16(sp)                      # 8-byte Folded Spill
	slli	a7, a6, 11
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 12
	lui	a7, 1
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 13
	lui	a7, 2
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 14
	lui	a7, 4
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 15
	lui	a7, 8
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 16
	lui	a7, 16
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 17
	lui	a7, 32
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 18
	lui	a7, 64
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 19
	lui	a7, 128
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 20
	lui	a7, 256
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 21
	lui	a7, 512
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 22
	lui	a7, 1024
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 23
	lui	a7, 2048
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 24
	lui	a7, 4096
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 25
	lui	a7, 8192
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 26
	lui	a7, 16384
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 27
	lui	a7, 32768
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 28
	lui	a7, 65536
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 29
	lui	a7, 131072
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 30
	lui	a7, 262144
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 31
	sraiw	a7, a4, 31
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 32
	slli	a7, a6, 32
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 33
	slli	a7, a6, 33
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 34
	slli	a7, a6, 34
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 35
	slli	a7, a6, 35
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 36
	slli	a7, a6, 36
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 37
	slli	a7, a6, 37
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 38
	slli	a7, a6, 38
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 39
	slli	a7, a6, 39
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 40
	slli	a7, a6, 40
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 41
	slli	a7, a6, 41
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 42
	slli	a7, a6, 42
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 43
	slli	a7, a6, 43
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 44
	slli	a7, a6, 44
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 45
	slli	a7, a6, 45
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 46
	slli	a7, a6, 46
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 47
	slli	a7, a6, 47
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 48
	slli	a7, a6, 48
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 49
	slli	a7, a6, 49
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 50
	slli	a7, a6, 50
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 51
	slli	a7, a6, 51
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 52
	slli	a7, a6, 52
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 53
	slli	a7, a6, 53
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 54
	slli	a7, a6, 54
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 55
	slli	a7, a6, 55
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 56
	slli	a7, a6, 56
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 57
	slli	a7, a6, 57
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 58
	slli	a7, a6, 58
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 59
	slli	a7, a6, 59
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 60
	slli	a7, a6, 60
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 61
	slli	a7, a6, 61
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	a7, a5, 62
	slli	a6, a6, 62
	and	a6, a4, a6
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	a5, a5, 63
	srli	a4, a4, 63
	seqz	a4, a4
	addi	a4, a4, -1
	and	a4, a4, a5
	xor	a2, a2, a4
	sd	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %for.exit
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
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sd	a3, 24(sp)                      # 8-byte Folded Spill
	sd	a2, 32(sp)                      # 8-byte Folded Spill
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	sd	a0, 48(sp)                      # 8-byte Folded Spill
	li	a0, 0
	sd	a0, 56(sp)                      # 8-byte Folded Spill
	j	.LBB0_1
.LBB0_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	ld	a1, 24(sp)                      # 8-byte Folded Reload
	ld	a0, 56(sp)                      # 8-byte Folded Reload
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	ld	a4, 48(sp)                      # 8-byte Folded Reload
	slli	a5, a0, 3
	add	a4, a4, a5
	add	a2, a2, a5
	add	a3, a3, a5
	ld	a5, 0(a4)
	sd	a5, 0(sp)                       # 8-byte Folded Spill
	ld	a4, 0(a2)
	sd	a4, 8(sp)                       # 8-byte Folded Spill
	slli	a6, a5, 1
	andi	a2, a4, 2
	seqz	a2, a2
	addi	a2, a2, -1
	and	a6, a2, a6
	andi	a2, a4, 1
	seqz	a2, a2
	addi	a2, a2, -1
	and	a2, a2, a5
	xor	a2, a2, a6
	slli	a7, a5, 2
	andi	a6, a4, 4
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	a7, a5, 3
	andi	a6, a4, 8
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	a7, a5, 4
	andi	a6, a4, 16
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	a7, a5, 5
	andi	a6, a4, 32
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	a7, a5, 6
	andi	a6, a4, 64
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	a7, a5, 7
	andi	a6, a4, 128
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	a7, a5, 8
	andi	a6, a4, 256
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	a7, a5, 9
	andi	a6, a4, 512
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	a7, a5, 10
	andi	a6, a4, 1024
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	t0, a5, 11
	li	a6, 1
	sd	a6, 16(sp)                      # 8-byte Folded Spill
	slli	a7, a6, 11
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 12
	lui	a7, 1
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 13
	lui	a7, 2
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 14
	lui	a7, 4
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 15
	lui	a7, 8
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 16
	lui	a7, 16
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 17
	lui	a7, 32
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 18
	lui	a7, 64
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 19
	lui	a7, 128
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 20
	lui	a7, 256
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 21
	lui	a7, 512
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 22
	lui	a7, 1024
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 23
	lui	a7, 2048
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 24
	lui	a7, 4096
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 25
	lui	a7, 8192
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 26
	lui	a7, 16384
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 27
	lui	a7, 32768
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 28
	lui	a7, 65536
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 29
	lui	a7, 131072
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 30
	lui	a7, 262144
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 31
	sraiw	a7, a4, 31
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 32
	slli	a7, a6, 32
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 33
	slli	a7, a6, 33
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 34
	slli	a7, a6, 34
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 35
	slli	a7, a6, 35
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 36
	slli	a7, a6, 36
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 37
	slli	a7, a6, 37
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 38
	slli	a7, a6, 38
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 39
	slli	a7, a6, 39
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 40
	slli	a7, a6, 40
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 41
	slli	a7, a6, 41
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 42
	slli	a7, a6, 42
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 43
	slli	a7, a6, 43
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 44
	slli	a7, a6, 44
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 45
	slli	a7, a6, 45
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 46
	slli	a7, a6, 46
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 47
	slli	a7, a6, 47
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 48
	slli	a7, a6, 48
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 49
	slli	a7, a6, 49
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 50
	slli	a7, a6, 50
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 51
	slli	a7, a6, 51
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 52
	slli	a7, a6, 52
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 53
	slli	a7, a6, 53
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 54
	slli	a7, a6, 54
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 55
	slli	a7, a6, 55
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 56
	slli	a7, a6, 56
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 57
	slli	a7, a6, 57
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 58
	slli	a7, a6, 58
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 59
	slli	a7, a6, 59
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 60
	slli	a7, a6, 60
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	t0, a5, 61
	slli	a7, a6, 61
	and	a7, a4, a7
	seqz	a7, a7
	addi	a7, a7, -1
	and	a7, a7, t0
	xor	a2, a2, a7
	slli	a7, a5, 62
	slli	a6, a6, 62
	and	a6, a4, a6
	seqz	a6, a6
	addi	a6, a6, -1
	and	a6, a6, a7
	xor	a2, a2, a6
	slli	a5, a5, 63
	srli	a4, a4, 63
	seqz	a4, a4
	addi	a4, a4, -1
	and	a4, a4, a5
	xor	a2, a2, a4
	sd	a2, 0(a3)
	addi	a0, a0, 1
	mv	a2, a0
	sd	a2, 56(sp)                      # 8-byte Folded Spill
	bne	a0, a1, .LBB0_1
	j	.LBB0_2
.LBB0_2:                                # %for.exit
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
