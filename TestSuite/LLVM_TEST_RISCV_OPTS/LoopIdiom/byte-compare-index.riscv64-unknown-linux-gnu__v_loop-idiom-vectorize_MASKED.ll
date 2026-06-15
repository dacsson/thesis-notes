; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopIdiom/RISCV/byte-compare-index.ll
; Variant: riscv64-unknown-linux-gnu_+v_loop-idiom-vectorize_MASKED
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-idiom-vectorize -mtriple=riscv64-unknown-linux-gnu -loop-idiom-vectorize-style=masked -mattr=+v -S
; Original: RUN: opt -passes=loop-idiom-vectorize -mtriple=riscv64-unknown-linux-gnu -loop-idiom-vectorize-style=masked -mattr=+v -S < %s | FileCheck %s --check-prefix=MASKED

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

; ModuleID = '/tmp/tmpqa_faa6j.ll'
source_filename = "/tmp/tmpqa_faa6j.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define i32 @compare_bytes_simple(ptr %a, ptr %b, i32 %len, i32 %n) #0 {
entry:
  %0 = add i32 %len, 1
  br label %mismatch_min_it_check

mismatch_min_it_check:                            ; preds = %entry
  %1 = zext i32 %0 to i64
  %2 = zext i32 %n to i64
  %3 = icmp ule i32 %0, %n
  br i1 %3, label %mismatch_mem_check, label %mismatch_loop_pre, !prof !0

mismatch_mem_check:                               ; preds = %mismatch_min_it_check
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
  br i1 %18, label %mismatch_loop_pre, label %mismatch_vec_loop_preheader, !prof !1

mismatch_vec_loop_preheader:                      ; preds = %mismatch_mem_check
  %19 = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64 %1, i64 %2)
  %20 = call i64 @llvm.vscale.i64()
  %21 = mul nuw nsw i64 %20, 16
  br label %mismatch_vec_loop

mismatch_vec_loop:                                ; preds = %mismatch_vec_loop_inc, %mismatch_vec_loop_preheader
  %mismatch_vec_loop_pred = phi <vscale x 16 x i1> [ %19, %mismatch_vec_loop_preheader ], [ %30, %mismatch_vec_loop_inc ]
  %mismatch_vec_index = phi i64 [ %1, %mismatch_vec_loop_preheader ], [ %29, %mismatch_vec_loop_inc ]
  %22 = getelementptr inbounds i8, ptr %a, i64 %mismatch_vec_index
  %23 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr align 1 %22, <vscale x 16 x i1> %mismatch_vec_loop_pred, <vscale x 16 x i8> zeroinitializer)
  %24 = getelementptr inbounds i8, ptr %b, i64 %mismatch_vec_index
  %25 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr align 1 %24, <vscale x 16 x i1> %mismatch_vec_loop_pred, <vscale x 16 x i8> zeroinitializer)
  %26 = icmp ne <vscale x 16 x i8> %23, %25
  %27 = select <vscale x 16 x i1> %mismatch_vec_loop_pred, <vscale x 16 x i1> %26, <vscale x 16 x i1> zeroinitializer
  %28 = call i1 @llvm.vector.reduce.or.nxv16i1(<vscale x 16 x i1> %27)
  br i1 %28, label %mismatch_vec_loop_found, label %mismatch_vec_loop_inc

mismatch_vec_loop_inc:                            ; preds = %mismatch_vec_loop
  %29 = add nuw nsw i64 %mismatch_vec_index, %21
  %30 = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64 %29, i64 %2)
  %31 = extractelement <vscale x 16 x i1> %30, i64 0
  br i1 %31, label %mismatch_vec_loop, label %mismatch_end

mismatch_vec_loop_found:                          ; preds = %mismatch_vec_loop
  %mismatch_vec_found_pred = phi <vscale x 16 x i1> [ %27, %mismatch_vec_loop ]
  %mismatch_vec_last_loop_pred = phi <vscale x 16 x i1> [ %mismatch_vec_loop_pred, %mismatch_vec_loop ]
  %mismatch_vec_found_index = phi i64 [ %mismatch_vec_index, %mismatch_vec_loop ]
  %32 = and <vscale x 16 x i1> %mismatch_vec_last_loop_pred, %mismatch_vec_found_pred
  %33 = call i32 @llvm.experimental.cttz.elts.i32.nxv16i1(<vscale x 16 x i1> %32, i1 true)
  %34 = zext i32 %33 to i64
  %35 = add nuw nsw i64 %mismatch_vec_found_index, %34
  %36 = trunc i64 %35 to i32
  br label %mismatch_end

mismatch_loop_pre:                                ; preds = %mismatch_mem_check, %mismatch_min_it_check
  br label %mismatch_loop

mismatch_loop:                                    ; preds = %mismatch_loop_inc, %mismatch_loop_pre
  %mismatch_index = phi i32 [ %0, %mismatch_loop_pre ], [ %43, %mismatch_loop_inc ]
  %37 = zext i32 %mismatch_index to i64
  %38 = getelementptr inbounds i8, ptr %a, i64 %37
  %39 = load i8, ptr %38, align 1
  %40 = getelementptr inbounds i8, ptr %b, i64 %37
  %41 = load i8, ptr %40, align 1
  %42 = icmp eq i8 %39, %41
  br i1 %42, label %mismatch_loop_inc, label %mismatch_end

mismatch_loop_inc:                                ; preds = %mismatch_loop
  %43 = add i32 %mismatch_index, 1
  %44 = icmp eq i32 %43, %n
  br i1 %44, label %mismatch_end, label %mismatch_loop

mismatch_end:                                     ; preds = %mismatch_loop_inc, %mismatch_loop, %mismatch_vec_loop_found, %mismatch_vec_loop_inc
  %mismatch_result = phi i32 [ %n, %mismatch_loop_inc ], [ %mismatch_index, %mismatch_loop ], [ %n, %mismatch_vec_loop_inc ], [ %36, %mismatch_vec_loop_found ]
  br i1 true, label %byte.compare, label %while.cond

while.cond:                                       ; preds = %mismatch_end, %while.body
  %len.addr = phi i32 [ %len, %mismatch_end ], [ %mismatch_result, %while.body ]
  %inc = add i32 %len.addr, 1
  %cmp.not = icmp eq i32 %mismatch_result, %n
  br i1 %cmp.not, label %while.end, label %while.body

while.body:                                       ; preds = %while.cond
  %idxprom = zext i32 %mismatch_result to i64
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %idxprom
  %45 = load i8, ptr %arrayidx, align 1
  %arrayidx2 = getelementptr inbounds i8, ptr %b, i64 %idxprom
  %46 = load i8, ptr %arrayidx2, align 1
  %cmp.not2 = icmp eq i8 %45, %46
  br i1 %cmp.not2, label %while.cond, label %while.end

byte.compare:                                     ; preds = %mismatch_end
  br label %while.end

while.end:                                        ; preds = %byte.compare, %while.body, %while.cond
  %inc.lcssa = phi i32 [ %mismatch_result, %while.body ], [ %mismatch_result, %while.cond ], [ %mismatch_result, %byte.compare ]
  ret i32 %inc.lcssa
}

define i32 @compare_bytes_signed_wrap(ptr %a, ptr %b, i32 %len, i32 %n) #0 {
entry:
  %0 = add i32 %len, 1
  br label %mismatch_min_it_check

mismatch_min_it_check:                            ; preds = %entry
  %1 = zext i32 %0 to i64
  %2 = zext i32 %n to i64
  %3 = icmp ule i32 %0, %n
  br i1 %3, label %mismatch_mem_check, label %mismatch_loop_pre, !prof !0

mismatch_mem_check:                               ; preds = %mismatch_min_it_check
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
  br i1 %18, label %mismatch_loop_pre, label %mismatch_vec_loop_preheader, !prof !1

mismatch_vec_loop_preheader:                      ; preds = %mismatch_mem_check
  %19 = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64 %1, i64 %2)
  %20 = call i64 @llvm.vscale.i64()
  %21 = mul nuw nsw i64 %20, 16
  br label %mismatch_vec_loop

mismatch_vec_loop:                                ; preds = %mismatch_vec_loop_inc, %mismatch_vec_loop_preheader
  %mismatch_vec_loop_pred = phi <vscale x 16 x i1> [ %19, %mismatch_vec_loop_preheader ], [ %30, %mismatch_vec_loop_inc ]
  %mismatch_vec_index = phi i64 [ %1, %mismatch_vec_loop_preheader ], [ %29, %mismatch_vec_loop_inc ]
  %22 = getelementptr inbounds i8, ptr %a, i64 %mismatch_vec_index
  %23 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr align 1 %22, <vscale x 16 x i1> %mismatch_vec_loop_pred, <vscale x 16 x i8> zeroinitializer)
  %24 = getelementptr inbounds i8, ptr %b, i64 %mismatch_vec_index
  %25 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr align 1 %24, <vscale x 16 x i1> %mismatch_vec_loop_pred, <vscale x 16 x i8> zeroinitializer)
  %26 = icmp ne <vscale x 16 x i8> %23, %25
  %27 = select <vscale x 16 x i1> %mismatch_vec_loop_pred, <vscale x 16 x i1> %26, <vscale x 16 x i1> zeroinitializer
  %28 = call i1 @llvm.vector.reduce.or.nxv16i1(<vscale x 16 x i1> %27)
  br i1 %28, label %mismatch_vec_loop_found, label %mismatch_vec_loop_inc

mismatch_vec_loop_inc:                            ; preds = %mismatch_vec_loop
  %29 = add nuw nsw i64 %mismatch_vec_index, %21
  %30 = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64 %29, i64 %2)
  %31 = extractelement <vscale x 16 x i1> %30, i64 0
  br i1 %31, label %mismatch_vec_loop, label %mismatch_end

mismatch_vec_loop_found:                          ; preds = %mismatch_vec_loop
  %mismatch_vec_found_pred = phi <vscale x 16 x i1> [ %27, %mismatch_vec_loop ]
  %mismatch_vec_last_loop_pred = phi <vscale x 16 x i1> [ %mismatch_vec_loop_pred, %mismatch_vec_loop ]
  %mismatch_vec_found_index = phi i64 [ %mismatch_vec_index, %mismatch_vec_loop ]
  %32 = and <vscale x 16 x i1> %mismatch_vec_last_loop_pred, %mismatch_vec_found_pred
  %33 = call i32 @llvm.experimental.cttz.elts.i32.nxv16i1(<vscale x 16 x i1> %32, i1 true)
  %34 = zext i32 %33 to i64
  %35 = add nuw nsw i64 %mismatch_vec_found_index, %34
  %36 = trunc i64 %35 to i32
  br label %mismatch_end

mismatch_loop_pre:                                ; preds = %mismatch_mem_check, %mismatch_min_it_check
  br label %mismatch_loop

mismatch_loop:                                    ; preds = %mismatch_loop_inc, %mismatch_loop_pre
  %mismatch_index = phi i32 [ %0, %mismatch_loop_pre ], [ %43, %mismatch_loop_inc ]
  %37 = zext i32 %mismatch_index to i64
  %38 = getelementptr inbounds i8, ptr %a, i64 %37
  %39 = load i8, ptr %38, align 1
  %40 = getelementptr inbounds i8, ptr %b, i64 %37
  %41 = load i8, ptr %40, align 1
  %42 = icmp eq i8 %39, %41
  br i1 %42, label %mismatch_loop_inc, label %mismatch_end

mismatch_loop_inc:                                ; preds = %mismatch_loop
  %43 = add nsw i32 %mismatch_index, 1
  %44 = icmp eq i32 %43, %n
  br i1 %44, label %mismatch_end, label %mismatch_loop

mismatch_end:                                     ; preds = %mismatch_loop_inc, %mismatch_loop, %mismatch_vec_loop_found, %mismatch_vec_loop_inc
  %mismatch_result = phi i32 [ %n, %mismatch_loop_inc ], [ %mismatch_index, %mismatch_loop ], [ %n, %mismatch_vec_loop_inc ], [ %36, %mismatch_vec_loop_found ]
  br i1 true, label %byte.compare, label %while.cond

while.cond:                                       ; preds = %mismatch_end, %while.body
  %len.addr = phi i32 [ %len, %mismatch_end ], [ %mismatch_result, %while.body ]
  %inc = add nsw i32 %len.addr, 1
  %cmp.not = icmp eq i32 %mismatch_result, %n
  br i1 %cmp.not, label %while.end, label %while.body

while.body:                                       ; preds = %while.cond
  %idxprom = zext i32 %mismatch_result to i64
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %idxprom
  %45 = load i8, ptr %arrayidx, align 1
  %arrayidx2 = getelementptr inbounds i8, ptr %b, i64 %idxprom
  %46 = load i8, ptr %arrayidx2, align 1
  %cmp.not2 = icmp eq i8 %45, %46
  br i1 %cmp.not2, label %while.cond, label %while.end

byte.compare:                                     ; preds = %mismatch_end
  br label %while.end

while.end:                                        ; preds = %byte.compare, %while.body, %while.cond
  %inc.lcssa = phi i32 [ %mismatch_result, %while.body ], [ %mismatch_result, %while.cond ], [ %mismatch_result, %byte.compare ]
  ret i32 %inc.lcssa
}

define i32 @compare_bytes_simple_end_ne_found(ptr %a, ptr %b, ptr %c, ptr %d, i32 %len, i32 %n) #0 {
entry:
  %0 = add i32 %len, 1
  br label %mismatch_min_it_check

mismatch_min_it_check:                            ; preds = %entry
  %1 = zext i32 %0 to i64
  %2 = zext i32 %n to i64
  %3 = icmp ule i32 %0, %n
  br i1 %3, label %mismatch_mem_check, label %mismatch_loop_pre, !prof !0

mismatch_mem_check:                               ; preds = %mismatch_min_it_check
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
  br i1 %18, label %mismatch_loop_pre, label %mismatch_vec_loop_preheader, !prof !1

mismatch_vec_loop_preheader:                      ; preds = %mismatch_mem_check
  %19 = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64 %1, i64 %2)
  %20 = call i64 @llvm.vscale.i64()
  %21 = mul nuw nsw i64 %20, 16
  br label %mismatch_vec_loop

mismatch_vec_loop:                                ; preds = %mismatch_vec_loop_inc, %mismatch_vec_loop_preheader
  %mismatch_vec_loop_pred = phi <vscale x 16 x i1> [ %19, %mismatch_vec_loop_preheader ], [ %30, %mismatch_vec_loop_inc ]
  %mismatch_vec_index = phi i64 [ %1, %mismatch_vec_loop_preheader ], [ %29, %mismatch_vec_loop_inc ]
  %22 = getelementptr inbounds i8, ptr %a, i64 %mismatch_vec_index
  %23 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr align 1 %22, <vscale x 16 x i1> %mismatch_vec_loop_pred, <vscale x 16 x i8> zeroinitializer)
  %24 = getelementptr inbounds i8, ptr %b, i64 %mismatch_vec_index
  %25 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr align 1 %24, <vscale x 16 x i1> %mismatch_vec_loop_pred, <vscale x 16 x i8> zeroinitializer)
  %26 = icmp ne <vscale x 16 x i8> %23, %25
  %27 = select <vscale x 16 x i1> %mismatch_vec_loop_pred, <vscale x 16 x i1> %26, <vscale x 16 x i1> zeroinitializer
  %28 = call i1 @llvm.vector.reduce.or.nxv16i1(<vscale x 16 x i1> %27)
  br i1 %28, label %mismatch_vec_loop_found, label %mismatch_vec_loop_inc

mismatch_vec_loop_inc:                            ; preds = %mismatch_vec_loop
  %29 = add nuw nsw i64 %mismatch_vec_index, %21
  %30 = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64 %29, i64 %2)
  %31 = extractelement <vscale x 16 x i1> %30, i64 0
  br i1 %31, label %mismatch_vec_loop, label %mismatch_end

mismatch_vec_loop_found:                          ; preds = %mismatch_vec_loop
  %mismatch_vec_found_pred = phi <vscale x 16 x i1> [ %27, %mismatch_vec_loop ]
  %mismatch_vec_last_loop_pred = phi <vscale x 16 x i1> [ %mismatch_vec_loop_pred, %mismatch_vec_loop ]
  %mismatch_vec_found_index = phi i64 [ %mismatch_vec_index, %mismatch_vec_loop ]
  %32 = and <vscale x 16 x i1> %mismatch_vec_last_loop_pred, %mismatch_vec_found_pred
  %33 = call i32 @llvm.experimental.cttz.elts.i32.nxv16i1(<vscale x 16 x i1> %32, i1 true)
  %34 = zext i32 %33 to i64
  %35 = add nuw nsw i64 %mismatch_vec_found_index, %34
  %36 = trunc i64 %35 to i32
  br label %mismatch_end

mismatch_loop_pre:                                ; preds = %mismatch_mem_check, %mismatch_min_it_check
  br label %mismatch_loop

mismatch_loop:                                    ; preds = %mismatch_loop_inc, %mismatch_loop_pre
  %mismatch_index3 = phi i32 [ %0, %mismatch_loop_pre ], [ %43, %mismatch_loop_inc ]
  %37 = zext i32 %mismatch_index3 to i64
  %38 = getelementptr inbounds i8, ptr %a, i64 %37
  %39 = load i8, ptr %38, align 1
  %40 = getelementptr inbounds i8, ptr %b, i64 %37
  %41 = load i8, ptr %40, align 1
  %42 = icmp eq i8 %39, %41
  br i1 %42, label %mismatch_loop_inc, label %mismatch_end

mismatch_loop_inc:                                ; preds = %mismatch_loop
  %43 = add i32 %mismatch_index3, 1
  %44 = icmp eq i32 %43, %n
  br i1 %44, label %mismatch_end, label %mismatch_loop

mismatch_end:                                     ; preds = %mismatch_loop_inc, %mismatch_loop, %mismatch_vec_loop_found, %mismatch_vec_loop_inc
  %mismatch_result = phi i32 [ %n, %mismatch_loop_inc ], [ %mismatch_index3, %mismatch_loop ], [ %n, %mismatch_vec_loop_inc ], [ %36, %mismatch_vec_loop_found ]
  br i1 true, label %byte.compare, label %while.cond

while.cond:                                       ; preds = %mismatch_end, %while.body
  %len.addr = phi i32 [ %len, %mismatch_end ], [ %mismatch_result, %while.body ]
  %inc = add i32 %len.addr, 1
  %cmp.not = icmp eq i32 %mismatch_result, %n
  br i1 %cmp.not, label %while.end, label %while.body

while.body:                                       ; preds = %while.cond
  %idxprom = zext i32 %mismatch_result to i64
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %idxprom
  %45 = load i8, ptr %arrayidx, align 1
  %arrayidx2 = getelementptr inbounds i8, ptr %b, i64 %idxprom
  %46 = load i8, ptr %arrayidx2, align 1
  %cmp.not2 = icmp eq i8 %45, %46
  br i1 %cmp.not2, label %while.cond, label %while.found

while.found:                                      ; preds = %byte.compare, %while.body
  %mismatch_index1 = phi i32 [ %mismatch_result, %while.body ], [ %mismatch_result, %byte.compare ]
  %found_ptr = phi ptr [ %c, %while.body ], [ %c, %byte.compare ]
  br label %end

byte.compare:                                     ; preds = %mismatch_end
  %47 = icmp eq i32 %mismatch_result, %n
  br i1 %47, label %while.end, label %while.found

while.end:                                        ; preds = %byte.compare, %while.cond
  %mismatch_index2 = phi i32 [ %n, %while.cond ], [ %n, %byte.compare ]
  %end_ptr = phi ptr [ %d, %while.cond ], [ %d, %byte.compare ]
  br label %end

end:                                              ; preds = %while.end, %while.found
  %mismatch_index = phi i32 [ %mismatch_index1, %while.found ], [ %mismatch_index2, %while.end ]
  %store_ptr = phi ptr [ %end_ptr, %while.end ], [ %found_ptr, %while.found ]
  store i32 %mismatch_index, ptr %store_ptr, align 4
  ret i32 %mismatch_index
}

define i32 @compare_bytes_extra_cmp(ptr %a, ptr %b, i32 %len, i32 %n, i32 %x) #0 {
entry:
  %cmp.x = icmp ult i32 %n, %x
  br i1 %cmp.x, label %ph, label %while.end

ph:                                               ; preds = %entry
  %0 = add i32 %len, 1
  br label %mismatch_min_it_check

mismatch_min_it_check:                            ; preds = %ph
  %1 = zext i32 %0 to i64
  %2 = zext i32 %n to i64
  %3 = icmp ule i32 %0, %n
  br i1 %3, label %mismatch_mem_check, label %mismatch_loop_pre, !prof !0

mismatch_mem_check:                               ; preds = %mismatch_min_it_check
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
  br i1 %18, label %mismatch_loop_pre, label %mismatch_vec_loop_preheader, !prof !1

mismatch_vec_loop_preheader:                      ; preds = %mismatch_mem_check
  %19 = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64 %1, i64 %2)
  %20 = call i64 @llvm.vscale.i64()
  %21 = mul nuw nsw i64 %20, 16
  br label %mismatch_vec_loop

mismatch_vec_loop:                                ; preds = %mismatch_vec_loop_inc, %mismatch_vec_loop_preheader
  %mismatch_vec_loop_pred = phi <vscale x 16 x i1> [ %19, %mismatch_vec_loop_preheader ], [ %30, %mismatch_vec_loop_inc ]
  %mismatch_vec_index = phi i64 [ %1, %mismatch_vec_loop_preheader ], [ %29, %mismatch_vec_loop_inc ]
  %22 = getelementptr inbounds i8, ptr %a, i64 %mismatch_vec_index
  %23 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr align 1 %22, <vscale x 16 x i1> %mismatch_vec_loop_pred, <vscale x 16 x i8> zeroinitializer)
  %24 = getelementptr inbounds i8, ptr %b, i64 %mismatch_vec_index
  %25 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr align 1 %24, <vscale x 16 x i1> %mismatch_vec_loop_pred, <vscale x 16 x i8> zeroinitializer)
  %26 = icmp ne <vscale x 16 x i8> %23, %25
  %27 = select <vscale x 16 x i1> %mismatch_vec_loop_pred, <vscale x 16 x i1> %26, <vscale x 16 x i1> zeroinitializer
  %28 = call i1 @llvm.vector.reduce.or.nxv16i1(<vscale x 16 x i1> %27)
  br i1 %28, label %mismatch_vec_loop_found, label %mismatch_vec_loop_inc

mismatch_vec_loop_inc:                            ; preds = %mismatch_vec_loop
  %29 = add nuw nsw i64 %mismatch_vec_index, %21
  %30 = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64 %29, i64 %2)
  %31 = extractelement <vscale x 16 x i1> %30, i64 0
  br i1 %31, label %mismatch_vec_loop, label %mismatch_end

mismatch_vec_loop_found:                          ; preds = %mismatch_vec_loop
  %mismatch_vec_found_pred = phi <vscale x 16 x i1> [ %27, %mismatch_vec_loop ]
  %mismatch_vec_last_loop_pred = phi <vscale x 16 x i1> [ %mismatch_vec_loop_pred, %mismatch_vec_loop ]
  %mismatch_vec_found_index = phi i64 [ %mismatch_vec_index, %mismatch_vec_loop ]
  %32 = and <vscale x 16 x i1> %mismatch_vec_last_loop_pred, %mismatch_vec_found_pred
  %33 = call i32 @llvm.experimental.cttz.elts.i32.nxv16i1(<vscale x 16 x i1> %32, i1 true)
  %34 = zext i32 %33 to i64
  %35 = add nuw nsw i64 %mismatch_vec_found_index, %34
  %36 = trunc i64 %35 to i32
  br label %mismatch_end

mismatch_loop_pre:                                ; preds = %mismatch_mem_check, %mismatch_min_it_check
  br label %mismatch_loop

mismatch_loop:                                    ; preds = %mismatch_loop_inc, %mismatch_loop_pre
  %mismatch_index = phi i32 [ %0, %mismatch_loop_pre ], [ %43, %mismatch_loop_inc ]
  %37 = zext i32 %mismatch_index to i64
  %38 = getelementptr inbounds i8, ptr %a, i64 %37
  %39 = load i8, ptr %38, align 1
  %40 = getelementptr inbounds i8, ptr %b, i64 %37
  %41 = load i8, ptr %40, align 1
  %42 = icmp eq i8 %39, %41
  br i1 %42, label %mismatch_loop_inc, label %mismatch_end

mismatch_loop_inc:                                ; preds = %mismatch_loop
  %43 = add i32 %mismatch_index, 1
  %44 = icmp eq i32 %43, %n
  br i1 %44, label %mismatch_end, label %mismatch_loop

mismatch_end:                                     ; preds = %mismatch_loop_inc, %mismatch_loop, %mismatch_vec_loop_found, %mismatch_vec_loop_inc
  %mismatch_result = phi i32 [ %n, %mismatch_loop_inc ], [ %mismatch_index, %mismatch_loop ], [ %n, %mismatch_vec_loop_inc ], [ %36, %mismatch_vec_loop_found ]
  br i1 true, label %byte.compare, label %while.cond

while.cond:                                       ; preds = %mismatch_end, %while.body
  %len.addr = phi i32 [ %len, %mismatch_end ], [ %mismatch_result, %while.body ]
  %inc = add i32 %len.addr, 1
  %cmp.not = icmp eq i32 %mismatch_result, %n
  br i1 %cmp.not, label %while.end.loopexit, label %while.body

while.body:                                       ; preds = %while.cond
  %idxprom = zext i32 %mismatch_result to i64
  %arrayidx = getelementptr inbounds i8, ptr %a, i64 %idxprom
  %45 = load i8, ptr %arrayidx, align 1
  %arrayidx2 = getelementptr inbounds i8, ptr %b, i64 %idxprom
  %46 = load i8, ptr %arrayidx2, align 1
  %cmp.not2 = icmp eq i8 %45, %46
  br i1 %cmp.not2, label %while.cond, label %while.end.loopexit

byte.compare:                                     ; preds = %mismatch_end
  br label %while.end.loopexit

while.end.loopexit:                               ; preds = %byte.compare, %while.cond, %while.body
  %inc.lcssa1 = phi i32 [ %mismatch_result, %while.cond ], [ %mismatch_result, %while.body ], [ %mismatch_result, %byte.compare ]
  br label %while.end

while.end:                                        ; preds = %while.end.loopexit, %entry
  %inc.lcssa = phi i32 [ %x, %entry ], [ %inc.lcssa1, %while.end.loopexit ]
  ret i32 %inc.lcssa
}

define void @compare_bytes_cleanup_block(ptr %src1, ptr %src2) #0 {
entry:
  br label %mismatch_min_it_check

mismatch_min_it_check:                            ; preds = %entry
  br i1 false, label %mismatch_mem_check, label %mismatch_loop_pre, !prof !0

mismatch_mem_check:                               ; preds = %mismatch_min_it_check
  %0 = getelementptr i8, ptr %src1, i64 1
  %1 = getelementptr i8, ptr %src2, i64 1
  %2 = ptrtoint ptr %1 to i64
  %3 = ptrtoint ptr %0 to i64
  %4 = getelementptr i8, ptr %src1, i64 0
  %5 = getelementptr i8, ptr %src2, i64 0
  %6 = ptrtoint ptr %4 to i64
  %7 = ptrtoint ptr %5 to i64
  %8 = lshr i64 %3, 12
  %9 = lshr i64 %6, 12
  %10 = lshr i64 %2, 12
  %11 = lshr i64 %7, 12
  %12 = icmp ne i64 %8, %9
  %13 = icmp ne i64 %10, %11
  %14 = or i1 %12, %13
  br i1 %14, label %mismatch_loop_pre, label %mismatch_vec_loop_preheader, !prof !1

mismatch_vec_loop_preheader:                      ; preds = %mismatch_mem_check
  %15 = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64 1, i64 0)
  %16 = call i64 @llvm.vscale.i64()
  %17 = mul nuw nsw i64 %16, 16
  br label %mismatch_vec_loop

mismatch_vec_loop:                                ; preds = %mismatch_vec_loop_inc, %mismatch_vec_loop_preheader
  %mismatch_vec_loop_pred = phi <vscale x 16 x i1> [ %15, %mismatch_vec_loop_preheader ], [ %26, %mismatch_vec_loop_inc ]
  %mismatch_vec_index = phi i64 [ 1, %mismatch_vec_loop_preheader ], [ %25, %mismatch_vec_loop_inc ]
  %18 = getelementptr i8, ptr %src1, i64 %mismatch_vec_index
  %19 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr align 1 %18, <vscale x 16 x i1> %mismatch_vec_loop_pred, <vscale x 16 x i8> zeroinitializer)
  %20 = getelementptr i8, ptr %src2, i64 %mismatch_vec_index
  %21 = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr align 1 %20, <vscale x 16 x i1> %mismatch_vec_loop_pred, <vscale x 16 x i8> zeroinitializer)
  %22 = icmp ne <vscale x 16 x i8> %19, %21
  %23 = select <vscale x 16 x i1> %mismatch_vec_loop_pred, <vscale x 16 x i1> %22, <vscale x 16 x i1> zeroinitializer
  %24 = call i1 @llvm.vector.reduce.or.nxv16i1(<vscale x 16 x i1> %23)
  br i1 %24, label %mismatch_vec_loop_found, label %mismatch_vec_loop_inc

mismatch_vec_loop_inc:                            ; preds = %mismatch_vec_loop
  %25 = add nuw nsw i64 %mismatch_vec_index, %17
  %26 = call <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64 %25, i64 0)
  %27 = extractelement <vscale x 16 x i1> %26, i64 0
  br i1 %27, label %mismatch_vec_loop, label %mismatch_end

mismatch_vec_loop_found:                          ; preds = %mismatch_vec_loop
  %mismatch_vec_found_pred = phi <vscale x 16 x i1> [ %23, %mismatch_vec_loop ]
  %mismatch_vec_last_loop_pred = phi <vscale x 16 x i1> [ %mismatch_vec_loop_pred, %mismatch_vec_loop ]
  %mismatch_vec_found_index = phi i64 [ %mismatch_vec_index, %mismatch_vec_loop ]
  %28 = and <vscale x 16 x i1> %mismatch_vec_last_loop_pred, %mismatch_vec_found_pred
  %29 = call i32 @llvm.experimental.cttz.elts.i32.nxv16i1(<vscale x 16 x i1> %28, i1 true)
  %30 = zext i32 %29 to i64
  %31 = add nuw nsw i64 %mismatch_vec_found_index, %30
  %32 = trunc i64 %31 to i32
  br label %mismatch_end

mismatch_loop_pre:                                ; preds = %mismatch_mem_check, %mismatch_min_it_check
  br label %mismatch_loop

mismatch_loop:                                    ; preds = %mismatch_loop_inc, %mismatch_loop_pre
  %mismatch_index = phi i32 [ 1, %mismatch_loop_pre ], [ %39, %mismatch_loop_inc ]
  %33 = zext i32 %mismatch_index to i64
  %34 = getelementptr i8, ptr %src1, i64 %33
  %35 = load i8, ptr %34, align 1
  %36 = getelementptr i8, ptr %src2, i64 %33
  %37 = load i8, ptr %36, align 1
  %38 = icmp eq i8 %35, %37
  br i1 %38, label %mismatch_loop_inc, label %mismatch_end

mismatch_loop_inc:                                ; preds = %mismatch_loop
  %39 = add i32 %mismatch_index, 1
  %40 = icmp eq i32 %39, 0
  br i1 %40, label %mismatch_end, label %mismatch_loop

mismatch_end:                                     ; preds = %mismatch_loop_inc, %mismatch_loop, %mismatch_vec_loop_found, %mismatch_vec_loop_inc
  %mismatch_result = phi i32 [ 0, %mismatch_loop_inc ], [ %mismatch_index, %mismatch_loop ], [ 0, %mismatch_vec_loop_inc ], [ %32, %mismatch_vec_loop_found ]
  br i1 true, label %byte.compare, label %while.cond

while.cond:                                       ; preds = %mismatch_end, %while.body
  %len = phi i32 [ %mismatch_result, %while.body ], [ 0, %mismatch_end ]
  %inc = add i32 %len, 1
  %cmp.not = icmp eq i32 %mismatch_result, 0
  br i1 %cmp.not, label %cleanup.thread, label %while.body

while.body:                                       ; preds = %while.cond
  %idxprom = zext i32 %mismatch_result to i64
  %arrayidx = getelementptr i8, ptr %src1, i64 %idxprom
  %41 = load i8, ptr %arrayidx, align 1
  %arrayidx2 = getelementptr i8, ptr %src2, i64 %idxprom
  %42 = load i8, ptr %arrayidx2, align 1
  %cmp.not2 = icmp eq i8 %41, %42
  br i1 %cmp.not2, label %while.cond, label %if.end

byte.compare:                                     ; preds = %mismatch_end
  %43 = icmp eq i32 %mismatch_result, 0
  br i1 %43, label %cleanup.thread, label %if.end

cleanup.thread:                                   ; preds = %byte.compare, %while.cond
  ret void

if.end:                                           ; preds = %byte.compare, %while.body
  %res = phi i32 [ %mismatch_result, %while.body ], [ %mismatch_result, %byte.compare ]
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
declare <vscale x 16 x i1> @llvm.get.active.lane.mask.nxv16i1.i64(i64, i64) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.vscale.i64() #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(ptr captures(none), <vscale x 16 x i1>, <vscale x 16 x i8>) #3

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.vector.reduce.or.nxv16i1(<vscale x 16 x i1>) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.experimental.cttz.elts.i32.nxv16i1(<vscale x 16 x i1>, i1 immarg) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { noimplicitfloat "target-features"="+v" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #4 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!0 = !{!"branch_weights", i32 99, i32 1}
!1 = !{!"branch_weights", i32 10, i32 90}
