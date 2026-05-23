; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/strided-accesses.ll
; Variant: riscv64_+v_loop-vectorize_COMMON_2
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-vectorize -mtriple=riscv64 -mattr=+v -lv-strided-pointer-ivs=true -laa-speculate-unit-stride=false -S
; Original: RUN: opt < %s -passes=loop-vectorize -mtriple=riscv64 -mattr=+v -lv-strided-pointer-ivs=true -laa-speculate-unit-stride=false -S | FileCheck --check-prefixes=COMMON,STRIDED-COMMON,CHECK,STRIDED %s

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

; ModuleID = '/tmp/tmpmjd286xc.ll'
source_filename = "/tmp/tmpmjd286xc.ll"
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
  br label %vector.scevcheck

vector.scevcheck:                                 ; preds = %entry
  %0 = shl i64 %stride, 2
  %1 = mul i64 %stride, -4
  %2 = icmp slt i64 %0, 0
  %3 = select i1 %2, i64 %1, i64 %0
  %mul = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %3, i64 1023)
  %mul.result = extractvalue { i64, i1 } %mul, 0
  %mul.overflow = extractvalue { i64, i1 } %mul, 1
  %4 = sub i64 0, %mul.result
  %5 = getelementptr i8, ptr %p2, i64 %mul.result
  %6 = getelementptr i8, ptr %p2, i64 %4
  %7 = icmp ult ptr %5, %p2
  %8 = icmp ugt ptr %6, %p2
  %9 = select i1 %2, i1 %8, i1 %7
  %10 = or i1 %9, %mul.overflow
  %11 = icmp slt i64 %0, 0
  %12 = select i1 %11, i64 %1, i64 %0
  %mul1 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %12, i64 1023)
  %mul.result2 = extractvalue { i64, i1 } %mul1, 0
  %mul.overflow3 = extractvalue { i64, i1 } %mul1, 1
  %13 = sub i64 0, %mul.result2
  %14 = getelementptr i8, ptr %p, i64 %mul.result2
  %15 = getelementptr i8, ptr %p, i64 %13
  %16 = icmp ult ptr %14, %p
  %17 = icmp ugt ptr %15, %p
  %18 = select i1 %11, i1 %17, i1 %16
  %19 = or i1 %18, %mul.overflow3
  %20 = or i1 %10, %19
  br i1 %20, label %scalar.ph, label %vector.memcheck

vector.memcheck:                                  ; preds = %vector.scevcheck
  %21 = mul i64 %stride, 4092
  %scevgep = getelementptr i8, ptr %p2, i64 %21
  %22 = icmp ult ptr %p2, %scevgep
  %umin = select i1 %22, ptr %p2, ptr %scevgep
  %23 = icmp ugt ptr %p2, %scevgep
  %umax = select i1 %23, ptr %p2, ptr %scevgep
  %scevgep4 = getelementptr i8, ptr %umax, i64 4
  %scevgep5 = getelementptr i8, ptr %p, i64 %21
  %24 = icmp ult ptr %p, %scevgep5
  %umin6 = select i1 %24, ptr %p, ptr %scevgep5
  %25 = icmp ugt ptr %p, %scevgep5
  %umax7 = select i1 %25, ptr %p, ptr %scevgep5
  %scevgep8 = getelementptr i8, ptr %umax7, i64 4
  %bound0 = icmp ult ptr %umin, %scevgep8
  %bound1 = icmp ult ptr %umin6, %scevgep4
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %stride, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %26 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %vec.ind = phi <vscale x 4 x i64> [ %26, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %27 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %28 = zext i32 %27 to i64
  %broadcast.splatinsert9 = insertelement <vscale x 4 x i64> poison, i64 %28, i64 0
  %broadcast.splat10 = shufflevector <vscale x 4 x i64> %broadcast.splatinsert9, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %29 = mul nuw nsw <vscale x 4 x i64> %vec.ind, %broadcast.splat
  %30 = getelementptr i32, ptr %p, <vscale x 4 x i64> %29
  %wide.masked.gather = call <vscale x 4 x i32> @llvm.vp.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %30, <vscale x 4 x i1> splat (i1 true), i32 %27), !alias.scope !5
  %31 = add <vscale x 4 x i32> %wide.masked.gather, splat (i32 1)
  %32 = getelementptr i32, ptr %p2, <vscale x 4 x i64> %29
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %31, <vscale x 4 x ptr> align 4 %32, <vscale x 4 x i1> splat (i1 true), i32 %27), !alias.scope !8, !noalias !5
  %avl.next = sub nuw i64 %avl, %28
  %vec.ind.next = add <vscale x 4 x i64> %vec.ind, %broadcast.splat10
  %33 = icmp eq i64 %avl.next, 0
  br i1 %33, label %middle.block, label %vector.body, !llvm.loop !10

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
  br i1 %done, label %exit, label %loop, !llvm.loop !11

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
  br label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %0 = mul i64 %stride, 1023
  %scevgep = getelementptr i8, ptr %p2, i64 %0
  %1 = icmp ult ptr %p2, %scevgep
  %umin = select i1 %1, ptr %p2, ptr %scevgep
  %2 = icmp ugt ptr %p2, %scevgep
  %umax = select i1 %2, ptr %p2, ptr %scevgep
  %scevgep1 = getelementptr i8, ptr %umax, i64 4
  %scevgep2 = getelementptr i8, ptr %p, i64 %0
  %3 = icmp ult ptr %p, %scevgep2
  %umin3 = select i1 %3, ptr %p, ptr %scevgep2
  %4 = icmp ugt ptr %p, %scevgep2
  %umax4 = select i1 %4, ptr %p, ptr %scevgep2
  %scevgep5 = getelementptr i8, ptr %umax4, i64 4
  %bound0 = icmp ult ptr %umin, %scevgep5
  %bound1 = icmp ult ptr %umin3, %scevgep1
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %pointer.phi = phi ptr [ %p, %vector.ph ], [ %ptr.ind, %vector.body ]
  %pointer.phi6 = phi ptr [ %p2, %vector.ph ], [ %ptr.ind8, %vector.body ]
  %avl = phi i64 [ 1024, %vector.ph ], [ %avl.next, %vector.body ]
  %5 = call <vscale x 4 x i64> @llvm.stepvector.nxv4i64()
  %broadcast.splatinsert = insertelement <vscale x 4 x i64> poison, i64 %stride, i64 0
  %broadcast.splat = shufflevector <vscale x 4 x i64> %broadcast.splatinsert, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %6 = mul <vscale x 4 x i64> %5, %broadcast.splat
  %vector.gep = getelementptr i8, ptr %pointer.phi6, <vscale x 4 x i64> %6
  %vector.gep7 = getelementptr i8, ptr %pointer.phi, <vscale x 4 x i64> %6
  %7 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 4, i1 true)
  %wide.masked.gather = call <vscale x 4 x i32> @llvm.vp.gather.nxv4i32.nxv4p0(<vscale x 4 x ptr> align 4 %vector.gep7, <vscale x 4 x i1> splat (i1 true), i32 %7), !alias.scope !12
  %8 = add <vscale x 4 x i32> %wide.masked.gather, splat (i32 1)
  call void @llvm.vp.scatter.nxv4i32.nxv4p0(<vscale x 4 x i32> %8, <vscale x 4 x ptr> align 4 %vector.gep, <vscale x 4 x i1> splat (i1 true), i32 %7), !alias.scope !15, !noalias !12
  %9 = zext i32 %7 to i64
  %avl.next = sub nuw i64 %avl, %9
  %10 = mul i64 %stride, %9
  %ptr.ind = getelementptr i8, ptr %pointer.phi, i64 %10
  %ptr.ind8 = getelementptr i8, ptr %pointer.phi6, i64 %10
  %11 = icmp eq i64 %avl.next, 0
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !17

middle.block:                                     ; preds = %vector.body
  br label %exit

scalar.ph:                                        ; preds = %vector.memcheck
  br label %loop

loop:                                             ; preds = %scalar.ph, %loop
  %i = phi i64 [ 0, %scalar.ph ], [ %nexti, %loop ]
  %ptr = phi ptr [ %p, %scalar.ph ], [ %ptr.next, %loop ]
  %ptr2 = phi ptr [ %p2, %scalar.ph ], [ %ptr2.next, %loop ]
  %x0 = load i32, ptr %ptr, align 4
  %y0 = add i32 %x0, 1
  store i32 %y0, ptr %ptr2, align 4
  %ptr.next = getelementptr inbounds i8, ptr %ptr, i64 %stride
  %ptr2.next = getelementptr inbounds i8, ptr %ptr2, i64 %stride
  %nexti = add i64 %i, 1
  %done = icmp eq i64 %nexti, 1024
  br i1 %done, label %exit, label %loop, !llvm.loop !18

exit:                                             ; preds = %middle.block, %loop
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
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !19

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
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !20

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

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <vscale x 2 x i64> @llvm.stepvector.nxv2i64() #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <vscale x 2 x i64> @llvm.vp.gather.nxv2i64.nxv2p0(<vscale x 2 x ptr>, <vscale x 2 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64>, ptr captures(none), <vscale x 2 x i1>, i32) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 16 x i32> @llvm.vp.load.nxv16i32.p0(ptr captures(none), <vscale x 16 x i1>, i32) #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @llvm.vector.deinterleave4.nxv16i32(<vscale x 16 x i32>) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(read) }
attributes #4 = { nocallback nofree nosync nounwind willreturn }
attributes #5 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #7 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.isvectorized", i32 1}
!2 = !{!"llvm.loop.unroll.runtime.disable"}
!3 = distinct !{!3, !1, !2}
!4 = distinct !{!4, !1, !2}
!5 = !{!6}
!6 = distinct !{!6, !7}
!7 = distinct !{!7, !"LVerDomain"}
!8 = !{!9}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !1, !2}
!11 = distinct !{!11, !1}
!12 = !{!13}
!13 = distinct !{!13, !14}
!14 = distinct !{!14, !"LVerDomain"}
!15 = !{!16}
!16 = distinct !{!16, !14}
!17 = distinct !{!17, !1, !2}
!18 = distinct !{!18, !1}
!19 = distinct !{!19, !1, !2}
!20 = distinct !{!20, !1, !2}
