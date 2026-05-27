; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/tail-folding-cast-intrinsics.ll
; Variant: riscv64_+v_loop-vectorize_NO-VP
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -tail-folding-policy=dont-fold-tail -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -passes=loop-vectorize  -tail-folding-policy=dont-fold-tail  -mtriple=riscv64 -mattr=+v -S %s | FileCheck %s --check-prefix=NO-VP

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define void @vp_sext(ptr %a, ptr %b, i64 %N) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %0 = load i32, ptr %gep, align 4
  %conv2 = sext i32 %0 to i64
  %gep4 = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %conv2, ptr %gep4, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @vp_zext(ptr %a, ptr %b, i64 %N) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %0 = load i32, ptr %gep, align 4
  %conv = zext i32 %0 to i64
  %gep2 = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %conv, ptr %gep2, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @vp_trunc(ptr %a, ptr %b, i64 %N) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds i64, ptr %b, i64 %iv
  %0 = load i64, ptr %gep, align 8
  %conv = trunc i64 %0 to i32
  %gep2 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %conv, ptr %gep2, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @vp_fpext(ptr %a, ptr %b, i64 %N) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds float, ptr %b, i64 %iv
  %0 = load float, ptr %gep, align 4
  %conv = fpext float %0 to double
  %gep2 = getelementptr inbounds double, ptr %a, i64 %iv
  store double %conv, ptr %gep2, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @vp_fptrunc(ptr %a, ptr %b, i64 %N) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds double, ptr %b, i64 %iv
  %0 = load double, ptr %gep, align 8
  %conv = fptrunc double %0 to float
  %gep2 = getelementptr inbounds float, ptr %a, i64 %iv
  store float %conv, ptr %gep2, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @vp_sitofp(ptr %a, ptr %b, i64 %N) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %0 = load i32, ptr %gep, align 4
  %conv = sitofp i32 %0 to float
  %gep2 = getelementptr inbounds float, ptr %a, i64 %iv
  store float %conv, ptr %gep2, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @vp_uitofp(ptr %a, ptr %b, i64 %N) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %0 = load i32, ptr %gep, align 4
  %conv = uitofp i32 %0 to float
  %gep2 = getelementptr inbounds float, ptr %a, i64 %iv
  store float %conv, ptr %gep2, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @vp_fptosi(ptr %a, ptr %b, i64 %N) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds float, ptr %b, i64 %iv
  %0 = load float, ptr %gep, align 4
  %conv = fptosi float %0 to i32
  %gep2 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %conv, ptr %gep2, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @vp_fptoui(ptr %a, ptr %b, i64 %N) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds float, ptr %b, i64 %iv
  %0 = load float, ptr %gep, align 4
  %conv = fptoui float %0 to i32
  %gep2 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %conv, ptr %gep2, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @vp_inttoptr(ptr %a, ptr %b, i64 %N) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds i64, ptr %b, i64 %iv
  %0 = load i64, ptr %gep, align 8
  %1 = inttoptr i64 %0 to ptr
  %gep2 = getelementptr inbounds ptr, ptr %a, i64 %iv
  store ptr %1, ptr %gep2, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

define void @vp_ptrtoint(ptr %a, ptr %b, i64 %N) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %0 = ptrtoint ptr %gep to i64
  %gep2 = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %0, ptr %gep2, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}
;.
;.
;.

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpbml_e958.ll'
source_filename = "/tmp/tmpbml_e958.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @vp_sext(ptr %a, ptr %b, i64 %N) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 20)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = shl i64 %N, 3
  %scevgep = getelementptr i8, ptr %a, i64 %2
  %3 = shl i64 %N, 2
  %scevgep1 = getelementptr i8, ptr %b, i64 %3
  %bound0 = icmp ult ptr %a, %scevgep1
  %bound1 = icmp ult ptr %b, %scevgep
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %4 = call i64 @llvm.vscale.i64()
  %5 = shl nuw i64 %4, 1
  %n.mod.vf = urem i64 %N, %5
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %6 = getelementptr inbounds i32, ptr %b, i64 %index
  %wide.load = load <vscale x 2 x i32>, ptr %6, align 4, !alias.scope !0
  %7 = sext <vscale x 2 x i32> %wide.load to <vscale x 2 x i64>
  %8 = getelementptr inbounds i64, ptr %a, i64 %index
  store <vscale x 2 x i64> %7, ptr %8, align 8, !alias.scope !3, !noalias !0
  %index.next = add nuw i64 %index, %5
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %iv.next, %loop ], [ %bc.resume.val, %scalar.ph ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %10 = load i32, ptr %gep, align 4
  %conv2 = sext i32 %10 to i64
  %gep4 = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %conv2, ptr %gep4, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !8

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @vp_zext(ptr %a, ptr %b, i64 %N) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 20)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = shl i64 %N, 3
  %scevgep = getelementptr i8, ptr %a, i64 %2
  %3 = shl i64 %N, 2
  %scevgep1 = getelementptr i8, ptr %b, i64 %3
  %bound0 = icmp ult ptr %a, %scevgep1
  %bound1 = icmp ult ptr %b, %scevgep
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %4 = call i64 @llvm.vscale.i64()
  %5 = shl nuw i64 %4, 1
  %n.mod.vf = urem i64 %N, %5
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %6 = getelementptr inbounds i32, ptr %b, i64 %index
  %wide.load = load <vscale x 2 x i32>, ptr %6, align 4, !alias.scope !9
  %7 = zext <vscale x 2 x i32> %wide.load to <vscale x 2 x i64>
  %8 = getelementptr inbounds i64, ptr %a, i64 %index
  store <vscale x 2 x i64> %7, ptr %8, align 8, !alias.scope !12, !noalias !9
  %index.next = add nuw i64 %index, %5
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !14

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %10 = load i32, ptr %gep, align 4
  %conv = zext i32 %10 to i64
  %gep2 = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %conv, ptr %gep2, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !15

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @vp_trunc(ptr %a, ptr %b, i64 %N) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 20)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = shl i64 %N, 2
  %scevgep = getelementptr i8, ptr %a, i64 %2
  %3 = shl i64 %N, 3
  %scevgep1 = getelementptr i8, ptr %b, i64 %3
  %bound0 = icmp ult ptr %a, %scevgep1
  %bound1 = icmp ult ptr %b, %scevgep
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %4 = call i64 @llvm.vscale.i64()
  %5 = shl nuw i64 %4, 1
  %n.mod.vf = urem i64 %N, %5
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %6 = getelementptr inbounds i64, ptr %b, i64 %index
  %wide.load = load <vscale x 2 x i64>, ptr %6, align 8, !alias.scope !16
  %7 = trunc <vscale x 2 x i64> %wide.load to <vscale x 2 x i32>
  %8 = getelementptr inbounds i32, ptr %a, i64 %index
  store <vscale x 2 x i32> %7, ptr %8, align 4, !alias.scope !19, !noalias !16
  %index.next = add nuw i64 %index, %5
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !21

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds i64, ptr %b, i64 %iv
  %10 = load i64, ptr %gep, align 8
  %conv = trunc i64 %10 to i32
  %gep2 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %conv, ptr %gep2, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !22

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @vp_fpext(ptr %a, ptr %b, i64 %N) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 16)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = shl i64 %N, 3
  %scevgep = getelementptr i8, ptr %a, i64 %2
  %3 = shl i64 %N, 2
  %scevgep1 = getelementptr i8, ptr %b, i64 %3
  %bound0 = icmp ult ptr %a, %scevgep1
  %bound1 = icmp ult ptr %b, %scevgep
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %4 = call i64 @llvm.vscale.i64()
  %5 = shl nuw i64 %4, 1
  %n.mod.vf = urem i64 %N, %5
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %6 = getelementptr inbounds float, ptr %b, i64 %index
  %wide.load = load <vscale x 2 x float>, ptr %6, align 4, !alias.scope !23
  %7 = fpext <vscale x 2 x float> %wide.load to <vscale x 2 x double>
  %8 = getelementptr inbounds double, ptr %a, i64 %index
  store <vscale x 2 x double> %7, ptr %8, align 8, !alias.scope !26, !noalias !23
  %index.next = add nuw i64 %index, %5
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !28

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds float, ptr %b, i64 %iv
  %10 = load float, ptr %gep, align 4
  %conv = fpext float %10 to double
  %gep2 = getelementptr inbounds double, ptr %a, i64 %iv
  store double %conv, ptr %gep2, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !29

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @vp_fptrunc(ptr %a, ptr %b, i64 %N) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 16)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = shl i64 %N, 2
  %scevgep = getelementptr i8, ptr %a, i64 %2
  %3 = shl i64 %N, 3
  %scevgep1 = getelementptr i8, ptr %b, i64 %3
  %bound0 = icmp ult ptr %a, %scevgep1
  %bound1 = icmp ult ptr %b, %scevgep
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %4 = call i64 @llvm.vscale.i64()
  %5 = shl nuw i64 %4, 1
  %n.mod.vf = urem i64 %N, %5
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %6 = getelementptr inbounds double, ptr %b, i64 %index
  %wide.load = load <vscale x 2 x double>, ptr %6, align 8, !alias.scope !30
  %7 = fptrunc <vscale x 2 x double> %wide.load to <vscale x 2 x float>
  %8 = getelementptr inbounds float, ptr %a, i64 %index
  store <vscale x 2 x float> %7, ptr %8, align 4, !alias.scope !33, !noalias !30
  %index.next = add nuw i64 %index, %5
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !35

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds double, ptr %b, i64 %iv
  %10 = load double, ptr %gep, align 8
  %conv = fptrunc double %10 to float
  %gep2 = getelementptr inbounds float, ptr %a, i64 %iv
  store float %conv, ptr %gep2, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !36

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @vp_sitofp(ptr %a, ptr %b, i64 %N) #0 {
entry:
  %b2 = ptrtoaddr ptr %b to i64
  %a1 = ptrtoaddr ptr %a to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 16)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %a1, %b2
  %diff.check = icmp ult i64 %5, %4
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %6 = call i64 @llvm.vscale.i64()
  %7 = shl nuw i64 %6, 2
  %n.mod.vf = urem i64 %N, %7
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %8 = getelementptr inbounds i32, ptr %b, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %8, align 4
  %9 = sitofp <vscale x 4 x i32> %wide.load to <vscale x 4 x float>
  %10 = getelementptr inbounds float, ptr %a, i64 %index
  store <vscale x 4 x float> %9, ptr %10, align 4
  %index.next = add nuw i64 %index, %7
  %11 = icmp eq i64 %index.next, %n.vec
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !37

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %12 = load i32, ptr %gep, align 4
  %conv = sitofp i32 %12 to float
  %gep2 = getelementptr inbounds float, ptr %a, i64 %iv
  store float %conv, ptr %gep2, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !38

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @vp_uitofp(ptr %a, ptr %b, i64 %N) #0 {
entry:
  %b2 = ptrtoaddr ptr %b to i64
  %a1 = ptrtoaddr ptr %a to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 16)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %a1, %b2
  %diff.check = icmp ult i64 %5, %4
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %6 = call i64 @llvm.vscale.i64()
  %7 = shl nuw i64 %6, 2
  %n.mod.vf = urem i64 %N, %7
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %8 = getelementptr inbounds i32, ptr %b, i64 %index
  %wide.load = load <vscale x 4 x i32>, ptr %8, align 4
  %9 = uitofp <vscale x 4 x i32> %wide.load to <vscale x 4 x float>
  %10 = getelementptr inbounds float, ptr %a, i64 %index
  store <vscale x 4 x float> %9, ptr %10, align 4
  %index.next = add nuw i64 %index, %7
  %11 = icmp eq i64 %index.next, %n.vec
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !39

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %12 = load i32, ptr %gep, align 4
  %conv = uitofp i32 %12 to float
  %gep2 = getelementptr inbounds float, ptr %a, i64 %iv
  store float %conv, ptr %gep2, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !40

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @vp_fptosi(ptr %a, ptr %b, i64 %N) #0 {
entry:
  %b2 = ptrtoaddr ptr %b to i64
  %a1 = ptrtoaddr ptr %a to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 16)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %a1, %b2
  %diff.check = icmp ult i64 %5, %4
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %6 = call i64 @llvm.vscale.i64()
  %7 = shl nuw i64 %6, 2
  %n.mod.vf = urem i64 %N, %7
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %8 = getelementptr inbounds float, ptr %b, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %8, align 4
  %9 = fptosi <vscale x 4 x float> %wide.load to <vscale x 4 x i32>
  %10 = getelementptr inbounds i32, ptr %a, i64 %index
  store <vscale x 4 x i32> %9, ptr %10, align 4
  %index.next = add nuw i64 %index, %7
  %11 = icmp eq i64 %index.next, %n.vec
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !41

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds float, ptr %b, i64 %iv
  %12 = load float, ptr %gep, align 4
  %conv = fptosi float %12 to i32
  %gep2 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %conv, ptr %gep2, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !42

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @vp_fptoui(ptr %a, ptr %b, i64 %N) #0 {
entry:
  %b2 = ptrtoaddr ptr %b to i64
  %a1 = ptrtoaddr ptr %a to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 16)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 4
  %5 = sub i64 %a1, %b2
  %diff.check = icmp ult i64 %5, %4
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %6 = call i64 @llvm.vscale.i64()
  %7 = shl nuw i64 %6, 2
  %n.mod.vf = urem i64 %N, %7
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %8 = getelementptr inbounds float, ptr %b, i64 %index
  %wide.load = load <vscale x 4 x float>, ptr %8, align 4
  %9 = fptoui <vscale x 4 x float> %wide.load to <vscale x 4 x i32>
  %10 = getelementptr inbounds i32, ptr %a, i64 %index
  store <vscale x 4 x i32> %9, ptr %10, align 4
  %index.next = add nuw i64 %index, %7
  %11 = icmp eq i64 %index.next, %n.vec
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !43

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds float, ptr %b, i64 %iv
  %12 = load float, ptr %gep, align 4
  %conv = fptoui float %12 to i32
  %gep2 = getelementptr inbounds i32, ptr %a, i64 %iv
  store i32 %conv, ptr %gep2, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !44

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @vp_inttoptr(ptr %a, ptr %b, i64 %N) #0 {
entry:
  %b2 = ptrtoaddr ptr %b to i64
  %a1 = ptrtoaddr ptr %a to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 16)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 2
  %4 = mul i64 %3, 8
  %5 = sub i64 %a1, %b2
  %diff.check = icmp ult i64 %5, %4
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %6 = call i64 @llvm.vscale.i64()
  %7 = shl nuw i64 %6, 1
  %n.mod.vf = urem i64 %N, %7
  %n.vec = sub i64 %N, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %8 = getelementptr inbounds i64, ptr %b, i64 %index
  %wide.load = load <vscale x 2 x i64>, ptr %8, align 8
  %9 = inttoptr <vscale x 2 x i64> %wide.load to <vscale x 2 x ptr>
  %10 = getelementptr inbounds ptr, ptr %a, i64 %index
  store <vscale x 2 x ptr> %9, ptr %10, align 8
  %index.next = add nuw i64 %index, %7
  %11 = icmp eq i64 %index.next, %n.vec
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !45

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds i64, ptr %b, i64 %iv
  %12 = load i64, ptr %gep, align 8
  %13 = inttoptr i64 %12 to ptr
  %gep2 = getelementptr inbounds ptr, ptr %a, i64 %iv
  store ptr %13, ptr %gep2, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !46

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @vp_ptrtoint(ptr %a, ptr %b, i64 %N) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 1
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 4)
  %min.iters.check = icmp ult i64 %N, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = call i64 @llvm.vscale.i64()
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 %N, %3
  %n.vec = sub i64 %N, %n.mod.vf
  %4 = call <vscale x 2 x i64> @llvm.stepvector.nxv2i64()
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %3, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <vscale x 2 x i64> [ %4, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %5 = getelementptr inbounds i32, ptr %b, <vscale x 2 x i64> %vec.ind
  %6 = ptrtoint <vscale x 2 x ptr> %5 to <vscale x 2 x i64>
  %7 = getelementptr inbounds i64, ptr %a, i64 %index
  store <vscale x 2 x i64> %6, ptr %7, align 8
  %index.next = add nuw i64 %index, %3
  %vec.ind.next = add nuw nsw <vscale x 2 x i64> %vec.ind, %broadcast.splat
  %8 = icmp eq i64 %index.next, %n.vec
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !47

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %N, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop ]
  %gep = getelementptr inbounds i32, ptr %b, i64 %iv
  %9 = ptrtoint ptr %gep to i64
  %gep2 = getelementptr inbounds i64, ptr %a, i64 %iv
  store i64 %9, ptr %gep2, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %N
  br i1 %exitcond.not, label %exit, label %loop, !llvm.loop !48

exit:                                             ; preds = %middle.block, %loop
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umax.i64(i64, i64) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.stepvector.nxv2i64() #3

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(none) }

!0 = !{!1}
!1 = distinct !{!1, !2}
!2 = distinct !{!2, !"LVerDomain"}
!3 = !{!4}
!4 = distinct !{!4, !2}
!5 = distinct !{!5, !6, !7}
!6 = !{!"llvm.loop.isvectorized", i32 1}
!7 = !{!"llvm.loop.unroll.runtime.disable"}
!8 = distinct !{!8, !6}
!9 = !{!10}
!10 = distinct !{!10, !11}
!11 = distinct !{!11, !"LVerDomain"}
!12 = !{!13}
!13 = distinct !{!13, !11}
!14 = distinct !{!14, !6, !7}
!15 = distinct !{!15, !6}
!16 = !{!17}
!17 = distinct !{!17, !18}
!18 = distinct !{!18, !"LVerDomain"}
!19 = !{!20}
!20 = distinct !{!20, !18}
!21 = distinct !{!21, !6, !7}
!22 = distinct !{!22, !6}
!23 = !{!24}
!24 = distinct !{!24, !25}
!25 = distinct !{!25, !"LVerDomain"}
!26 = !{!27}
!27 = distinct !{!27, !25}
!28 = distinct !{!28, !6, !7}
!29 = distinct !{!29, !6}
!30 = !{!31}
!31 = distinct !{!31, !32}
!32 = distinct !{!32, !"LVerDomain"}
!33 = !{!34}
!34 = distinct !{!34, !32}
!35 = distinct !{!35, !6, !7}
!36 = distinct !{!36, !6}
!37 = distinct !{!37, !6, !7}
!38 = distinct !{!38, !6}
!39 = distinct !{!39, !6, !7}
!40 = distinct !{!40, !6}
!41 = distinct !{!41, !6, !7}
!42 = distinct !{!42, !6}
!43 = distinct !{!43, !6, !7}
!44 = distinct !{!44, !6}
!45 = distinct !{!45, !6, !7}
!46 = distinct !{!46, !6}
!47 = distinct !{!47, !6, !7}
!48 = distinct !{!48, !7, !6}
