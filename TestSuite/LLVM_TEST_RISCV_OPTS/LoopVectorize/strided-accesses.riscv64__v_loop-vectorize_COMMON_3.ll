; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/strided-accesses.ll
; Variant: riscv64_+v_loop-vectorize_COMMON_3
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple=riscv64 -mattr=+v -lv-strided-pointer-ivs=true -laa-speculate-unit-stride=false -force-vector-interleave=2 -S
; Original: RUN: opt < %s -passes=loop-vectorize -mtriple=riscv64 -mattr=+v -lv-strided-pointer-ivs=true -laa-speculate-unit-stride=false -force-vector-interleave=2 -S | FileCheck --check-prefixes=COMMON,STRIDED-COMMON,CHECK-UF2,STRIDED-UF2 %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================



define void @single_constant_stride_int_scaled(ptr %p) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]

  %offset = mul nsw nuw i64 %i, 8
  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %q0

  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

define void @single_constant_stride_int_iv(ptr %p) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]
  %offset = phi i64 [0, %entry], [%offset.next, %loop]

  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %q0

  %offset.next = add nsw nuw i64 %offset, 64
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}


define void @single_constant_stride_ptr_iv(ptr %p) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]
  %ptr = phi ptr [%p, %entry], [%ptr.next, %loop]

  %x0 = load i32, ptr %ptr
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %ptr

  %ptr.next = getelementptr inbounds i8, ptr %ptr, i64 8
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}


define void @single_stride_int_scaled(ptr %p, i64 %stride) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]

  %offset = mul nsw nuw i64 %i, %stride
  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %q0

  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

define void @single_stride_int_iv(ptr %p, i64 %stride) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]
  %offset = phi i64 [0, %entry], [%offset.next, %loop]

  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %q0

  %offset.next = add nsw nuw i64 %offset, %stride
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}


define void @single_stride_ptr_iv(ptr %p, i64 %stride) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]
  %ptr = phi ptr [%p, %entry], [%ptr.next, %loop]

  %x0 = load i32, ptr %ptr
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %ptr

  %ptr.next = getelementptr inbounds i8, ptr %ptr, i64 %stride
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

define void @double_stride_int_scaled(ptr %p, ptr %p2, i64 %stride) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]

  %offset = mul nsw nuw i64 %i, %stride
  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0
  %y0 = add i32 %x0, 1
  %q1 = getelementptr i32, ptr %p2, i64 %offset
  store i32 %y0, ptr %q1

  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

define void @double_stride_int_iv(ptr %p, ptr %p2, i64 %stride) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]
  %offset = phi i64 [0, %entry], [%offset.next, %loop]

  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0
  %y0 = add i32 %x0, 1
  %q1 = getelementptr i32, ptr %p, i64 %offset
  store i32 %y0, ptr %q1

  %offset.next = add nsw nuw i64 %offset, %stride
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

define void @double_stride_ptr_iv(ptr %p, ptr %p2, i64 %stride) {
entry:
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%nexti, %loop]
  %ptr = phi ptr [%p, %entry], [%ptr.next, %loop]
  %ptr2 = phi ptr [%p2, %entry], [%ptr2.next, %loop]

  %x0 = load i32, ptr %ptr
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %ptr2

  %ptr.next = getelementptr inbounds i8, ptr %ptr, i64 %stride
  %ptr2.next = getelementptr inbounds i8, ptr %ptr2, i64 %stride
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

; The %in pointer strides in 32-bit steps, but the load accesses in 64-bit.
; This checks handling of mismatched stride and access size.
; void reinterpret(int32_t* in, int64_t* out) {
;   for (unsigned i = 0; i < 1024; i++) {
;     int64_t val = *reinterpret_cast<int64_t*>(&in[i]);
;     out[i] = val;
;   }
; }
define void @constant_stride_reinterpret(ptr noalias %in, ptr noalias %out) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %arrayidx = getelementptr inbounds nuw i32, ptr %in, i64 %iv
  %0 = load i64, ptr %arrayidx, align 8
  %arrayidx2 = getelementptr inbounds nuw i64, ptr %out, i64 %iv
  store i64 %0, ptr %arrayidx2, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop

exit:
  ret void
}

; Check that an access pattern matching as both an interleave group and a
; strided access at the same time is vectorized as an interleaved load rather
; than a strided load.
define void @interleaved_load_instead_of_strided(ptr %a) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %base = getelementptr [4 x i32], ptr %a, i64 %iv
  %v0 = load i32, ptr %base, align 4
  %p1 = getelementptr i8, ptr %base, i64 4
  %v1 = load i32, ptr %p1, align 4
  %p3 = getelementptr i8, ptr %base, i64 12
  %v3 = load i32, ptr %p3, align 4
  %add0 = add i32 %v0, %v1
  %add1 = add i32 %add0, %v3
  store i32 %add1, ptr %base, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop

exit:
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpnkwtpw8h.ll'
source_filename = "/tmp/tmpnkwtpw8h.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @single_constant_stride_int_scaled(ptr %p) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 3
  %min.iters.check = icmp ule i64 1024, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %2, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 1024, %3
  %4 = icmp eq i64 %n.mod.vf, 0
  %5 = select i1 %4, i64 %3, i64 %n.mod.vf
  %n.vec = sub i64 1024, %5
  %6 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <vscale x 4 x i64> [ %6, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %step.add = add nuw <vscale x 4 x i64> %vec.ind, %broadcast.splat
  %7 = shl nuw nsw <vscale x 4 x i64> %vec.ind, splat (i64 3)
  %8 = shl nuw nsw <vscale x 4 x i64> %step.add, splat (i64 3)
  %9 = getelementptr i32, ptr %p, <vscale x 4 x i64> %7
  %10 = getelementptr i32, ptr %p, <vscale x 4 x i64> %8
  %wide.masked.gather = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %9, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> poison)
  %wide.masked.gather1 = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %10, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> poison)
  %11 = add <vscale x 4 x i32> %wide.masked.gather, splat (i32 1)
  %12 = add <vscale x 4 x i32> %wide.masked.gather1, splat (i32 1)
  call void @llvm.masked.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %11, <vscale x 4 x ptr> align 4 %9, <vscale x 4 x i1> splat (i1 true))
  call void @llvm.masked.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %12, <vscale x 4 x ptr> align 4 %10, <vscale x 4 x i1> splat (i1 true))
  %index.next = add nuw i64 %index, %3
  %vec.ind.next = add <vscale x 4 x i64> %step.add, %broadcast.splat
  %13 = icmp eq i64 %index.next, %n.vec
  br i1 %13, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %i = phi i64 [ %bc.resume.val, %scalar.ph ], [ %nexti, %loop ]
  %offset = mul nuw nsw i64 %i, 8
  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0, align 4
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %q0, align 4
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !3

exit:                                             ; preds = %loop
  ret void
}

define void @single_constant_stride_int_iv(ptr %p) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 3
  %min.iters.check = icmp ult i64 1024, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %2, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 1024, %3
  %n.vec = sub i64 1024, %n.mod.vf
  %4 = shl i64 %n.vec, 6
  %5 = shl <vscale x 4 x i64> %broadcast.splat, splat (i64 6)
  %6 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  %7 = mul nuw nsw <vscale x 4 x i64> %6, splat (i64 64)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <vscale x 4 x i64> [ %7, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %step.add = add nuw nsw <vscale x 4 x i64> %vec.ind, %5
  %8 = getelementptr i32, ptr %p, <vscale x 4 x i64> %vec.ind
  %9 = getelementptr i32, ptr %p, <vscale x 4 x i64> %step.add
  %wide.masked.gather = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %8, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> poison)
  %wide.masked.gather1 = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %9, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> poison)
  %10 = add <vscale x 4 x i32> %wide.masked.gather, splat (i32 1)
  %11 = add <vscale x 4 x i32> %wide.masked.gather1, splat (i32 1)
  call void @llvm.masked.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %10, <vscale x 4 x ptr> align 4 %8, <vscale x 4 x i1> splat (i1 true))
  call void @llvm.masked.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %11, <vscale x 4 x ptr> align 4 %9, <vscale x 4 x i1> splat (i1 true))
  %index.next = add nuw i64 %index, %3
  %vec.ind.next = add nuw nsw <vscale x 4 x i64> %step.add, %5
  %12 = icmp eq i64 %index.next, %n.vec
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.resume.val2 = phi i64 [ %4, %middle.block ], [ 0, %entry ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %i = phi i64 [ %bc.resume.val, %scalar.ph ], [ %nexti, %loop ]
  %offset = phi i64 [ %bc.resume.val2, %scalar.ph ], [ %offset.next, %loop ]
  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0, align 4
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %q0, align 4
  %offset.next = add nuw nsw i64 %offset, 64
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !5

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @single_constant_stride_ptr_iv(ptr %p) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 3
  %min.iters.check = icmp ule i64 1024, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %2, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 1024, %3
  %4 = icmp eq i64 %n.mod.vf, 0
  %5 = select i1 %4, i64 %3, i64 %n.mod.vf
  %n.vec = sub i64 1024, %5
  %6 = shl i64 %n.vec, 3
  %7 = getelementptr i8, ptr %p, i64 %6
  %8 = shl <vscale x 4 x i64> %broadcast.splat, splat (i64 3)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %pointer.phi = phi ptr [ %p, %vector.ph ], [ %ptr.ind, %vector.body ]
  %9 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  %10 = shl <vscale x 4 x i64> %9, splat (i64 3)
  %vector.gep = getelementptr i8, ptr %pointer.phi, <vscale x 4 x i64> %10
  %11 = extractelement <vscale x 4 x ptr> %vector.gep, i64 0
  %step.add = getelementptr i8, <vscale x 4 x ptr> %vector.gep, <vscale x 4 x i64> %8
  %wide.vec = load <vscale x 8 x i32>, ptr %11, align 4
  %strided.vec = call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave2.nxv8i32(<vscale x 8 x i32> %wide.vec)
  %12 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 0
  %13 = extractelement <vscale x 4 x ptr> %step.add, i64 0
  %wide.vec1 = load <vscale x 8 x i32>, ptr %13, align 4
  %strided.vec2 = call { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave2.nxv8i32(<vscale x 8 x i32> %wide.vec1)
  %14 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec2, 0
  %15 = add <vscale x 4 x i32> %12, splat (i32 1)
  %16 = add <vscale x 4 x i32> %14, splat (i32 1)
  call void @llvm.masked.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %15, <vscale x 4 x ptr> align 4 %vector.gep, <vscale x 4 x i1> splat (i1 true))
  call void @llvm.masked.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %16, <vscale x 4 x ptr> align 4 %step.add, <vscale x 4 x i1> splat (i1 true))
  %index.next = add nuw i64 %index, %3
  %17 = shl i64 %3, 3
  %ptr.ind = getelementptr i8, ptr %pointer.phi, i64 %17
  %18 = icmp eq i64 %index.next, %n.vec
  br i1 %18, label %middle.block, label %vector.body, !llvm.loop !6

middle.block:                                     ; preds = %vector.body
  br label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  %bc.resume.val3 = phi ptr [ %7, %middle.block ], [ %p, %entry ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %i = phi i64 [ %bc.resume.val, %scalar.ph ], [ %nexti, %loop ]
  %ptr = phi ptr [ %bc.resume.val3, %scalar.ph ], [ %ptr.next, %loop ]
  %x0 = load i32, ptr %ptr, align 4
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %ptr, align 4
  %ptr.next = getelementptr inbounds i8, ptr %ptr, i64 8
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !7

exit:                                             ; preds = %loop
  ret void
}

define void @single_stride_int_scaled(ptr %p, i64 %stride) #0 {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %i = phi i64 [ 0, %entry ], [ %nexti, %loop ]
  %offset = mul nuw nsw i64 %i, %stride
  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0, align 4
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %q0, align 4
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop

exit:                                             ; preds = %loop
  ret void
}

define void @single_stride_int_iv(ptr %p, i64 %stride) #0 {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %i = phi i64 [ 0, %entry ], [ %nexti, %loop ]
  %offset = phi i64 [ 0, %entry ], [ %offset.next, %loop ]
  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0, align 4
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %q0, align 4
  %offset.next = add nuw nsw i64 %offset, %stride
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop

exit:                                             ; preds = %loop
  ret void
}

define void @single_stride_ptr_iv(ptr %p, i64 %stride) #0 {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %i = phi i64 [ 0, %entry ], [ %nexti, %loop ]
  %ptr = phi ptr [ %p, %entry ], [ %ptr.next, %loop ]
  %x0 = load i32, ptr %ptr, align 4
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %ptr, align 4
  %ptr.next = getelementptr inbounds i8, ptr %ptr, i64 %stride
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop

exit:                                             ; preds = %loop
  ret void
}

define void @double_stride_int_scaled(ptr %p, ptr %p2, i64 %stride) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 3
  %umax9 = call i64 @llvm.umax.i64(i64 %1, i64 79)
  %min.iters.check = icmp ult i64 1024, %umax9
  br i1 %min.iters.check, label %scalar.ph, label %vector.scevcheck

vector.scevcheck:                                 ; preds = %entry
  %2 = shl i64 %stride, 2
  %3 = mul i64 %stride, -4
  %4 = icmp slt i64 %2, 0
  %5 = select i1 %4, i64 %3, i64 %2
  %mul = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %5, i64 1023)
  %mul.result = extractvalue { i64, i1 } %mul, 0
  %mul.overflow = extractvalue { i64, i1 } %mul, 1
  %6 = sub i64 0, %mul.result
  %7 = getelementptr i8, ptr %p2, i64 %mul.result
  %8 = getelementptr i8, ptr %p2, i64 %6
  %9 = icmp ult ptr %7, %p2
  %10 = icmp ugt ptr %8, %p2
  %11 = select i1 %4, i1 %10, i1 %9
  %12 = or i1 %11, %mul.overflow
  %13 = icmp slt i64 %2, 0
  %14 = select i1 %13, i64 %3, i64 %2
  %mul1 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %14, i64 1023)
  %mul.result2 = extractvalue { i64, i1 } %mul1, 0
  %mul.overflow3 = extractvalue { i64, i1 } %mul1, 1
  %15 = sub i64 0, %mul.result2
  %16 = getelementptr i8, ptr %p, i64 %mul.result2
  %17 = getelementptr i8, ptr %p, i64 %15
  %18 = icmp ult ptr %16, %p
  %19 = icmp ugt ptr %17, %p
  %20 = select i1 %13, i1 %19, i1 %18
  %21 = or i1 %20, %mul.overflow3
  %22 = or i1 %12, %21
  br i1 %22, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %vector.scevcheck
  %23 = mul i64 %stride, 4092
  %scevgep = getelementptr i8, ptr %p2, i64 %23
  %24 = icmp ult ptr %p2, %scevgep
  %umin = select i1 %24, ptr %p2, ptr %scevgep
  %25 = icmp ugt ptr %p2, %scevgep
  %umax = select i1 %25, ptr %p2, ptr %scevgep
  %scevgep4 = getelementptr i8, ptr %umax, i64 4
  %scevgep5 = getelementptr i8, ptr %p, i64 %23
  %26 = icmp ult ptr %p, %scevgep5
  %umin6 = select i1 %26, ptr %p, ptr %scevgep5
  %27 = icmp ugt ptr %p, %scevgep5
  %umax7 = select i1 %27, ptr %p, ptr %scevgep5
  %scevgep8 = getelementptr i8, ptr %umax7, i64 4
  %bound0 = icmp ult ptr %umin, %scevgep8
  %bound1 = icmp ult ptr %umin6, %scevgep4
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %28 = call i64 @llvm.vscale.i64()
  %29 = shl nuw i64 %28, 2
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %29, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %30 = shl nuw i64 %29, 1
  %n.mod.vf = urem i64 1024, %30
  %n.vec = sub i64 1024, %n.mod.vf
  %broadcast.splatinsert10 = insertelement <vscale x 4 x i64> poison, i64 %stride, i64 0
  %broadcast.splat11 = shufflevector <vscale x 4 x i64> %broadcast.splatinsert10, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %31 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <vscale x 4 x i64> [ %31, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %step.add = add nuw <vscale x 4 x i64> %vec.ind, %broadcast.splat
  %32 = mul nuw nsw <vscale x 4 x i64> %vec.ind, %broadcast.splat11
  %33 = mul nuw nsw <vscale x 4 x i64> %step.add, %broadcast.splat11
  %34 = getelementptr i32, ptr %p, <vscale x 4 x i64> %32
  %35 = getelementptr i32, ptr %p, <vscale x 4 x i64> %33
  %wide.masked.gather = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %34, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> poison), !alias.scope !8
  %wide.masked.gather12 = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %35, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> poison), !alias.scope !8
  %36 = add <vscale x 4 x i32> %wide.masked.gather, splat (i32 1)
  %37 = add <vscale x 4 x i32> %wide.masked.gather12, splat (i32 1)
  %38 = getelementptr i32, ptr %p2, <vscale x 4 x i64> %32
  %39 = getelementptr i32, ptr %p2, <vscale x 4 x i64> %33
  call void @llvm.masked.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %36, <vscale x 4 x ptr> align 4 %38, <vscale x 4 x i1> splat (i1 true)), !alias.scope !11, !noalias !8
  call void @llvm.masked.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %37, <vscale x 4 x ptr> align 4 %39, <vscale x 4 x i1> splat (i1 true)), !alias.scope !11, !noalias !8
  %index.next = add nuw i64 %index, %30
  %vec.ind.next = add <vscale x 4 x i64> %step.add, %broadcast.splat
  %40 = icmp eq i64 %index.next, %n.vec
  br i1 %40, label %middle.block, label %vector.body, !llvm.loop !13

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %vector.scevcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.scevcheck ], [ 0, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %i = phi i64 [ %bc.resume.val, %scalar.ph ], [ %nexti, %loop ]
  %offset = mul nuw nsw i64 %i, %stride
  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0, align 4
  %y0 = add i32 %x0, 1
  %q1 = getelementptr i32, ptr %p2, i64 %offset
  store i32 %y0, ptr %q1, align 4
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !14

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @double_stride_int_iv(ptr %p, ptr %p2, i64 %stride) #0 {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %i = phi i64 [ 0, %entry ], [ %nexti, %loop ]
  %offset = phi i64 [ 0, %entry ], [ %offset.next, %loop ]
  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0, align 4
  %y0 = add i32 %x0, 1
  %q1 = getelementptr i32, ptr %p, i64 %offset
  store i32 %y0, ptr %q1, align 4
  %offset.next = add nuw nsw i64 %offset, %stride
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop

exit:                                             ; preds = %loop
  ret void
}

define void @double_stride_ptr_iv(ptr %p, ptr %p2, i64 %stride) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 3
  %umax6 = call i64 @llvm.umax.i64(i64 %1, i64 28)
  %min.iters.check = icmp ult i64 1024, %umax6
  br i1 %min.iters.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %2 = mul i64 %stride, 1023
  %scevgep = getelementptr i8, ptr %p2, i64 %2
  %3 = icmp ult ptr %p2, %scevgep
  %umin = select i1 %3, ptr %p2, ptr %scevgep
  %4 = icmp ugt ptr %p2, %scevgep
  %umax = select i1 %4, ptr %p2, ptr %scevgep
  %scevgep1 = getelementptr i8, ptr %umax, i64 4
  %scevgep2 = getelementptr i8, ptr %p, i64 %2
  %5 = icmp ult ptr %p, %scevgep2
  %umin3 = select i1 %5, ptr %p, ptr %scevgep2
  %6 = icmp ugt ptr %p, %scevgep2
  %umax4 = select i1 %6, ptr %p, ptr %scevgep2
  %scevgep5 = getelementptr i8, ptr %umax4, i64 4
  %bound0 = icmp ult ptr %umin, %scevgep5
  %bound1 = icmp ult ptr %umin3, %scevgep1
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %7 = call i64 @llvm.vscale.i64()
  %8 = shl nuw i64 %7, 2
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %8, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %9 = shl nuw i64 %8, 1
  %n.mod.vf = urem i64 1024, %9
  %n.vec = sub i64 1024, %n.mod.vf
  %broadcast.splatinsert7 = insertelement <vscale x 4 x i64> poison, i64 %stride, i64 0
  %broadcast.splat8 = shufflevector <vscale x 4 x i64> %broadcast.splatinsert7, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %10 = mul i64 %n.vec, %stride
  %11 = getelementptr i8, ptr %p, i64 %10
  %12 = getelementptr i8, ptr %p2, i64 %10
  %13 = mul <vscale x 4 x i64> %broadcast.splat, %broadcast.splat8
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %pointer.phi = phi ptr [ %p, %vector.ph ], [ %ptr.ind, %vector.body ]
  %pointer.phi9 = phi ptr [ %p2, %vector.ph ], [ %ptr.ind15, %vector.body ]
  %14 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  %broadcast.splatinsert10 = insertelement <vscale x 4 x i64> poison, i64 %stride, i64 0
  %broadcast.splat11 = shufflevector <vscale x 4 x i64> %broadcast.splatinsert10, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %15 = mul <vscale x 4 x i64> %14, %broadcast.splat11
  %vector.gep = getelementptr i8, ptr %pointer.phi9, <vscale x 4 x i64> %15
  %vector.gep12 = getelementptr i8, ptr %pointer.phi, <vscale x 4 x i64> %15
  %step.add = getelementptr i8, <vscale x 4 x ptr> %vector.gep12, <vscale x 4 x i64> %13
  %step.add13 = getelementptr i8, <vscale x 4 x ptr> %vector.gep, <vscale x 4 x i64> %13
  %wide.masked.gather = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %vector.gep12, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> poison), !alias.scope !15
  %wide.masked.gather14 = call <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %step.add, <vscale x 4 x i1> splat (i1 true), <vscale x 4 x i32> poison), !alias.scope !15
  %16 = add <vscale x 4 x i32> %wide.masked.gather, splat (i32 1)
  %17 = add <vscale x 4 x i32> %wide.masked.gather14, splat (i32 1)
  call void @llvm.masked.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %16, <vscale x 4 x ptr> align 4 %vector.gep, <vscale x 4 x i1> splat (i1 true)), !alias.scope !18, !noalias !15
  call void @llvm.masked.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %17, <vscale x 4 x ptr> align 4 %step.add13, <vscale x 4 x i1> splat (i1 true)), !alias.scope !18, !noalias !15
  %index.next = add nuw i64 %index, %9
  %18 = mul i64 %stride, %9
  %ptr.ind = getelementptr i8, ptr %pointer.phi, i64 %18
  %ptr.ind15 = getelementptr i8, ptr %pointer.phi9, i64 %18
  %19 = icmp eq i64 %index.next, %n.vec
  br i1 %19, label %middle.block, label %vector.body, !llvm.loop !20

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.memcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.memcheck ]
  %bc.resume.val16 = phi ptr [ %11, %middle.block ], [ %p, %entry ], [ %p, %vector.memcheck ]
  %bc.resume.val17 = phi ptr [ %12, %middle.block ], [ %p2, %entry ], [ %p2, %vector.memcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %i = phi i64 [ %bc.resume.val, %scalar.ph ], [ %nexti, %loop ]
  %ptr = phi ptr [ %bc.resume.val16, %scalar.ph ], [ %ptr.next, %loop ]
  %ptr2 = phi ptr [ %bc.resume.val17, %scalar.ph ], [ %ptr2.next, %loop ]
  %x0 = load i32, ptr %ptr, align 4
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %ptr2, align 4
  %ptr.next = getelementptr inbounds i8, ptr %ptr, i64 %stride
  %ptr2.next = getelementptr inbounds i8, ptr %ptr2, i64 %stride
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !21

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @constant_stride_reinterpret(ptr noalias %in, ptr noalias %out) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 2
  %min.iters.check = icmp ult i64 1024, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 1
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %2, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 1024, %3
  %n.vec = sub i64 1024, %n.mod.vf
  %4 = call <vscale x 2 x i64> @llvm.stepvector.nxv2i64()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <vscale x 2 x i64> [ %4, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %step.add = add nuw <vscale x 2 x i64> %vec.ind, %broadcast.splat
  %5 = getelementptr inbounds nuw i32, ptr %in, <vscale x 2 x i64> %vec.ind
  %6 = getelementptr inbounds nuw i32, ptr %in, <vscale x 2 x i64> %step.add
  %wide.masked.gather = call <vscale x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0(<vscale x 2 x ptr> align 8 %5, <vscale x 2 x i1> splat (i1 true), <vscale x 2 x i64> poison)
  %wide.masked.gather1 = call <vscale x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0(<vscale x 2 x ptr> align 8 %6, <vscale x 2 x i1> splat (i1 true), <vscale x 2 x i64> poison)
  %7 = getelementptr inbounds nuw i64, ptr %out, i64 %index
  %8 = getelementptr inbounds nuw i64, ptr %7, i64 %2
  store <vscale x 2 x i64> %wide.masked.gather, ptr %7, align 8
  store <vscale x 2 x i64> %wide.masked.gather1, ptr %8, align 8
  %index.next = add nuw i64 %index, %3
  %vec.ind.next = add nuw nsw <vscale x 2 x i64> %step.add, %broadcast.splat
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !22

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop ]
  %arrayidx = getelementptr inbounds nuw i32, ptr %in, i64 %iv
  %10 = load i64, ptr %arrayidx, align 8
  %arrayidx2 = getelementptr inbounds nuw i64, ptr %out, i64 %iv
  store i64 %10, ptr %arrayidx2, align 8
  %iv.next = add nuw nsw i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !23

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @interleaved_load_instead_of_strided(ptr %a) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 3
  %min.iters.check = icmp ult i64 1024, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %entry
  %2 = shl nuw i64 %0, 2
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %2, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 1024, %3
  %n.vec = sub i64 1024, %n.mod.vf
  %4 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <vscale x 4 x i64> [ %4, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %step.add = add nuw <vscale x 4 x i64> %vec.ind, %broadcast.splat
  %5 = getelementptr [4 x i32], ptr %a, <vscale x 4 x i64> %vec.ind
  %6 = extractelement <vscale x 4 x ptr> %5, i64 0
  %7 = getelementptr [4 x i32], ptr %a, <vscale x 4 x i64> %step.add
  %8 = extractelement <vscale x 4 x ptr> %7, i64 0
  %wide.vec = load <vscale x 16 x i32>, ptr %6, align 4
  %strided.vec = call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave4.nxv16i32(<vscale x 16 x i32> %wide.vec)
  %9 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 0
  %10 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 1
  %11 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 3
  %wide.vec1 = load <vscale x 16 x i32>, ptr %8, align 4
  %strided.vec2 = call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave4.nxv16i32(<vscale x 16 x i32> %wide.vec1)
  %12 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec2, 0
  %13 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec2, 1
  %14 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec2, 3
  %15 = add <vscale x 4 x i32> %9, %10
  %16 = add <vscale x 4 x i32> %12, %13
  %17 = add <vscale x 4 x i32> %15, %11
  %18 = add <vscale x 4 x i32> %16, %14
  call void @llvm.masked.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %17, <vscale x 4 x ptr> align 4 %5, <vscale x 4 x i1> splat (i1 true))
  call void @llvm.masked.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %18, <vscale x 4 x ptr> align 4 %7, <vscale x 4 x i1> splat (i1 true))
  %index.next = add nuw i64 %index, %3
  %vec.ind.next = add nuw nsw <vscale x 4 x i64> %step.add, %broadcast.splat
  %19 = icmp eq i64 %index.next, %n.vec
  br i1 %19, label %middle.block, label %vector.body, !llvm.loop !24

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %iv.next, %loop ]
  %base = getelementptr [4 x i32], ptr %a, i64 %iv
  %v0 = load i32, ptr %base, align 4
  %p1 = getelementptr i8, ptr %base, i64 4
  %v1 = load i32, ptr %p1, align 4
  %p3 = getelementptr i8, ptr %base, i64 12
  %v3 = load i32, ptr %p3, align 4
  %add0 = add i32 %v0, %v1
  %add1 = add i32 %add0, %v3
  store i32 %add1, ptr %base, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %done = icmp eq i64 %iv.next, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !25

exit:                                             ; preds = %middle.block, %loop
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i64> @llvm.stepvector.nxv4i64() #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 4 x i32> @llvm.masked.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr>, <vscale x 4 x i1>, <vscale x 4 x i32>) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.masked.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32>, <vscale x 4 x ptr>, <vscale x 4 x i1>) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave2.nxv8i32(<vscale x 8 x i32>) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64) #5

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umax.i64(i64, i64) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.stepvector.nxv2i64() #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 2 x i64> @llvm.masked.gather.nxv2i64.nxv2p0(<vscale x 2 x ptr>, <vscale x 2 x i1>, <vscale x 2 x i64>) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave4.nxv16i32(<vscale x 16 x i32>) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(read) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(write) }
attributes #5 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !2, !1}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !2, !1}
!6 = distinct !{!6, !1, !2}
!7 = distinct !{!7, !2, !1}
!8 = !{!9}
!9 = distinct !{!9, !10}
!10 = distinct !{!10, !"LVerDomain"}
!11 = !{!12}
!12 = distinct !{!12, !10}
!13 = distinct !{!13, !1, !2}
!14 = distinct !{!14, !1}
!15 = !{!16}
!16 = distinct !{!16, !17}
!17 = distinct !{!17, !"LVerDomain"}
!18 = !{!19}
!19 = distinct !{!19, !17}
!20 = distinct !{!20, !1, !2}
!21 = distinct !{!21, !1}
!22 = distinct !{!22, !1, !2}
!23 = distinct !{!23, !2, !1}
!24 = distinct !{!24, !1, !2}
!25 = distinct !{!25, !2, !1}
