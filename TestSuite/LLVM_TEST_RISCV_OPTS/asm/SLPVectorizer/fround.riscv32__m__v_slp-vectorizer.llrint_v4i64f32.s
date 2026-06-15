# Source: SLPVectorizer/fround.riscv32__m__v_slp-vectorizer.ll
# Function: llrint_v4i64f32
# src = pre-opt (llrint_v4i64f32), tgt = post-opt (llrint_v4i64f32)
# Triple: riscv32, Attrs: +m,+v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	.cfi_offset ra, -4
	csrr	a1, vlenb
	sub	sp, sp, a1
	.cfi_escape 0x0f, 0x0e, 0x72, 0x00, 0x11, 0xc0, 0x00, 0x22, 0x11, 0x01, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 64 + 1 * vlenb
                                        # implicit-def: $v8
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v8, (a0)
	addi	a0, sp, 48
	vs1r.v	v8, (a0)                        # vscale x 8-byte Folded Spill
	vfmv.f.s	fa0, v8
	call	llrintf
	addi	a2, sp, 48
	vl1r.v	v9, (a2)                        # vscale x 8-byte Folded Reload
	sw	a0, 20(sp)                      # 4-byte Folded Spill
	sw	a1, 24(sp)                      # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 1
	vfmv.f.s	fa0, v8
	call	llrintf
	addi	a2, sp, 48
	vl1r.v	v9, (a2)                        # vscale x 8-byte Folded Reload
	sw	a0, 28(sp)                      # 4-byte Folded Spill
	sw	a1, 32(sp)                      # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 2
	vfmv.f.s	fa0, v8
	call	llrintf
	addi	a2, sp, 48
	vl1r.v	v9, (a2)                        # vscale x 8-byte Folded Reload
	sw	a0, 36(sp)                      # 4-byte Folded Spill
	sw	a1, 40(sp)                      # 4-byte Folded Spill
                                        # implicit-def: $v8
	vsetivli	zero, 1, e32, m1, ta, ma
	vslidedown.vi	v8, v9, 3
	vfmv.f.s	fa0, v8
	call	llrintf
	lw	a7, 20(sp)                      # 4-byte Folded Reload
	lw	a6, 24(sp)                      # 4-byte Folded Reload
	lw	a5, 28(sp)                      # 4-byte Folded Reload
	lw	a4, 32(sp)                      # 4-byte Folded Reload
	lw	a3, 36(sp)                      # 4-byte Folded Reload
	lw	a2, 40(sp)                      # 4-byte Folded Reload
                                        # implicit-def: $v10m2
	vsetivli	zero, 8, e32, m2, tu, ma
	vmv.v.x	v10, a7
                                        # implicit-def: $v8m2
	vslide1down.vx	v8, v10, a6
                                        # implicit-def: $v10m2
	vslide1down.vx	v10, v8, a5
                                        # implicit-def: $v8m2
	vslide1down.vx	v8, v10, a4
                                        # implicit-def: $v10m2
	vslide1down.vx	v10, v8, a3
                                        # implicit-def: $v8m2
	vslide1down.vx	v8, v10, a2
                                        # implicit-def: $v10m2
	vslide1down.vx	v10, v8, a0
                                        # implicit-def: $v8m2
	vslide1down.vx	v8, v10, a1
	csrr	a0, vlenb
	add	sp, sp, a0
	.cfi_def_cfa sp, 64
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	.cfi_restore ra
	addi	sp, sp, 64
	.cfi_def_cfa_offset 0
	ret
.Lfunc_end8:
	.size	src, .Lfunc_end8-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v10
	vsetivli	zero, 4, e32, m1, tu, ma
	vle32.v	v10, (a0)
                                        # implicit-def: $v8m2
	vsetvli	zero, zero, e32, m1, ta, ma
	vfwcvt.x.f.v	v8, v10
	ret
.Lfunc_end8:
	.size	tgt, .Lfunc_end8-tgt
	.cfi_endproc
                                        # -- End function
