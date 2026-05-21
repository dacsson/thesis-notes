; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopIdiom/RISCV/byte-compare-index.ll
; Variant: riscv64-unknown-linux-gnu_+v_loop(loop-idiom-vectorize),simplifycfg_LOOP-DEL
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes='loop(loop-idiom-vectorize),simplifycfg' -mtriple=riscv64-unknown-linux-gnu -loop-idiom-vectorize-style=predicated -mattr=+v -S
; Original: RUN: opt -passes='loop(loop-idiom-vectorize),simplifycfg' -mtriple=riscv64-unknown-linux-gnu -loop-idiom-vectorize-style=predicated -mattr=+v -S < %s | FileCheck %s --check-prefix=LOOP-DEL

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i32 @compare_bytes_simple(ptr %a, ptr %b, i32 %len, i32 %n) {
entry:
  br label %while.cond

while.cond:
  %len.addr = phi i32 [ %len, %entry ], [ %inc, %while.body ]
  %inc = add i32 %len.addr, 1
  %cmp.not = icmp eq i32 %inc, %n
  br i1 %cmp.not, label %while.end, label %while.body

while.body:
  %idxprom = zext i32 %inc to i64
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %idxprom
  %0 = load i8, ptr %arrayidx
  %arrayidx2 = getelementptr inbounds i8, ptr %b, i64 %idxprom
  %1 = load i8, ptr %arrayidx2
  %cmp.not2 = icmp eq i8 %0, %1
  br i1 %cmp.not2, label %while.cond, label %while.end

while.end:
  %inc.lcssa = phi i32 [ %inc, %while.body ], [ %inc, %while.cond ]
  ret i32 %inc.lcssa
}

define i32 @compare_bytes_signed_wrap(ptr %a, ptr %b, i32 %len, i32 %n) {
; NO-TRANSFORM-LABEL: define i32 @compare_bytes_signed_wrap(
; NO-TRANSFORM-SAME: ptr [[A:%.*]], ptr [[B:%.*]], i32 [[LEN:%.*]], i32 [[N:%.*]]) {
; NO-TRANSFORM-NEXT:  entry:
; NO-TRANSFORM-NEXT:    br label [[WHILE_COND:%.*]]
; NO-TRANSFORM:       while.cond:
; NO-TRANSFORM-NEXT:    [[LEN_ADDR:%.*]] = phi i32 [ [[LEN]], [[ENTRY:%.*]] ], [ [[INC:%.*]], [[WHILE_BODY:%.*]] ]
; NO-TRANSFORM-NEXT:    [[INC]] = add nsw i32 [[LEN_ADDR]], 1
; NO-TRANSFORM-NEXT:    [[CMP_NOT:%.*]] = icmp eq i32 [[INC]], [[N]]
; NO-TRANSFORM-NEXT:    br i1 [[CMP_NOT]], label [[WHILE_END:%.*]], label [[WHILE_BODY]]
; NO-TRANSFORM:       while.body:
; NO-TRANSFORM-NEXT:    [[IDXPROM:%.*]] = zext i32 [[INC]] to i64
; NO-TRANSFORM-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i8, ptr [[A]], i64 [[IDXPROM]]
; NO-TRANSFORM-NEXT:    [[TMP0:%.*]] = load i8, ptr [[ARRAYIDX]], align 1
; NO-TRANSFORM-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i8, ptr [[B]], i64 [[IDXPROM]]
; NO-TRANSFORM-NEXT:    [[TMP1:%.*]] = load i8, ptr [[ARRAYIDX2]], align 1
; NO-TRANSFORM-NEXT:    [[CMP_NOT2:%.*]] = icmp eq i8 [[TMP0]], [[TMP1]]
; NO-TRANSFORM-NEXT:    br i1 [[CMP_NOT2]], label [[WHILE_COND]], label [[WHILE_END]]
; NO-TRANSFORM:       while.end:
; NO-TRANSFORM-NEXT:    [[INC_LCSSA:%.*]] = phi i32 [ [[INC]], [[WHILE_BODY]] ], [ [[INC]], [[WHILE_COND]] ]
; NO-TRANSFORM-NEXT:    ret i32 [[INC_LCSSA]]
entry:
  br label %while.cond

while.cond:
  %len.addr = phi i32 [ %len, %entry ], [ %inc, %while.body ]
  %inc = add nsw i32 %len.addr, 1
  %cmp.not = icmp eq i32 %inc, %n
  br i1 %cmp.not, label %while.end, label %while.body

while.body:
  %idxprom = zext i32 %inc to i64
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %idxprom
  %0 = load i8, ptr %arrayidx
  %arrayidx2 = getelementptr inbounds i8, ptr %b, i64 %idxprom
  %1 = load i8, ptr %arrayidx2
  %cmp.not2 = icmp eq i8 %0, %1
  br i1 %cmp.not2, label %while.cond, label %while.end

while.end:
  %inc.lcssa = phi i32 [ %inc, %while.body ], [ %inc, %while.cond ]
  ret i32 %inc.lcssa
}


define i32 @compare_bytes_simple_end_ne_found(ptr %a, ptr %b, ptr %c, ptr %d, i32 %len, i32 %n) {
; NO-TRANSFORM-LABEL: define i32 @compare_bytes_simple_end_ne_found(
; NO-TRANSFORM-SAME: ptr [[A:%.*]], ptr [[B:%.*]], ptr [[C:%.*]], ptr [[D:%.*]], i32 [[LEN:%.*]], i32 [[N:%.*]]) {
; NO-TRANSFORM-NEXT:  entry:
; NO-TRANSFORM-NEXT:    br label [[WHILE_COND:%.*]]
; NO-TRANSFORM:       while.cond:
; NO-TRANSFORM-NEXT:    [[LEN_ADDR:%.*]] = phi i32 [ [[LEN]], [[ENTRY:%.*]] ], [ [[INC:%.*]], [[WHILE_BODY:%.*]] ]
; NO-TRANSFORM-NEXT:    [[INC]] = add i32 [[LEN_ADDR]], 1
; NO-TRANSFORM-NEXT:    [[CMP_NOT:%.*]] = icmp eq i32 [[INC]], [[N]]
; NO-TRANSFORM-NEXT:    br i1 [[CMP_NOT]], label [[WHILE_END:%.*]], label [[WHILE_BODY]]
; NO-TRANSFORM:       while.body:
; NO-TRANSFORM-NEXT:    [[IDXPROM:%.*]] = zext i32 [[INC]] to i64
; NO-TRANSFORM-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i8, ptr [[A]], i64 [[IDXPROM]]
; NO-TRANSFORM-NEXT:    [[TMP0:%.*]] = load i8, ptr [[ARRAYIDX]], align 1
; NO-TRANSFORM-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i8, ptr [[B]], i64 [[IDXPROM]]
; NO-TRANSFORM-NEXT:    [[TMP1:%.*]] = load i8, ptr [[ARRAYIDX2]], align 1
; NO-TRANSFORM-NEXT:    [[CMP_NOT2:%.*]] = icmp eq i8 [[TMP0]], [[TMP1]]
; NO-TRANSFORM-NEXT:    br i1 [[CMP_NOT2]], label [[WHILE_COND]], label [[WHILE_FOUND:%.*]]
; NO-TRANSFORM:       while.found:
; NO-TRANSFORM-NEXT:    [[MISMATCH_INDEX1:%.*]] = phi i32 [ [[INC]], [[WHILE_BODY]] ]
; NO-TRANSFORM-NEXT:    [[FOUND_PTR:%.*]] = phi ptr [ [[C]], [[WHILE_BODY]] ]
; NO-TRANSFORM-NEXT:    br label [[END:%.*]]
; NO-TRANSFORM:       while.end:
; NO-TRANSFORM-NEXT:    [[MISMATCH_INDEX2:%.*]] = phi i32 [ [[N]], [[WHILE_COND]] ]
; NO-TRANSFORM-NEXT:    [[END_PTR:%.*]] = phi ptr [ [[D]], [[WHILE_COND]] ]
; NO-TRANSFORM-NEXT:    br label [[END]]
; NO-TRANSFORM:       end:
; NO-TRANSFORM-NEXT:    [[MISMATCH_INDEX:%.*]] = phi i32 [ [[MISMATCH_INDEX1]], [[WHILE_FOUND]] ], [ [[MISMATCH_INDEX2]], [[WHILE_END]] ]
; NO-TRANSFORM-NEXT:    [[STORE_PTR:%.*]] = phi ptr [ [[END_PTR]], [[WHILE_END]] ], [ [[FOUND_PTR]], [[WHILE_FOUND]] ]
; NO-TRANSFORM-NEXT:    store i32 [[MISMATCH_INDEX]], ptr [[STORE_PTR]], align 4
; NO-TRANSFORM-NEXT:    ret i32 [[MISMATCH_INDEX]]
entry:
  br label %while.cond

while.cond:
  %len.addr = phi i32 [ %len, %entry ], [ %inc, %while.body ]
  %inc = add i32 %len.addr, 1
  %cmp.not = icmp eq i32 %inc, %n
  br i1 %cmp.not, label %while.end, label %while.body

while.body:
  %idxprom = zext i32 %inc to i64
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %idxprom
  %0 = load i8, ptr %arrayidx
  %arrayidx2 = getelementptr inbounds i8, ptr %b, i64 %idxprom
  %1 = load i8, ptr %arrayidx2
  %cmp.not2 = icmp eq i8 %0, %1
  br i1 %cmp.not2, label %while.cond, label %while.found

while.found:
  %mismatch_index1 = phi i32 [ %inc, %while.body ]
  %found_ptr = phi ptr [ %c, %while.body ]
  br label %end

while.end:
  %mismatch_index2 = phi i32 [ %n, %while.cond ]
  %end_ptr = phi ptr [ %d, %while.cond ]
  br label %end

end:
  %mismatch_index = phi i32 [ %mismatch_index1, %while.found ], [ %mismatch_index2, %while.end ]
  %store_ptr = phi ptr [ %end_ptr, %while.end ], [ %found_ptr, %while.found ]
  store i32 %mismatch_index, ptr %store_ptr
  ret i32 %mismatch_index
}



define i32 @compare_bytes_extra_cmp(ptr %a, ptr %b, i32 %len, i32 %n, i32 %x) {
; NO-TRANSFORM-LABEL: define i32 @compare_bytes_extra_cmp(
; NO-TRANSFORM-SAME: ptr [[A:%.*]], ptr [[B:%.*]], i32 [[LEN:%.*]], i32 [[N:%.*]], i32 [[X:%.*]]) {
; NO-TRANSFORM-NEXT:  entry:
; NO-TRANSFORM-NEXT:    [[CMP_X:%.*]] = icmp ult i32 [[N]], [[X]]
; NO-TRANSFORM-NEXT:    br i1 [[CMP_X]], label [[PH:%.*]], label [[WHILE_END:%.*]]
; NO-TRANSFORM:       ph:
; NO-TRANSFORM-NEXT:    br label [[WHILE_COND:%.*]]
; NO-TRANSFORM:       while.cond:
; NO-TRANSFORM-NEXT:    [[LEN_ADDR:%.*]] = phi i32 [ [[LEN]], [[PH]] ], [ [[INC:%.*]], [[WHILE_BODY:%.*]] ]
; NO-TRANSFORM-NEXT:    [[INC]] = add i32 [[LEN_ADDR]], 1
; NO-TRANSFORM-NEXT:    [[CMP_NOT:%.*]] = icmp eq i32 [[INC]], [[N]]
; NO-TRANSFORM-NEXT:    br i1 [[CMP_NOT]], label [[WHILE_END]], label [[WHILE_BODY]]
; NO-TRANSFORM:       while.body:
; NO-TRANSFORM-NEXT:    [[IDXPROM:%.*]] = zext i32 [[INC]] to i64
; NO-TRANSFORM-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i8, ptr [[A]], i64 [[IDXPROM]]
; NO-TRANSFORM-NEXT:    [[TMP0:%.*]] = load i8, ptr [[ARRAYIDX]], align 1
; NO-TRANSFORM-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i8, ptr [[B]], i64 [[IDXPROM]]
; NO-TRANSFORM-NEXT:    [[TMP1:%.*]] = load i8, ptr [[ARRAYIDX2]], align 1
; NO-TRANSFORM-NEXT:    [[CMP_NOT2:%.*]] = icmp eq i8 [[TMP0]], [[TMP1]]
; NO-TRANSFORM-NEXT:    br i1 [[CMP_NOT2]], label [[WHILE_COND]], label [[WHILE_END]]
; NO-TRANSFORM:       while.end:
; NO-TRANSFORM-NEXT:    [[INC_LCSSA:%.*]] = phi i32 [ [[INC]], [[WHILE_BODY]] ], [ [[INC]], [[WHILE_COND]] ], [ [[X]], [[ENTRY:%.*]] ]
; NO-TRANSFORM-NEXT:    ret i32 [[INC_LCSSA]]
entry:
  %cmp.x = icmp ult i32 %n, %x
  br i1 %cmp.x, label %ph, label %while.end

ph:
  br label %while.cond

while.cond:
  %len.addr = phi i32 [ %len, %ph ], [ %inc, %while.body ]
  %inc = add i32 %len.addr, 1
  %cmp.not = icmp eq i32 %inc, %n
  br i1 %cmp.not, label %while.end, label %while.body

while.body:
  %idxprom = zext i32 %inc to i64
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %idxprom
  %0 = load i8, ptr %arrayidx
  %arrayidx2 = getelementptr inbounds i8, ptr %b, i64 %idxprom
  %1 = load i8, ptr %arrayidx2
  %cmp.not2 = icmp eq i8 %0, %1
  br i1 %cmp.not2, label %while.cond, label %while.end

while.end:
  %inc.lcssa = phi i32 [ %inc, %while.body ], [ %inc, %while.cond ], [ %x, %entry ]
  ret i32 %inc.lcssa
}

define void @compare_bytes_cleanup_block(ptr %src1, ptr %src2) {
; NO-TRANSFORM-LABEL: define void @compare_bytes_cleanup_block(
; NO-TRANSFORM-SAME: ptr [[SRC1:%.*]], ptr [[SRC2:%.*]]) {
; NO-TRANSFORM-NEXT:  entry:
; NO-TRANSFORM-NEXT:    br label [[WHILE_COND:%.*]]
; NO-TRANSFORM:       while.cond:
; NO-TRANSFORM-NEXT:    [[LEN:%.*]] = phi i32 [ [[INC:%.*]], [[WHILE_BODY:%.*]] ], [ 0, [[ENTRY:%.*]] ]
; NO-TRANSFORM-NEXT:    [[INC]] = add i32 [[LEN]], 1
; NO-TRANSFORM-NEXT:    [[CMP_NOT:%.*]] = icmp eq i32 [[INC]], 0
; NO-TRANSFORM-NEXT:    br i1 [[CMP_NOT]], label [[CLEANUP_THREAD:%.*]], label [[WHILE_BODY]]
; NO-TRANSFORM:       while.body:
; NO-TRANSFORM-NEXT:    [[IDXPROM:%.*]] = zext i32 [[INC]] to i64
; NO-TRANSFORM-NEXT:    [[ARRAYIDX:%.*]] = getelementptr i8, ptr [[SRC1]], i64 [[IDXPROM]]
; NO-TRANSFORM-NEXT:    [[TMP0:%.*]] = load i8, ptr [[ARRAYIDX]], align 1
; NO-TRANSFORM-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr i8, ptr [[SRC2]], i64 [[IDXPROM]]
; NO-TRANSFORM-NEXT:    [[TMP1:%.*]] = load i8, ptr [[ARRAYIDX2]], align 1
; NO-TRANSFORM-NEXT:    [[CMP_NOT2:%.*]] = icmp eq i8 [[TMP0]], [[TMP1]]
; NO-TRANSFORM-NEXT:    br i1 [[CMP_NOT2]], label [[WHILE_COND]], label [[IF_END:%.*]]
; NO-TRANSFORM:       cleanup.thread:
; NO-TRANSFORM-NEXT:    ret void
; NO-TRANSFORM:       if.end:
; NO-TRANSFORM-NEXT:    [[RES:%.*]] = phi i32 [ [[INC]], [[WHILE_BODY]] ]
; NO-TRANSFORM-NEXT:    ret void
entry:
  br label %while.cond

while.cond:
  %len = phi i32 [ %inc, %while.body ], [ 0, %entry ]
  %inc = add i32 %len, 1
  %cmp.not = icmp eq i32 %inc, 0
  br i1 %cmp.not, label %cleanup.thread, label %while.body

while.body:
  %idxprom = zext i32 %inc to i64
  %arrayidx = getelementptr i8, ptr %src1, i64 %idxprom
  %0 = load i8, ptr %arrayidx, align 1
  %arrayidx2 = getelementptr i8, ptr %src2, i64 %idxprom
  %1 = load i8, ptr %arrayidx2, align 1
  %cmp.not2 = icmp eq i8 %0, %1
  br i1 %cmp.not2, label %while.cond, label %if.end

cleanup.thread:
  ret void

if.end:
  %res = phi i32 [ %inc, %while.body ]
  ret void
}

; NEGATIVE TESTS

; Similar to @compare_bytes_simple, except in the while.end block we have an extra PHI
; with unique values for each incoming block from the loop.
define i32 @compare_bytes_simple2(ptr %a, ptr %b, ptr %c, ptr %d, i32 %len, i32 %n) {
entry:
  br label %while.cond

while.cond:
  %len.addr = phi i32 [ %len, %entry ], [ %inc, %while.body ]
  %inc = add i32 %len.addr, 1
  %cmp.not = icmp eq i32 %inc, %n
  br i1 %cmp.not, label %while.end, label %while.body

while.body:
  %idxprom = zext i32 %inc to i64
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %idxprom
  %0 = load i8, ptr %arrayidx
  %arrayidx2 = getelementptr inbounds i8, ptr %b, i64 %idxprom
  %1 = load i8, ptr %arrayidx2
  %cmp.not2 = icmp eq i8 %0, %1
  br i1 %cmp.not2, label %while.cond, label %while.end

while.end:
  %inc.lcssa = phi i32 [ %inc, %while.body ], [ %inc, %while.cond ]
  %final_ptr = phi ptr [ %c, %while.body ], [ %d, %while.cond ]
  store i32 %inc.lcssa, ptr %final_ptr
  ret i32 %inc.lcssa
}

define i32 @compare_bytes_simple3(ptr %a, ptr %b, ptr %c, i32 %d, i32 %len, i32 %n) {
  entry:
  br label %while.cond

  while.cond:
  %len.addr = phi i32 [ %len, %entry ], [ %inc, %while.body ]
  %inc = add i32 %len.addr, 1
  %cmp.not = icmp eq i32 %inc, %n
  br i1 %cmp.not, label %while.end, label %while.body

  while.body:
  %idxprom = zext i32 %inc to i64
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %idxprom
  %0 = load i8, ptr %arrayidx
  %arrayidx2 = getelementptr inbounds i8, ptr %b, i64 %idxprom
  %1 = load i8, ptr %arrayidx2
  %cmp.not2 = icmp eq i8 %0, %1
  br i1 %cmp.not2, label %while.cond, label %while.end

  while.end:
  %final_val = phi i32 [ %d, %while.body ], [ %inc, %while.cond ]
  store i32 %final_val, ptr %c
  ret i32 %final_val
}

; Disable the optimization when noimplicitfloat is present.
define i32 @no_implicit_float(ptr %a, ptr %b, i32 %len, i32 %n) noimplicitfloat {
entry:
  br label %while.cond

while.cond:
  %len.addr = phi i32 [ %len, %entry ], [ %inc, %while.body ]
  %inc = add i32 %len.addr, 1
  %cmp.not = icmp eq i32 %inc, %n
  br i1 %cmp.not, label %while.end, label %while.body

while.body:
  %idxprom = zext i32 %inc to i64
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %idxprom
  %0 = load i8, ptr %arrayidx
  %arrayidx2 = getelementptr inbounds i8, ptr %b, i64 %idxprom
  %1 = load i8, ptr %arrayidx2
  %cmp.not2 = icmp eq i8 %0, %1
  br i1 %cmp.not2, label %while.cond, label %while.end

while.end:
  %inc.lcssa = phi i32 [ %inc, %while.body ], [ %inc, %while.cond ]
  ret i32 %inc.lcssa
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpszxu4dcq.ll'
source_filename = "/tmp/tmpszxu4dcq.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define i32 @compare_bytes_simple(ptr %a, ptr %b, i32 %len, i32 %n) #0 {
entry:
  %0 = add i32 %len, 1
  %1 = zext i32 %0 to i64
  %2 = zext i32 %n to i64
  %3 = icmp ule i32 %0, %n
  br i1 %3, label %mismatch_mem_check, label %mismatch_loop_pre, !prof !0

mismatch_mem_check:                               ; preds = %entry
  %4 = getelementptr i8, ptr %a, i64 %1
  %5 = getelementptr i8, ptr %b, i64 %1
  %6 = ptrtoint ptr %5 to i64
  %7 = ptrtoint ptr %4 to i64
  %8 = getelementptr i8, ptr %a, i64 %2
  %9 = getelementptr i8, ptr %b, i64 %2
  %10 = ptrtoint ptr %8 to i64
  %11 = ptrtoint ptr %9 to i64
  %12 = lshr i64 %7, 12
  %13 = lshr i64 %10, 12
  %14 = lshr i64 %6, 12
  %15 = lshr i64 %11, 12
  %16 = icmp ne i64 %12, %13
  %17 = icmp ne i64 %14, %15
  %18 = or i1 %16, %17
  br i1 %18, label %mismatch_loop_pre, label %mismatch_vec_loop, !prof !1

mismatch_vec_loop:                                ; preds = %mismatch_mem_check, %mismatch_vec_loop_inc
  %mismatch_vector_index = phi i64 [ %25, %mismatch_vec_loop_inc ], [ %1, %mismatch_mem_check ]
  %avl = sub nuw nsw i64 %2, %mismatch_vector_index
  %19 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %20 = getelementptr inbounds i8, ptr %a, i64 %mismatch_vector_index
  %lhs.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr %20, <vscale x 16 x i1> splat (i1 true), i32 %19)
  %21 = getelementptr inbounds i8, ptr %b, i64 %mismatch_vector_index
  %rhs.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr %21, <vscale x 16 x i1> splat (i1 true), i32 %19)
  %mismatch.cmp = icmp ne <vscale x 16 x i8> %lhs.load, %rhs.load
  %22 = call i32 @llvm.vp.cttz.elts.i32.nxv16i1(<vscale x 16 x i1> %mismatch.cmp, i1 false, <vscale x 16 x i1> splat (i1 true), i32 %19)
  %23 = icmp ne i32 %22, %19
  br i1 %23, label %mismatch_vec_loop_found, label %mismatch_vec_loop_inc

mismatch_vec_loop_inc:                            ; preds = %mismatch_vec_loop
  %24 = zext i32 %19 to i64
  %25 = add nuw nsw i64 %mismatch_vector_index, %24
  %26 = icmp ne i64 %25, %2
  br i1 %26, label %mismatch_vec_loop, label %while.end

mismatch_vec_loop_found:                          ; preds = %mismatch_vec_loop
  %ctz = phi i32 [ %22, %mismatch_vec_loop ]
  %mismatch_vector_index1 = phi i64 [ %mismatch_vector_index, %mismatch_vec_loop ]
  %27 = zext i32 %ctz to i64
  %28 = add nuw nsw i64 %mismatch_vector_index1, %27
  %29 = trunc i64 %28 to i32
  br label %while.end

mismatch_loop_pre:                                ; preds = %mismatch_mem_check, %entry
  br label %mismatch_loop

mismatch_loop:                                    ; preds = %mismatch_loop_inc, %mismatch_loop_pre
  %mismatch_index = phi i32 [ %0, %mismatch_loop_pre ], [ %36, %mismatch_loop_inc ]
  %30 = zext i32 %mismatch_index to i64
  %31 = getelementptr inbounds i8, ptr %a, i64 %30
  %32 = load i8, ptr %31, align 1
  %33 = getelementptr inbounds i8, ptr %b, i64 %30
  %34 = load i8, ptr %33, align 1
  %35 = icmp eq i8 %32, %34
  br i1 %35, label %mismatch_loop_inc, label %while.end

mismatch_loop_inc:                                ; preds = %mismatch_loop
  %36 = add i32 %mismatch_index, 1
  %37 = icmp eq i32 %36, %n
  br i1 %37, label %while.end, label %mismatch_loop

while.end:                                        ; preds = %mismatch_loop_inc, %mismatch_loop, %mismatch_vec_loop_found, %mismatch_vec_loop_inc
  %mismatch_result = phi i32 [ %n, %mismatch_loop_inc ], [ %mismatch_index, %mismatch_loop ], [ %n, %mismatch_vec_loop_inc ], [ %29, %mismatch_vec_loop_found ]
  ret i32 %mismatch_result
}

define i32 @compare_bytes_signed_wrap(ptr %a, ptr %b, i32 %len, i32 %n) #0 {
entry:
  %0 = add i32 %len, 1
  %1 = zext i32 %0 to i64
  %2 = zext i32 %n to i64
  %3 = icmp ule i32 %0, %n
  br i1 %3, label %mismatch_mem_check, label %mismatch_loop_pre, !prof !0

mismatch_mem_check:                               ; preds = %entry
  %4 = getelementptr i8, ptr %a, i64 %1
  %5 = getelementptr i8, ptr %b, i64 %1
  %6 = ptrtoint ptr %5 to i64
  %7 = ptrtoint ptr %4 to i64
  %8 = getelementptr i8, ptr %a, i64 %2
  %9 = getelementptr i8, ptr %b, i64 %2
  %10 = ptrtoint ptr %8 to i64
  %11 = ptrtoint ptr %9 to i64
  %12 = lshr i64 %7, 12
  %13 = lshr i64 %10, 12
  %14 = lshr i64 %6, 12
  %15 = lshr i64 %11, 12
  %16 = icmp ne i64 %12, %13
  %17 = icmp ne i64 %14, %15
  %18 = or i1 %16, %17
  br i1 %18, label %mismatch_loop_pre, label %mismatch_vec_loop, !prof !1

mismatch_vec_loop:                                ; preds = %mismatch_mem_check, %mismatch_vec_loop_inc
  %mismatch_vector_index = phi i64 [ %25, %mismatch_vec_loop_inc ], [ %1, %mismatch_mem_check ]
  %avl = sub nuw nsw i64 %2, %mismatch_vector_index
  %19 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %20 = getelementptr inbounds i8, ptr %a, i64 %mismatch_vector_index
  %lhs.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr %20, <vscale x 16 x i1> splat (i1 true), i32 %19)
  %21 = getelementptr inbounds i8, ptr %b, i64 %mismatch_vector_index
  %rhs.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr %21, <vscale x 16 x i1> splat (i1 true), i32 %19)
  %mismatch.cmp = icmp ne <vscale x 16 x i8> %lhs.load, %rhs.load
  %22 = call i32 @llvm.vp.cttz.elts.i32.nxv16i1(<vscale x 16 x i1> %mismatch.cmp, i1 false, <vscale x 16 x i1> splat (i1 true), i32 %19)
  %23 = icmp ne i32 %22, %19
  br i1 %23, label %mismatch_vec_loop_found, label %mismatch_vec_loop_inc

mismatch_vec_loop_inc:                            ; preds = %mismatch_vec_loop
  %24 = zext i32 %19 to i64
  %25 = add nuw nsw i64 %mismatch_vector_index, %24
  %26 = icmp ne i64 %25, %2
  br i1 %26, label %mismatch_vec_loop, label %while.end

mismatch_vec_loop_found:                          ; preds = %mismatch_vec_loop
  %ctz = phi i32 [ %22, %mismatch_vec_loop ]
  %mismatch_vector_index1 = phi i64 [ %mismatch_vector_index, %mismatch_vec_loop ]
  %27 = zext i32 %ctz to i64
  %28 = add nuw nsw i64 %mismatch_vector_index1, %27
  %29 = trunc i64 %28 to i32
  br label %while.end

mismatch_loop_pre:                                ; preds = %mismatch_mem_check, %entry
  br label %mismatch_loop

mismatch_loop:                                    ; preds = %mismatch_loop_inc, %mismatch_loop_pre
  %mismatch_index = phi i32 [ %0, %mismatch_loop_pre ], [ %36, %mismatch_loop_inc ]
  %30 = zext i32 %mismatch_index to i64
  %31 = getelementptr inbounds i8, ptr %a, i64 %30
  %32 = load i8, ptr %31, align 1
  %33 = getelementptr inbounds i8, ptr %b, i64 %30
  %34 = load i8, ptr %33, align 1
  %35 = icmp eq i8 %32, %34
  br i1 %35, label %mismatch_loop_inc, label %while.end

mismatch_loop_inc:                                ; preds = %mismatch_loop
  %36 = add nsw i32 %mismatch_index, 1
  %37 = icmp eq i32 %36, %n
  br i1 %37, label %while.end, label %mismatch_loop

while.end:                                        ; preds = %mismatch_loop_inc, %mismatch_loop, %mismatch_vec_loop_found, %mismatch_vec_loop_inc
  %mismatch_result = phi i32 [ %n, %mismatch_loop_inc ], [ %mismatch_index, %mismatch_loop ], [ %n, %mismatch_vec_loop_inc ], [ %29, %mismatch_vec_loop_found ]
  ret i32 %mismatch_result
}

define i32 @compare_bytes_simple_end_ne_found(ptr %a, ptr %b, ptr %c, ptr %d, i32 %len, i32 %n) #0 {
entry:
  %0 = add i32 %len, 1
  %1 = zext i32 %0 to i64
  %2 = zext i32 %n to i64
  %3 = icmp ule i32 %0, %n
  br i1 %3, label %mismatch_mem_check, label %mismatch_loop_pre, !prof !0

mismatch_mem_check:                               ; preds = %entry
  %4 = getelementptr i8, ptr %a, i64 %1
  %5 = getelementptr i8, ptr %b, i64 %1
  %6 = ptrtoint ptr %5 to i64
  %7 = ptrtoint ptr %4 to i64
  %8 = getelementptr i8, ptr %a, i64 %2
  %9 = getelementptr i8, ptr %b, i64 %2
  %10 = ptrtoint ptr %8 to i64
  %11 = ptrtoint ptr %9 to i64
  %12 = lshr i64 %7, 12
  %13 = lshr i64 %10, 12
  %14 = lshr i64 %6, 12
  %15 = lshr i64 %11, 12
  %16 = icmp ne i64 %12, %13
  %17 = icmp ne i64 %14, %15
  %18 = or i1 %16, %17
  br i1 %18, label %mismatch_loop_pre, label %mismatch_vec_loop, !prof !1

mismatch_vec_loop:                                ; preds = %mismatch_mem_check, %mismatch_vec_loop_inc
  %mismatch_vector_index = phi i64 [ %25, %mismatch_vec_loop_inc ], [ %1, %mismatch_mem_check ]
  %avl = sub nuw nsw i64 %2, %mismatch_vector_index
  %19 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %20 = getelementptr inbounds i8, ptr %a, i64 %mismatch_vector_index
  %lhs.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr %20, <vscale x 16 x i1> splat (i1 true), i32 %19)
  %21 = getelementptr inbounds i8, ptr %b, i64 %mismatch_vector_index
  %rhs.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr %21, <vscale x 16 x i1> splat (i1 true), i32 %19)
  %mismatch.cmp = icmp ne <vscale x 16 x i8> %lhs.load, %rhs.load
  %22 = call i32 @llvm.vp.cttz.elts.i32.nxv16i1(<vscale x 16 x i1> %mismatch.cmp, i1 false, <vscale x 16 x i1> splat (i1 true), i32 %19)
  %23 = icmp ne i32 %22, %19
  br i1 %23, label %mismatch_vec_loop_found, label %mismatch_vec_loop_inc

mismatch_vec_loop_inc:                            ; preds = %mismatch_vec_loop
  %24 = zext i32 %19 to i64
  %25 = add nuw nsw i64 %mismatch_vector_index, %24
  %26 = icmp ne i64 %25, %2
  br i1 %26, label %mismatch_vec_loop, label %byte.compare

mismatch_vec_loop_found:                          ; preds = %mismatch_vec_loop
  %ctz = phi i32 [ %22, %mismatch_vec_loop ]
  %mismatch_vector_index1 = phi i64 [ %mismatch_vector_index, %mismatch_vec_loop ]
  %27 = zext i32 %ctz to i64
  %28 = add nuw nsw i64 %mismatch_vector_index1, %27
  %29 = trunc i64 %28 to i32
  br label %byte.compare

mismatch_loop_pre:                                ; preds = %mismatch_mem_check, %entry
  br label %mismatch_loop

mismatch_loop:                                    ; preds = %mismatch_loop_inc, %mismatch_loop_pre
  %mismatch_index3 = phi i32 [ %0, %mismatch_loop_pre ], [ %36, %mismatch_loop_inc ]
  %30 = zext i32 %mismatch_index3 to i64
  %31 = getelementptr inbounds i8, ptr %a, i64 %30
  %32 = load i8, ptr %31, align 1
  %33 = getelementptr inbounds i8, ptr %b, i64 %30
  %34 = load i8, ptr %33, align 1
  %35 = icmp eq i8 %32, %34
  br i1 %35, label %mismatch_loop_inc, label %byte.compare

mismatch_loop_inc:                                ; preds = %mismatch_loop
  %36 = add i32 %mismatch_index3, 1
  %37 = icmp eq i32 %36, %n
  br i1 %37, label %byte.compare, label %mismatch_loop

byte.compare:                                     ; preds = %mismatch_vec_loop_inc, %mismatch_vec_loop_found, %mismatch_loop, %mismatch_loop_inc
  %mismatch_result = phi i32 [ %n, %mismatch_loop_inc ], [ %mismatch_index3, %mismatch_loop ], [ %n, %mismatch_vec_loop_inc ], [ %29, %mismatch_vec_loop_found ]
  %38 = icmp eq i32 %mismatch_result, %n
  %spec.select = select i1 %38, i32 %n, i32 %mismatch_result
  %spec.select4 = select i1 %38, ptr %d, ptr %c
  store i32 %spec.select, ptr %spec.select4, align 4
  ret i32 %spec.select
}

define i32 @compare_bytes_extra_cmp(ptr %a, ptr %b, i32 %len, i32 %n, i32 %x) #0 {
entry:
  %cmp.x = icmp ult i32 %n, %x
  br i1 %cmp.x, label %ph, label %while.end

ph:                                               ; preds = %entry
  %0 = add i32 %len, 1
  %1 = zext i32 %0 to i64
  %2 = zext i32 %n to i64
  %3 = icmp ule i32 %0, %n
  br i1 %3, label %mismatch_mem_check, label %mismatch_loop_pre, !prof !0

mismatch_mem_check:                               ; preds = %ph
  %4 = getelementptr i8, ptr %a, i64 %1
  %5 = getelementptr i8, ptr %b, i64 %1
  %6 = ptrtoint ptr %5 to i64
  %7 = ptrtoint ptr %4 to i64
  %8 = getelementptr i8, ptr %a, i64 %2
  %9 = getelementptr i8, ptr %b, i64 %2
  %10 = ptrtoint ptr %8 to i64
  %11 = ptrtoint ptr %9 to i64
  %12 = lshr i64 %7, 12
  %13 = lshr i64 %10, 12
  %14 = lshr i64 %6, 12
  %15 = lshr i64 %11, 12
  %16 = icmp ne i64 %12, %13
  %17 = icmp ne i64 %14, %15
  %18 = or i1 %16, %17
  br i1 %18, label %mismatch_loop_pre, label %mismatch_vec_loop, !prof !1

mismatch_vec_loop:                                ; preds = %mismatch_mem_check, %mismatch_vec_loop_inc
  %mismatch_vector_index = phi i64 [ %25, %mismatch_vec_loop_inc ], [ %1, %mismatch_mem_check ]
  %avl = sub nuw nsw i64 %2, %mismatch_vector_index
  %19 = call i32 @llvm.experimental.get.vector.length.i64(i64 %avl, i32 16, i1 true)
  %20 = getelementptr inbounds i8, ptr %a, i64 %mismatch_vector_index
  %lhs.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr %20, <vscale x 16 x i1> splat (i1 true), i32 %19)
  %21 = getelementptr inbounds i8, ptr %b, i64 %mismatch_vector_index
  %rhs.load = call <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr %21, <vscale x 16 x i1> splat (i1 true), i32 %19)
  %mismatch.cmp = icmp ne <vscale x 16 x i8> %lhs.load, %rhs.load
  %22 = call i32 @llvm.vp.cttz.elts.i32.nxv16i1(<vscale x 16 x i1> %mismatch.cmp, i1 false, <vscale x 16 x i1> splat (i1 true), i32 %19)
  %23 = icmp ne i32 %22, %19
  br i1 %23, label %mismatch_vec_loop_found, label %mismatch_vec_loop_inc

mismatch_vec_loop_inc:                            ; preds = %mismatch_vec_loop
  %24 = zext i32 %19 to i64
  %25 = add nuw nsw i64 %mismatch_vector_index, %24
  %26 = icmp ne i64 %25, %2
  br i1 %26, label %mismatch_vec_loop, label %while.end

mismatch_vec_loop_found:                          ; preds = %mismatch_vec_loop
  %ctz = phi i32 [ %22, %mismatch_vec_loop ]
  %mismatch_vector_index2 = phi i64 [ %mismatch_vector_index, %mismatch_vec_loop ]
  %27 = zext i32 %ctz to i64
  %28 = add nuw nsw i64 %mismatch_vector_index2, %27
  %29 = trunc i64 %28 to i32
  br label %while.end

mismatch_loop_pre:                                ; preds = %mismatch_mem_check, %ph
  br label %mismatch_loop

mismatch_loop:                                    ; preds = %mismatch_loop_inc, %mismatch_loop_pre
  %mismatch_index = phi i32 [ %0, %mismatch_loop_pre ], [ %36, %mismatch_loop_inc ]
  %30 = zext i32 %mismatch_index to i64
  %31 = getelementptr inbounds i8, ptr %a, i64 %30
  %32 = load i8, ptr %31, align 1
  %33 = getelementptr inbounds i8, ptr %b, i64 %30
  %34 = load i8, ptr %33, align 1
  %35 = icmp eq i8 %32, %34
  br i1 %35, label %mismatch_loop_inc, label %while.end

mismatch_loop_inc:                                ; preds = %mismatch_loop
  %36 = add i32 %mismatch_index, 1
  %37 = icmp eq i32 %36, %n
  br i1 %37, label %while.end, label %mismatch_loop

while.end:                                        ; preds = %mismatch_vec_loop_inc, %mismatch_vec_loop_found, %mismatch_loop, %mismatch_loop_inc, %entry
  %inc.lcssa = phi i32 [ %x, %entry ], [ %n, %mismatch_loop_inc ], [ %mismatch_index, %mismatch_loop ], [ %n, %mismatch_vec_loop_inc ], [ %29, %mismatch_vec_loop_found ]
  ret i32 %inc.lcssa
}

define void @compare_bytes_cleanup_block(ptr %src1, ptr %src2) #0 {
entry:
  br label %mismatch_loop

mismatch_loop:                                    ; preds = %mismatch_loop, %entry
  %mismatch_index = phi i32 [ 1, %entry ], [ %6, %mismatch_loop ]
  %0 = zext i32 %mismatch_index to i64
  %1 = getelementptr i8, ptr %src1, i64 %0
  %2 = load i8, ptr %1, align 1
  %3 = getelementptr i8, ptr %src2, i64 %0
  %4 = load i8, ptr %3, align 1
  %5 = icmp ne i8 %2, %4
  %6 = add i32 %mismatch_index, 1
  %7 = icmp eq i32 %6, 0
  %or.cond = or i1 %5, %7
  br i1 %or.cond, label %common.ret, label %mismatch_loop

common.ret:                                       ; preds = %mismatch_loop
  ret void
}

define i32 @compare_bytes_simple2(ptr %a, ptr %b, ptr %c, ptr %d, i32 %len, i32 %n) #0 {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %len.addr = phi i32 [ %len, %entry ], [ %inc, %while.body ]
  %inc = add i32 %len.addr, 1
  %cmp.not = icmp eq i32 %inc, %n
  br i1 %cmp.not, label %while.end, label %while.body

while.body:                                       ; preds = %while.cond
  %idxprom = zext i32 %inc to i64
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %idxprom
  %0 = load i8, ptr %arrayidx, align 1
  %arrayidx2 = getelementptr inbounds i8, ptr %b, i64 %idxprom
  %1 = load i8, ptr %arrayidx2, align 1
  %cmp.not2 = icmp eq i8 %0, %1
  br i1 %cmp.not2, label %while.cond, label %while.end

while.end:                                        ; preds = %while.body, %while.cond
  %inc.lcssa = phi i32 [ %inc, %while.body ], [ %inc, %while.cond ]
  %final_ptr = phi ptr [ %c, %while.body ], [ %d, %while.cond ]
  store i32 %inc.lcssa, ptr %final_ptr, align 4
  ret i32 %inc.lcssa
}

define i32 @compare_bytes_simple3(ptr %a, ptr %b, ptr %c, i32 %d, i32 %len, i32 %n) #0 {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %len.addr = phi i32 [ %len, %entry ], [ %inc, %while.body ]
  %inc = add i32 %len.addr, 1
  %cmp.not = icmp eq i32 %inc, %n
  br i1 %cmp.not, label %while.end, label %while.body

while.body:                                       ; preds = %while.cond
  %idxprom = zext i32 %inc to i64
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %idxprom
  %0 = load i8, ptr %arrayidx, align 1
  %arrayidx2 = getelementptr inbounds i8, ptr %b, i64 %idxprom
  %1 = load i8, ptr %arrayidx2, align 1
  %cmp.not2 = icmp eq i8 %0, %1
  br i1 %cmp.not2, label %while.cond, label %while.end

while.end:                                        ; preds = %while.body, %while.cond
  %final_val = phi i32 [ %d, %while.body ], [ %inc, %while.cond ]
  store i32 %final_val, ptr %c, align 4
  ret i32 %final_val
}

; Function Attrs: noimplicitfloat
define i32 @no_implicit_float(ptr %a, ptr %b, i32 %len, i32 %n) #1 {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %len.addr = phi i32 [ %len, %entry ], [ %inc, %while.body ]
  %inc = add i32 %len.addr, 1
  %cmp.not = icmp eq i32 %inc, %n
  br i1 %cmp.not, label %while.end, label %while.body

while.body:                                       ; preds = %while.cond
  %idxprom = zext i32 %inc to i64
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %idxprom
  %0 = load i8, ptr %arrayidx, align 1
  %arrayidx2 = getelementptr inbounds i8, ptr %b, i64 %idxprom
  %1 = load i8, ptr %arrayidx2, align 1
  %cmp.not2 = icmp eq i8 %0, %1
  br i1 %cmp.not2, label %while.cond, label %while.end

while.end:                                        ; preds = %while.body, %while.cond
  %inc.lcssa = phi i32 [ %inc, %while.body ], [ %inc, %while.cond ]
  ret i32 %inc.lcssa
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.get.vector.length.i64(i64, i32 immarg, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 16 x i8> @llvm.vp.load.nxv16i8.p0(ptr captures(none), <vscale x 16 x i1>, i32) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vp.cttz.elts.i32.nxv16i1(<vscale x 16 x i1>, i1 immarg, <vscale x 16 x i1>, i32) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { noimplicitfloat "target-features"="+v" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }

!0 = !{!"branch_weights", i32 99, i32 1}
!1 = !{!"branch_weights", i32 10, i32 90}
