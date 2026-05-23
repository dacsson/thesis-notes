# Source: CodeGenPrepare/cttz-ctlz.require_profile-summary__function_codegenprepare_.ll
# Function: ctlz_nxv4i64
# src = pre-opt (ctlz_nxv4i64), tgt = post-opt (ctlz_nxv4i64)
# Triple: riscv64, Attrs: v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
	fsrmi	a0, 1
                                        # implicit-def: $v12m4
	vsetvli	a1, zero, e64, m4, ta, ma
	vfcvt.f.xu.v	v12, v8
	fsrm	a0
	li	a0, 52
                                        # implicit-def: $v8m4
	vsrl.vx	v8, v12, a0
	li	a0, 1086
                                        # implicit-def: $v12m4
	vrsub.vx	v12, v8, a0
	li	a0, 64
                                        # implicit-def: $v8m4
	vminu.vx	v8, v12, a0
	ret
.Lfunc_end1:
	.size	src, .Lfunc_end1-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
	fsrmi	a0, 1
                                        # implicit-def: $v12m4
	vsetvli	a1, zero, e64, m4, ta, ma
	vfcvt.f.xu.v	v12, v8
	fsrm	a0
	li	a0, 52
                                        # implicit-def: $v8m4
	vsrl.vx	v8, v12, a0
	li	a0, 1086
                                        # implicit-def: $v12m4
	vrsub.vx	v12, v8, a0
	li	a0, 64
                                        # implicit-def: $v8m4
	vminu.vx	v8, v12, a0
	ret
.Lfunc_end1:
	.size	tgt, .Lfunc_end1-tgt
	.cfi_endproc
                                        # -- End function
