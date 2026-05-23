# Source: VectorCombine/shuffle-of-intrinsics.riscv64__v_vector-combine.ll
# Function: test4
# src = pre-opt (test4), tgt = post-opt (test4)
# Triple: riscv64, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
	vsetivli	zero, 8, e8, mf2, ta, ma
	vmclr.m	v0
	ret
.Lfunc_end3:
	.size	src, .Lfunc_end3-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
	vsetivli	zero, 8, e8, mf2, ta, ma
	vmclr.m	v0
	ret
.Lfunc_end3:
	.size	tgt, .Lfunc_end3-tgt
	.cfi_endproc
                                        # -- End function
