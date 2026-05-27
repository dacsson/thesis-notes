# Source: CodeGenPrepare/cttz-ctlz.require_profile-summary__function_codegenprepare_.ll
# Function: cttz_nxv4i64
# src = pre-opt (cttz_nxv4i64), tgt = post-opt (cttz_nxv4i64)
# Triple: riscv64, Attrs: v
#

src:                                    # @src
	.cfi_startproc
# %bb.0:
                                        # implicit-def: $v12m4
	vsetvli	a0, zero, e64, m4, ta, ma
	vrsub.vi	v12, v8, 0
                                        # implicit-def: $v16m4
	vand.vv	v16, v8, v12
	fsrmi	a0, 1
                                        # implicit-def: $v12m4
	vfcvt.f.xu.v	v12, v16
	fsrm	a0
	li	a0, 52
                                        # implicit-def: $v16m4
	vsrl.vx	v16, v12, a0
	li	a0, 1023
                                        # implicit-def: $v12m4
	vsub.vx	v12, v16, a0
	vmseq.vi	v0, v8, 0
	li	a0, 64
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vmerge.vxm	v8, v12, a0, v0
	ret
.Lfunc_end0:
	.size	src, .Lfunc_end0-src
	.cfi_endproc
                                        # -- End function

tgt:                                    # @tgt
	.cfi_startproc
# %bb.0:
                                        # implicit-def: $v12m4
	vsetvli	a0, zero, e64, m4, ta, ma
	vrsub.vi	v12, v8, 0
                                        # implicit-def: $v16m4
	vand.vv	v16, v8, v12
	fsrmi	a0, 1
                                        # implicit-def: $v12m4
	vfcvt.f.xu.v	v12, v16
	fsrm	a0
	li	a0, 52
                                        # implicit-def: $v16m4
	vsrl.vx	v16, v12, a0
	li	a0, 1023
                                        # implicit-def: $v12m4
	vsub.vx	v12, v16, a0
	vmseq.vi	v0, v8, 0
	li	a0, 64
                                        # implicit-def: $v8m4
	vsetvli	zero, zero, e64, m4, tu, ma
	vmerge.vxm	v8, v12, a0, v0
	ret
.Lfunc_end0:
	.size	tgt, .Lfunc_end0-tgt
	.cfi_endproc
                                        # -- End function
