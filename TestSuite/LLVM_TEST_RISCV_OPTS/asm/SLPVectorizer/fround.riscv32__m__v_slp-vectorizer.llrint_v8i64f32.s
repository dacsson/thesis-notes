# Source: SLPVectorizer/fround.riscv32__m__v_slp-vectorizer.ll
# Function: llrint_v8i64f32
# src = pre-opt (llrint_v8i64f32), tgt = post-opt (llrint_v8i64f32)
# Triple: riscv32, Attrs: +m,+v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -208
	.cfi_def_cfa_offset 208
	sw	ra, 204(sp)                     # 4-byte Folded Spill
	sw	s0, 200(sp)                     # 4-byte Folded Spill
	sw	s1, 196(sp)                     # 4-byte Folded Spill
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	addi	s0, sp, 208
	.cfi_def_cfa s0, 0
	csrr	a1, vlenb
	slli	a2, a1, 1
	add	a1, a2, a1
	sub	sp, sp, a1
	andi	sp, sp, -64
                                        # implicit-def: $v8m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vle32.v	v8, (a0)
	csrr	a0, vlenb
	add	a0, sp, a0
	addi	a0, a0, 192
	vs2r.v	v8, (a0)                        # vscale x 16-byte Folded Spill
	addi	a0, sp, 192
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	vfmv.f.s	fa0, v8
	call	llrintf
	addi	a2, sp, 192
	vl1r.v	v9, (a2)                        # vscale x 8-byte Folded Reload
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	mv	s1, a1
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 1
	vfmv.f.s	fa0, v8
	call	llrintf
	addi	a2, sp, 192
	vl1r.v	v9, (a2)                        # vscale x 8-byte Folded Reload
	sw	a0, 56(sp)                      # 4-byte Folded Spill
	sw	a1, 60(sp)                      # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 2
	vfmv.f.s	fa0, v8
	call	llrintf
	addi	a2, sp, 192
	vl1r.v	v9, (a2)                        # vscale x 8-byte Folded Reload
	sw	a0, 52(sp)                      # 4-byte Folded Spill
	sw	a1, 48(sp)                      # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 3
	vfmv.f.s	fa0, v8
	call	llrintf
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 192
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
	sw	a0, 44(sp)                      # 4-byte Folded Spill
	sw	a1, 40(sp)                      # 4-byte Folded Spill
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e32, m2, ta, ma
	vslidedown.vi	v8, v10, 4
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vfmv.f.s	fa0, v8
	call	llrintf
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 192
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
	sw	a0, 36(sp)                      # 4-byte Folded Spill
	sw	a1, 32(sp)                      # 4-byte Folded Spill
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e32, m2, ta, ma
	vslidedown.vi	v8, v10, 5
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vfmv.f.s	fa0, v8
	call	llrintf
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 192
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
	sw	a0, 28(sp)                      # 4-byte Folded Spill
	sw	a1, 24(sp)                      # 4-byte Folded Spill
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e32, m2, ta, ma
	vslidedown.vi	v8, v10, 6
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vfmv.f.s	fa0, v8
	call	llrintf
	csrr	a2, vlenb
	add	a2, sp, a2
	addi	a2, a2, 192
	vl2r.v	v10, (a2)                       # vscale x 16-byte Folded Reload
	sw	a0, 20(sp)                      # 4-byte Folded Spill
	sw	a1, 16(sp)                      # 4-byte Folded Spill
                                        # implicit-def: $v8m2
	vsetivli	zero, 1, e32, m2, ta, ma
	vslidedown.vi	v8, v10, 7
                                        # kill: def $v8 killed $v8 killed $v8m2 killed $vtype
	vfmv.f.s	fa0, v8
	call	llrintf
	lw	t6, 12(sp)                      # 4-byte Folded Reload
	lw	t3, 16(sp)                      # 4-byte Folded Reload
	lw	t2, 20(sp)                      # 4-byte Folded Reload
	lw	t1, 24(sp)                      # 4-byte Folded Reload
	lw	t0, 28(sp)                      # 4-byte Folded Reload
	lw	a7, 32(sp)                      # 4-byte Folded Reload
	lw	a6, 36(sp)                      # 4-byte Folded Reload
	lw	a5, 40(sp)                      # 4-byte Folded Reload
	lw	a4, 44(sp)                      # 4-byte Folded Reload
	lw	a3, 48(sp)                      # 4-byte Folded Reload
	lw	a2, 52(sp)                      # 4-byte Folded Reload
	mv	t4, a0
	lw	a0, 56(sp)                      # 4-byte Folded Reload
	mv	t5, a1
	lw	a1, 60(sp)                      # 4-byte Folded Reload
	sw	s1, 68(sp)
	sw	t6, 64(sp)
	sw	t5, 124(sp)
	sw	t4, 120(sp)
	sw	t3, 116(sp)
	sw	t2, 112(sp)
	sw	t1, 108(sp)
	sw	t0, 104(sp)
	sw	a7, 100(sp)
	sw	a6, 96(sp)
	sw	a5, 92(sp)
	sw	a4, 88(sp)
	sw	a3, 84(sp)
	sw	a2, 80(sp)
	sw	a1, 76(sp)
	sw	a0, 72(sp)
	addi	a0, sp, 64
                                        # implicit-def: $v8m4
	vsetivli	zero, 16, e32, m4, tu, ma
	vle32.v	v8, (a0)
	addi	sp, s0, -208
	.cfi_def_cfa sp, 208
	lw	ra, 204(sp)                     # 4-byte Folded Reload
	lw	s0, 200(sp)                     # 4-byte Folded Reload
	lw	s1, 196(sp)                     # 4-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	.cfi_restore s1
	addi	sp, sp, 208
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end9:
	.size	src, .Lfunc_end9-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v14m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vle32.v	v14, (a0)
	vmv1r.v	v8, v14
                                        # implicit-def: $v12m2
	vsetivli	zero, 4, e32, m1, ta, ma
	vfwcvt.x.f.v	v12, v8
                                        # implicit-def: $v8m4
	vmv2r.v	v8, v12
                                        # implicit-def: $v12m2
	vsetivli	zero, 4, e32, m2, ta, ma
	vslidedown.vi	v12, v14, 4
                                        # kill: def $v12 killed $v12 killed $v12m2 killed $vtype
                                        # implicit-def: $v16m2
	vsetivli	zero, 4, e32, m1, ta, ma
	vfwcvt.x.f.v	v16, v12
                                        # implicit-def: $v12m4
	vmv2r.v	v12, v16
	vmv2r.v	v14, v16
	vsetivli	zero, 8, e64, m4, ta, ma
	vslideup.vi	v8, v12, 4
	ret
.Lfunc_end9:
	.size	tgt, .Lfunc_end9-tgt
	.cfi_endproc
                                        # -- End function
