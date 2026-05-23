# Source: SLPVectorizer/scalable-type-to-vect.riscv64-unknown-unknown__v_slp-vectorizer.ll
# Function: foo
# src = pre-opt (foo), tgt = post-opt (foo)
# Triple: riscv64-unknown-unknown, Attrs: +v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v9
	vsetvli	a0, zero, e32, m1, tu, ma
	vmv.v.i	v9, 0
	vmv1r.v	v8, v9
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:                                # %entry
                                        # implicit-def: $v9
	vsetvli	a0, zero, e32, m1, tu, ma
	vmv.v.i	v9, 0
	vmv1r.v	v8, v9
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
