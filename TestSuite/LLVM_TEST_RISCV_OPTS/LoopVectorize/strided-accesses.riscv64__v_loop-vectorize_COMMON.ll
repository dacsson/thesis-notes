; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/strided-accesses.ll
; Variant: riscv64_+v_loop-vectorize_COMMON
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt < %s -passes=loop-vectorize -mtriple=riscv64 -mattr=+v -S | FileCheck --check-prefixes=COMMON,CHECK,NOSTRIDED %s

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

; ModuleID = '/tmp/tmp0kz_6pck.ll'
source_filename = "/tmp/tmp0kz_6pck.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define void @single_constant_stride_int_scaled(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 4 x i64> [ %0, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %2 = zext i32 %1 to i64
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %2, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %3 = shl nuw nsw <vscale x 4 x i64> %vec.ind, splat (i64 3)
  %4 = getelementptr i32, ptr %p, <vscale x 4 x i64> %3
  %wide.masked.gather = call <vscale x 4 x i32> @llvm.vp.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %4, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %5 = add <vscale x 4 x i32> %wide.masked.gather, splat (i32 1)
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %5, <vscale x 4 x ptr> align 4 %4, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %avl.next = sub nuw i64 %avl, %2
  %vec.ind.next = add <vscale x 4 x i64> %vec.ind, %broadcast.splat
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @single_constant_stride_int_iv(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  %1 = mul nuw nsw <vscale x 4 x i64> %0, splat (i64 64)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 4 x i64> [ %1, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %2 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %3 = zext i32 %2 to i64
  %4 = shl nuw nsw i64 %3, 6
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %4, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %5 = getelementptr i32, ptr %p, <vscale x 4 x i64> %vec.ind
  %wide.masked.gather = call <vscale x 4 x i32> @llvm.vp.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %5, <vscale x 4 x i1> splat (i1 true), i32 %2)
  %6 = add <vscale x 4 x i32> %wide.masked.gather, splat (i32 1)
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %6, <vscale x 4 x ptr> align 4 %5, <vscale x 4 x i1> splat (i1 true), i32 %2)
  %avl.next = sub nuw i64 %avl, %3
  %vec.ind.next = add nuw nsw <vscale x 4 x i64> %vec.ind, %broadcast.splat
  %7 = icmp eq i64 %avl.next, 0
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !3

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @single_constant_stride_ptr_iv(ptr %p) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %pointer.phi = phi ptr [ %p, %vector.ph ], [ %ptr.ind, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  %1 = shl <vscale x 4 x i64> %0, splat (i64 3)
  %vector.gep = getelementptr i8, ptr %pointer.phi, <vscale x 4 x i64> %1
  %2 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %wide.masked.gather = call <vscale x 4 x i32> @llvm.vp.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %vector.gep, <vscale x 4 x i1> splat (i1 true), i32 %2)
  %3 = add <vscale x 4 x i32> %wide.masked.gather, splat (i32 1)
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %3, <vscale x 4 x ptr> align 4 %vector.gep, <vscale x 4 x i1> splat (i1 true), i32 %2)
  %4 = zext i32 %2 to i64
  %avl.next = sub nuw i64 %avl, %4
  %5 = shl i64 %4, 3
  %ptr.ind = getelementptr i8, ptr %pointer.phi, i64 %5
  %6 = icmp eq i64 %avl.next, 0
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !4

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @single_stride_int_scaled(ptr %p, i64 %stride) #0 {
entry:
  br label %vector.scevcheck

vector.scevcheck:                                 ; preds = %entry
  %ident.check = icmp ne i64 %stride, 1
  br i1 %ident.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.scevcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr i32, ptr %p, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = add <vscale x 4 x i32> %vp.op.load, splat (i32 1)
  call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> %2, ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %3 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !5

middle.block:                                     ; preds = %vector.body
  br label %exit

scalar.ph:                                        ; preds = %vector.scevcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %i = phi i64 [ 0, %scalar.ph ], [ %nexti, %loop ]
  %offset = mul nuw nsw i64 %i, %stride
  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0, align 4
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %q0, align 4
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !6

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @single_stride_int_iv(ptr %p, i64 %stride) #0 {
entry:
  br label %vector.scevcheck

vector.scevcheck:                                 ; preds = %entry
  %ident.check = icmp ne i64 %stride, 1
  br i1 %ident.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.scevcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr i32, ptr %p, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = add <vscale x 4 x i32> %vp.op.load, splat (i32 1)
  call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> %2, ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %3 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !7

middle.block:                                     ; preds = %vector.body
  br label %exit

scalar.ph:                                        ; preds = %vector.scevcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %i = phi i64 [ 0, %scalar.ph ], [ %nexti, %loop ]
  %offset = phi i64 [ 0, %scalar.ph ], [ %offset.next, %loop ]
  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0, align 4
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %q0, align 4
  %offset.next = add nuw nsw i64 %offset, %stride
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !8

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
  br label %vector.scevcheck

vector.scevcheck:                                 ; preds = %entry
  %ident.check = icmp ne i64 %stride, 1
  br i1 %ident.check, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %vector.scevcheck
  %0 = call i64 @llvm.vscale.i64()
  %1 = mul nuw i64 %0, 4
  %2 = mul i64 %1, 4
  %3 = sub i64 %p21, %p3
  %diff.check = icmp ult i64 %3, %2
  br i1 %diff.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %4 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %5 = getelementptr i32, ptr %p, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %5, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %6 = add <vscale x 4 x i32> %vp.op.load, splat (i32 1)
  %7 = getelementptr i32, ptr %p2, i64 %index
  call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> %6, ptr align 4 %7, <vscale x 4 x i1> splat (i1 true), i32 %4)
  %8 = zext i32 %4 to i64
  %current.iteration.next = add nuw i64 %8, %index
  %avl.next = sub nuw i64 %avl, %8
  %9 = icmp eq i64 %avl.next, 0
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !9

middle.block:                                     ; preds = %vector.body
  br label %exit

scalar.ph:                                        ; preds = %vector.memcheck, %vector.scevcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %i = phi i64 [ 0, %scalar.ph ], [ %nexti, %loop ]
  %offset = mul nuw nsw i64 %i, %stride
  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0, align 4
  %y0 = add i32 %x0, 1
  %q1 = getelementptr i32, ptr %p2, i64 %offset
  store i32 %y0, ptr %q1, align 4
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !10

exit:                                             ; preds = %middle.block, %loop
  ret void
}

define void @double_stride_int_iv(ptr %p, ptr %p2, i64 %stride) #0 {
entry:
  br label %vector.scevcheck

vector.scevcheck:                                 ; preds = %entry
  %ident.check = icmp ne i64 %stride, 1
  br i1 %ident.check, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.scevcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %0 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %1 = getelementptr i32, ptr %p, i64 %index
  %vp.op.load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %2 = add <vscale x 4 x i32> %vp.op.load, splat (i32 1)
  call void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32> %2, ptr align 4 %1, <vscale x 4 x i1> splat (i1 true), i32 %0)
  %3 = zext i32 %0 to i64
  %current.iteration.next = add nuw i64 %3, %index
  %avl.next = sub nuw i64 %avl, %3
  %4 = icmp eq i64 %avl.next, 0
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !11

middle.block:                                     ; preds = %vector.body
  br label %exit

scalar.ph:                                        ; preds = %vector.scevcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %i = phi i64 [ 0, %scalar.ph ], [ %nexti, %loop ]
  %offset = phi i64 [ 0, %scalar.ph ], [ %offset.next, %loop ]
  %q0 = getelementptr i32, ptr %p, i64 %offset
  %x0 = load i32, ptr %q0, align 4
  %y0 = add i32 %x0, 1
  %q1 = getelementptr i32, ptr %p, i64 %offset
  store i32 %y0, ptr %q1, align 4
  %offset.next = add nuw nsw i64 %offset, %stride
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !12

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
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call <vscale x 2 x i64> @llvm.stepvector.nxv2i64()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %current.iteration.next, %vector.body ]
  %vec.ind = phi <vscale x 2 x i64> [ %0, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 2, i1 true)
  %2 = zext i32 %1 to i64
  %broadcast.splatinsert = insertelement <vscale x 2 x i64> poison, i64 %2, i64 0
  %broadcast.splat = shufflevector <vscale x 2 x i64> %broadcast.splatinsert, <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
  %3 = getelementptr inbounds nuw i32, ptr %in, <vscale x 2 x i64> %vec.ind
  %wide.masked.gather = call <vscale x 2 x i64> @llvm.vp.gather.nxv2i64.nxv2p0(<vscale x 2 x ptr> align 8 %3, <vscale x 2 x i1> splat (i1 true), i32 %1)
  %4 = getelementptr inbounds nuw i64, ptr %out, i64 %index
  call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> %wide.masked.gather, ptr align 8 %4, <vscale x 2 x i1> splat (i1 true), i32 %1)
  %current.iteration.next = add nuw i64 %2, %index
  %avl.next = sub nuw i64 %avl, %2
  %vec.ind.next = add nuw nsw <vscale x 2 x i64> %vec.ind, %broadcast.splat
  %5 = icmp eq i64 %avl.next, 0
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !13

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

define void @interleaved_load_instead_of_strided(ptr %a) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %entry
  %0 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 4 x i64> [ %0, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %1 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %2 = zext i32 %1 to i64
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %2, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %3 = getelementptr [4 x i32], ptr %a, <vscale x 4 x i64> %vec.ind
  %4 = extractelement <vscale x 4 x ptr> %3, i64 0
  %interleave.evl = mul nuw nsw i32 %1, 4
  %wide.vp.load = call <vscale x 16 x i32> @llvm.vp.load.nxv16i32.p0(ptr align 4 %4, <vscale x 16 x i1> splat (i1 true), i32 %interleave.evl)
  %strided.vec = call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave4.nxv16i32(<vscale x 16 x i32> %wide.vp.load)
  %5 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 0
  %6 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 1
  %7 = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } %strided.vec, 3
  %8 = add <vscale x 4 x i32> %5, %6
  %9 = add <vscale x 4 x i32> %8, %7
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %9, <vscale x 4 x ptr> align 4 %3, <vscale x 4 x i1> splat (i1 true), i32 %1)
  %avl.next = sub nuw i64 %avl, %2
  %vec.ind.next = add nuw nsw <vscale x 4 x i64> %vec.ind, %broadcast.splat
  %10 = icmp eq i64 %avl.next, 0
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !14

middle.block:                                     ; preds = %vector.body
  br label %exit

exit:                                             ; preds = %middle.block
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 4 x i64> @llvm.stepvector.nxv4i64() #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 4 x i32> @llvm.vp.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr>, <vscale x 4 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32>, <vscale x 4 x ptr>, <vscale x 4 x i1>, i32) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr captures(none), <vscale x 4 x i1>, i32) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv4i32.p0(<vscale x 4 x i32>, ptr captures(none), <vscale x 4 x i1>, i32) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.stepvector.nxv2i64() #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 2 x i64> @llvm.vp.gather.nxv2i64.nxv2p0(<vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 16 x i32> @llvm.vp.load.nxv16i32.p0(ptr captures(none), <vscale x 16 x i1>, i32) #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave4.nxv16i32(<vscale x 16 x i32>) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(read) }
attributes #4 = { nocallback nofree nosync nounwind willreturn }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
!4 = distinct !{!4, !1, !2}
!5 = distinct !{!5, !1, !2}
!6 = distinct !{!6, !1}
!7 = distinct !{!7, !1, !2}
!8 = distinct !{!8, !1}
!9 = distinct !{!9, !1, !2}
!10 = distinct !{!10, !1}
!11 = distinct !{!11, !1, !2}
!12 = distinct !{!12, !1}
!13 = distinct !{!13, !1, !2}
!14 = distinct !{!14, !1, !2}
