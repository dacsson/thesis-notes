; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/strided-accesses.ll
; Variant: riscv64_+v_loop-vectorize_COMMON_1
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple=riscv64 -mattr=+v -force-vector-interleave=2 -S
; Original: RUN: opt < %s -passes=loop-vectorize -mtriple=riscv64 -mattr=+v -force-vector-interleave=2 -S | FileCheck --check-prefixes=COMMON,CHECK-UF2,NOSTRIDED-UF2 %s

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

; ModuleID = '/tmp/tmp2y9_0v0x.ll'
source_filename = "/tmp/tmp2y9_0v0x.ll"
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
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 3
  %min.iters.check = icmp ult i64 1024, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.scevcheck

vector.scevcheck:                                 ; preds = %entry
  %ident.check = icmp ne i64 %stride, 1
  br i1 %ident.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.scevcheck
  %2 = shl nuw i64 %0, 2
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 1024, %3
  %n.vec = sub i64 1024, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %4 = getelementptr i32, ptr %p, i64 %index
  %5 = getelementptr i32, ptr %4, i64 %2
  %wide.load = load <vscale x 4 x i32>, ptr %4, align 4
  %wide.load1 = load <vscale x 4 x i32>, ptr %5, align 4
  %6 = add <vscale x 4 x i32> %wide.load, splat (i32 1)
  %7 = add <vscale x 4 x i32> %wide.load1, splat (i32 1)
  store <vscale x 4 x i32> %6, ptr %4, align 4
  store <vscale x 4 x i32> %7, ptr %5, align 4
  %index.next = add nuw i64 %index, %3
  %8 = icmp eq i64 %index.next, %n.vec
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !8

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.scevcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.scevcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %i = phi i64 [ %bc.resume.val, %scalar.ph ], [ %nexti, %loop ]
  %offset = mul nuw nsw i64 %i, %stride
  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0, align 4
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %q0, align 4
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !9

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @single_stride_int_iv(ptr %p, i64 %stride) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 3
  %min.iters.check = icmp ult i64 1024, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.scevcheck

vector.scevcheck:                                 ; preds = %entry
  %ident.check = icmp ne i64 %stride, 1
  br i1 %ident.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.scevcheck
  %2 = shl nuw i64 %0, 2
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 1024, %3
  %n.vec = sub i64 1024, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %4 = getelementptr i32, ptr %p, i64 %index
  %5 = getelementptr i32, ptr %4, i64 %2
  %wide.load = load <vscale x 4 x i32>, ptr %4, align 4
  %wide.load1 = load <vscale x 4 x i32>, ptr %5, align 4
  %6 = add <vscale x 4 x i32> %wide.load, splat (i32 1)
  %7 = add <vscale x 4 x i32> %wide.load1, splat (i32 1)
  store <vscale x 4 x i32> %6, ptr %4, align 4
  store <vscale x 4 x i32> %7, ptr %5, align 4
  %index.next = add nuw i64 %index, %3
  %8 = icmp eq i64 %index.next, %n.vec
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !10

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.scevcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.scevcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %i = phi i64 [ %bc.resume.val, %scalar.ph ], [ %nexti, %loop ]
  %offset = phi i64 [ %bc.resume.val, %scalar.ph ], [ %offset.next, %loop ]
  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0, align 4
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %q0, align 4
  %offset.next = add nuw nsw i64 %offset, %stride
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !11

exit:                                             ; preds = %middle.block, %loop
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
  %p3 = ptrtoaddr ptr %p to i64
  %p21 = ptrtoaddr ptr %p2 to i64
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 3
  %umax = call i64 @llvm.umax.i64(i64 %1, i64 12)
  %min.iters.check = icmp ult i64 1024, %umax
  br i1 %min.iters.check, label %scalar.ph, label %vector.scevcheck

vector.scevcheck:                                 ; preds = %entry
  %ident.check = icmp ne i64 %stride, 1
  br i1 %ident.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %vector.scevcheck
  %2 = call i64 @llvm.vscale.i64()
  %3 = mul nuw i64 %2, 4
  %4 = mul i64 %3, 8
  %5 = sub i64 %p21, %p3
  %diff.check = icmp ult i64 %5, %4
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %6 = call i64 @llvm.vscale.i64()
  %7 = shl nuw i64 %6, 2
  %8 = shl nuw i64 %7, 1
  %n.mod.vf = urem i64 1024, %8
  %n.vec = sub i64 1024, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %9 = getelementptr i32, ptr %p, i64 %index
  %10 = getelementptr i32, ptr %9, i64 %7
  %wide.load = load <vscale x 4 x i32>, ptr %9, align 4
  %wide.load4 = load <vscale x 4 x i32>, ptr %10, align 4
  %11 = add <vscale x 4 x i32> %wide.load, splat (i32 1)
  %12 = add <vscale x 4 x i32> %wide.load4, splat (i32 1)
  %13 = getelementptr i32, ptr %p2, i64 %index
  %14 = getelementptr i32, ptr %13, i64 %7
  store <vscale x 4 x i32> %11, ptr %13, align 4
  store <vscale x 4 x i32> %12, ptr %14, align 4
  %index.next = add nuw i64 %index, %8
  %15 = icmp eq i64 %index.next, %n.vec
  br i1 %15, label %middle.block, label %vector.body, !llvm.loop !12

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
  br i1 %done, label %exit, label %loop, !llvm.loop !13

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @double_stride_int_iv(ptr %p, ptr %p2, i64 %stride) #0 {
entry:
  %0 = call i64 @llvm.vscale.i64()
  %1 = shl nuw i64 %0, 3
  %min.iters.check = icmp ult i64 1024, %1
  br i1 %min.iters.check, label %scalar.ph, label %vector.scevcheck

vector.scevcheck:                                 ; preds = %entry
  %ident.check = icmp ne i64 %stride, 1
  br i1 %ident.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.scevcheck
  %2 = shl nuw i64 %0, 2
  %3 = shl nuw i64 %2, 1
  %n.mod.vf = urem i64 1024, %3
  %n.vec = sub i64 1024, %n.mod.vf
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %4 = getelementptr i32, ptr %p, i64 %index
  %5 = getelementptr i32, ptr %4, i64 %2
  %wide.load = load <vscale x 4 x i32>, ptr %4, align 4
  %wide.load1 = load <vscale x 4 x i32>, ptr %5, align 4
  %6 = add <vscale x 4 x i32> %wide.load, splat (i32 1)
  %7 = add <vscale x 4 x i32> %wide.load1, splat (i32 1)
  store <vscale x 4 x i32> %6, ptr %4, align 4
  store <vscale x 4 x i32> %7, ptr %5, align 4
  %index.next = add nuw i64 %index, %3
  %8 = icmp eq i64 %index.next, %n.vec
  br i1 %8, label %middle.block, label %vector.body, !llvm.loop !14

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 1024, %n.vec
  br i1 %cmp.n, label %exit, label %scalar.ph

scalar.ph:                                        ; preds = %vector.scevcheck, %entry, %middle.block
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %entry ], [ 0, %vector.scevcheck ]
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %i = phi i64 [ %bc.resume.val, %scalar.ph ], [ %nexti, %loop ]
  %offset = phi i64 [ %bc.resume.val, %scalar.ph ], [ %offset.next, %loop ]
  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0, align 4
  %y0 = add i32 %x0, 1
  %q1 = getelementptr i32, ptr %p, i64 %offset
  store i32 %y0, ptr %q1, align 4
  %offset.next = add nuw nsw i64 %offset, %stride
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !15

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @double_stride_ptr_iv(ptr %p, ptr %p2, i64 %stride) #0 {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %i = phi i64 [ 0, %entry ], [ %nexti, %loop ]
  %ptr = phi ptr [ %p, %entry ], [ %ptr.next, %loop ]
  %ptr2 = phi ptr [ %p2, %entry ], [ %ptr2.next, %loop ]
  %x0 = load i32, ptr %ptr, align 4
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %ptr2, align 4
  %ptr.next = getelementptr inbounds i8, ptr %ptr, i64 %stride
  %ptr2.next = getelementptr inbounds i8, ptr %ptr2, i64 %stride
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop

exit:                                             ; preds = %loop
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
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !16

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
  br i1 %done, label %exit, label %loop, !llvm.loop !17

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
  br i1 %19, label %middle.block, label %vector.body, !llvm.loop !18

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
  br i1 %done, label %exit, label %loop, !llvm.loop !19

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
!8 = distinct !{!8, !1, !2}
!9 = distinct !{!9, !1}
!10 = distinct !{!10, !1, !2}
!11 = distinct !{!11, !1}
!12 = distinct !{!12, !1, !2}
!13 = distinct !{!13, !1}
!14 = distinct !{!14, !1, !2}
!15 = distinct !{!15, !1}
!16 = distinct !{!16, !1, !2}
!17 = distinct !{!17, !2, !1}
!18 = distinct !{!18, !1, !2}
!19 = distinct !{!19, !2, !1}
