; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopVectorize/RISCV/early_exit_with_stores.ll
; Variant: riscv64_+v
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -p loop-vectorize -mtriple=riscv64 -mattr=+v -S
; Original: RUN: opt -S < %s -p loop-vectorize -mtriple=riscv64 -mattr=+v | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


;; See ../early_exit_store_legality.ll for reasons why a particular loop doesn't
;; vectorize yet.

define i64 @loop_contains_store(ptr dereferenceable(1024) %p1, ptr noalias %dest) {
entry:
  br label %loop

loop:
  %index = phi i64 [ %index.next, %loop.inc ], [ 3, %entry ]
  %arrayidx = getelementptr inbounds i32, ptr %p1, i64 %index
  %ld1 = load i32, ptr %arrayidx, align 1
  %arrayidx2 = getelementptr inbounds i32, ptr %dest, i64 %index
  store i32 %ld1, ptr %arrayidx2, align 4
  %cmp = icmp eq i32 %ld1, 1
  br i1 %cmp, label %loop.inc, label %loop.end

loop.inc:
  %index.next = add i64 %index, 1
  %exitcond = icmp ne i64 %index.next, 67
  br i1 %exitcond, label %loop, label %loop.end

loop.end:
  %retval = phi i64 [ %index, %loop ], [ 67, %loop.inc ]
  ret i64 %retval
}

define void @loop_contains_store_condition_load_has_single_user(ptr dereferenceable(40) noalias %array, ptr align 2 dereferenceable(40) readonly %pred) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define void @loop_contains_store_fcmp_condition(ptr dereferenceable(40) noalias %array, ptr align 2 dereferenceable(40) readonly %pred) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw half, ptr %pred, i64 %iv
  %ee.val = load half, ptr %ee.addr, align 2
  %ee.cond = fcmp ugt half %ee.val, 500.0
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define void @loop_contains_store_safe_dependency(ptr dereferenceable(40) noalias %array, ptr align 2 dereferenceable(96) %pred) {
entry:
  %pred.plus.8 = getelementptr inbounds nuw i16, ptr %pred, i64 8
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred.plus.8, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  %some.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  store i16 42, ptr %some.addr, align 2
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define void @loop_contains_store_unsafe_dependency(ptr dereferenceable(40) noalias %array, ptr align 2 dereferenceable(80) %pred) {
entry:
  %unknown.offset = call i64 @get_an_unknown_offset()
  %unknown.cmp = icmp ult i64 %unknown.offset, 20
  %clamped.offset = select i1 %unknown.cmp, i64 %unknown.offset, i64 20
  %unknown.base = getelementptr i16, ptr %pred, i64 %clamped.offset
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %unknown.base, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  %some.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  store i16 42, ptr %some.addr, align 2
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define void @loop_contains_store_assumed_bounds(ptr noalias %array, ptr readonly %pred, i64 %n) {
entry:
  %n_bytes = mul nuw nsw i64 %n, 2
  call void @llvm.assume(i1 true) [ "align"(ptr %pred, i64 2), "dereferenceable"(ptr %pred, i64 %n_bytes) ]
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, %n
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define void @loop_contains_store_to_pointer_with_no_deref_info(ptr align 2 dereferenceable(40) readonly %load.array, ptr align 2 noalias %array, ptr align 2 dereferenceable(40) readonly %pred) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %ld.addr = getelementptr inbounds nuw i16, ptr %load.array, i64 %iv
  %data = load i16, ptr %ld.addr, align 2
  %inc = add nsw i16 %data, 1
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define void @loop_contains_store_unknown_bounds(ptr align 2 dereferenceable(100) noalias %array, ptr align 2 dereferenceable(100) readonly %pred, i64 %n) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, %n
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define void @loop_contains_store_volatile(ptr dereferenceable(40) noalias %array, ptr align 2 dereferenceable(40) readonly %pred) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store volatile i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define void @loop_contains_store_in_latch_block(ptr dereferenceable(40) noalias %array, ptr align 2 dereferenceable(40) readonly %pred) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define void @loop_contains_store_requiring_alias_check(ptr dereferenceable(40) %array, ptr align 2 dereferenceable(40) %pred) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define void @loop_contains_store_decrementing_iv(ptr dereferenceable(40) noalias %array, ptr align 2 dereferenceable(40) readonly %pred) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 19, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:
  %iv.next = sub nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 0
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define void @loop_contains_store_condition_load_requires_gather(ptr dereferenceable(40) noalias %array, ptr align 2 dereferenceable(512) readonly %pred, ptr align 1 dereferenceable(20) readonly %offsets) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %offset.addr = getelementptr inbounds nuw i8, ptr %offsets, i64 %iv
  %offset = load i8, ptr %offset.addr, align 1
  %offset.zext = zext i8 %offset to i64
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %offset.zext
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define void @loop_contains_store_uncounted_exit_is_a_switch(ptr dereferenceable(40) noalias %array, ptr align 2 dereferenceable(40) readonly %pred) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  switch i16 %ee.val, label %for.inc [ i16 500, label %exit ]

for.inc:
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define void @loop_contains_store_uncounted_exit_is_not_guaranteed_to_execute(ptr dereferenceable(40) noalias %array, ptr align 2 dereferenceable(40) readonly %pred) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %rem = urem i64 %iv, 5
  %skip.ee.cmp = icmp eq i64 %rem, 0
  br i1 %skip.ee.cmp, label %for.inc, label %ee.block

ee.block:
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define void @histogram_with_uncountable_exit(ptr noalias %buckets, ptr readonly %indices, ptr align 2 dereferenceable(40) readonly %pred) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %gep.indices = getelementptr inbounds i32, ptr %indices, i64 %iv
  %l.idx = load i32, ptr %gep.indices, align 4
  %idxprom1 = zext i32 %l.idx to i64
  %gep.bucket = getelementptr inbounds i32, ptr %buckets, i64 %idxprom1
  %l.bucket = load i32, ptr %gep.bucket, align 4
  %inc = add nsw i32 %l.bucket, 1
  store i32 %inc, ptr %gep.bucket, align 4
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define void @loop_contains_store_between_two_early_exits(ptr dereferenceable(40) noalias %array, ptr align 2 dereferenceable(40) readonly %pred, ptr align 2 dereferenceable(40) readonly %pred2) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp slt i16 %ee.val, 250
  br i1 %ee.cond, label %exit, label %for.cont

for.cont:
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee2.addr = getelementptr inbounds nuw i16, ptr %pred2, i64 %iv
  %ee2.val = load i16, ptr %ee2.addr, align 2
  %ee2.cond = icmp sgt i16 %ee2.val, 500
  br i1 %ee2.cond, label %exit, label %for.inc

for.inc:
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define void @loop_contains_store_before_two_early_exits(ptr dereferenceable(40) noalias %array, ptr align 2 dereferenceable(40) readonly %pred, ptr align 2 dereferenceable(40) readonly %pred2) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp slt i16 %ee.val, 250
  br i1 %ee.cond, label %exit, label %for.cont

for.cont:
  %ee2.addr = getelementptr inbounds nuw i16, ptr %pred2, i64 %iv
  %ee2.val = load i16, ptr %ee2.addr, align 2
  %ee2.cond = icmp sgt i16 %ee2.val, 500
  br i1 %ee2.cond, label %exit, label %for.inc

for.inc:
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define void @one_uncountable_two_countable_exits(ptr dereferenceable(1024) noalias %array, ptr dereferenceable(1024) readonly %pred) {
entry:
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop.inc ], [ 3, %entry ]
  %ce.ee.cmp = icmp ne i64 %iv, 64
  br i1 %ce.ee.cmp, label %update, label %loop.end

update:
  %st.addr = getelementptr inbounds i8, ptr %array, i64 %iv
  %data = load i8, ptr %st.addr, align 1
  %inc = add nsw i8 %data, 1
  store i8 %inc, ptr %st.addr, align 1
  %ee.addr = getelementptr inbounds i8, ptr %pred, i64 %iv
  %ee.val = load i8, ptr %ee.addr, align 1
  %ee.cond = icmp eq i8 %ee.val, 37
  br i1 %ee.cond, label %loop.end, label %loop.inc

loop.inc:
  %iv.next = add i64 %iv, 1
  %ce.latch.cmp = icmp ne i64 %iv.next, 128
  br i1 %ce.latch.cmp, label %loop, label %loop.end

loop.end:
  ret void
}

define i16 @uncountable_exit_with_reduction(ptr dereferenceable(40) noalias %array, ptr align 2 dereferenceable(40) readonly %pred) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %rdx = phi i16 [ 0, %entry ], [ %rdx.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:
  %rdx.next = add i16 %rdx, %data
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:
  %res = phi i16 [ %rdx, %for.body ], [ %rdx.next, %for.inc ]
  ret i16 %res
}

define void @uncountable_exit_with_constant_nonunit_stride(ptr dereferenceable(4000) noalias %array, ptr align 2 dereferenceable(4000) readonly %pred) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:
  %iv.next = add nuw nsw i64 %iv, 20
  %counted.cond = icmp slt i64 %iv.next, 2001
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define void @uncountable_exit_with_invariant_but_unknown_stride(ptr dereferenceable(4000) noalias %array, ptr align 2 dereferenceable(4000) readonly %pred, i64 %stride) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:
  %iv.next = add nuw nsw i64 %iv, %stride
  %counted.cond = icmp slt i64 %iv.next, 2001
  br i1 %counted.cond, label %exit, label %for.body

exit:
  ret void
}

define i32 @uncountable_exit_with_separate_exit_block(ptr dereferenceable(40) noalias %array, ptr align 2 dereferenceable(40) readonly %pred) {
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit.uncountable, label %for.inc

for.inc:
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit.countable, label %for.body

exit.countable:
  ret i32 0

exit.uncountable:
  ret i32 1
}

declare i64 @get_an_unknown_offset();

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpwodxyzby.ll'
source_filename = "/tmp/tmpwodxyzby.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i64 @loop_contains_store(ptr dereferenceable(1024) %p1, ptr noalias %dest) #0 {
entry:
  br label %loop

loop:                                             ; preds = %loop.inc, %entry
  %index = phi i64 [ %index.next, %loop.inc ], [ 3, %entry ]
  %arrayidx = getelementptr inbounds i32, ptr %p1, i64 %index
  %ld1 = load i32, ptr %arrayidx, align 1
  %arrayidx2 = getelementptr inbounds i32, ptr %dest, i64 %index
  store i32 %ld1, ptr %arrayidx2, align 4
  %cmp = icmp eq i32 %ld1, 1
  br i1 %cmp, label %loop.inc, label %loop.end

loop.inc:                                         ; preds = %loop
  %index.next = add i64 %index, 1
  %exitcond = icmp ne i64 %index.next, 67
  br i1 %exitcond, label %loop, label %loop.end

loop.end:                                         ; preds = %loop.inc, %loop
  %retval = phi i64 [ %index, %loop ], [ 67, %loop.inc ]
  ret i64 %retval
}

define void @loop_contains_store_condition_load_has_single_user(ptr noalias dereferenceable(40) %array, ptr readonly align 2 dereferenceable(40) %pred) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %for.body
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.body
  ret void
}

define void @loop_contains_store_fcmp_condition(ptr noalias dereferenceable(40) %array, ptr readonly align 2 dereferenceable(40) %pred) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw half, ptr %pred, i64 %iv
  %ee.val = load half, ptr %ee.addr, align 2
  %ee.cond = fcmp ugt half %ee.val, 5.000000e+02
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %for.body
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.body
  ret void
}

define void @loop_contains_store_safe_dependency(ptr noalias dereferenceable(40) %array, ptr align 2 dereferenceable(96) %pred) #0 {
entry:
  %pred.plus.8 = getelementptr inbounds nuw i16, ptr %pred, i64 8
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred.plus.8, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  %some.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  store i16 42, ptr %some.addr, align 2
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %for.body
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.body
  ret void
}

define void @loop_contains_store_unsafe_dependency(ptr noalias dereferenceable(40) %array, ptr align 2 dereferenceable(80) %pred) #0 {
entry:
  %unknown.offset = call i64 @get_an_unknown_offset()
  %unknown.cmp = icmp ult i64 %unknown.offset, 20
  %clamped.offset = select i1 %unknown.cmp, i64 %unknown.offset, i64 20
  %unknown.base = getelementptr i16, ptr %pred, i64 %clamped.offset
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %unknown.base, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  %some.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  store i16 42, ptr %some.addr, align 2
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %for.body
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.body
  ret void
}

define void @loop_contains_store_assumed_bounds(ptr noalias %array, ptr readonly %pred, i64 %n) #0 {
entry:
  %n_bytes = mul nuw nsw i64 %n, 2
  call void @llvm.assume(i1 true) [ "align"(ptr %pred, i64 2), "dereferenceable"(ptr %pred, i64 %n_bytes) ]
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %for.body
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, %n
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.body
  ret void
}

define void @loop_contains_store_to_pointer_with_no_deref_info(ptr readonly align 2 dereferenceable(40) %load.array, ptr noalias align 2 %array, ptr readonly align 2 dereferenceable(40) %pred) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %ld.addr = getelementptr inbounds nuw i16, ptr %load.array, i64 %iv
  %data = load i16, ptr %ld.addr, align 2
  %inc = add nsw i16 %data, 1
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %for.body
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.body
  ret void
}

define void @loop_contains_store_unknown_bounds(ptr noalias align 2 dereferenceable(100) %array, ptr readonly align 2 dereferenceable(100) %pred, i64 %n) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %for.body
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, %n
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.body
  ret void
}

define void @loop_contains_store_volatile(ptr noalias dereferenceable(40) %array, ptr readonly align 2 dereferenceable(40) %pred) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store volatile i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %for.body
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.body
  ret void
}

define void @loop_contains_store_in_latch_block(ptr noalias dereferenceable(40) %array, ptr readonly align 2 dereferenceable(40) %pred) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %for.body
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.body
  ret void
}

define void @loop_contains_store_requiring_alias_check(ptr dereferenceable(40) %array, ptr align 2 dereferenceable(40) %pred) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %for.body
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.body
  ret void
}

define void @loop_contains_store_decrementing_iv(ptr noalias dereferenceable(40) %array, ptr readonly align 2 dereferenceable(40) %pred) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 19, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %for.body
  %iv.next = sub nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 0
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.body
  ret void
}

define void @loop_contains_store_condition_load_requires_gather(ptr noalias dereferenceable(40) %array, ptr readonly align 2 dereferenceable(512) %pred, ptr readonly align 1 dereferenceable(20) %offsets) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %offset.addr = getelementptr inbounds nuw i8, ptr %offsets, i64 %iv
  %offset = load i8, ptr %offset.addr, align 1
  %offset.zext = zext i8 %offset to i64
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %offset.zext
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %for.body
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.body
  ret void
}

define void @loop_contains_store_uncounted_exit_is_a_switch(ptr noalias dereferenceable(40) %array, ptr readonly align 2 dereferenceable(40) %pred) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  switch i16 %ee.val, label %for.inc [
    i16 500, label %exit
  ]

for.inc:                                          ; preds = %for.body
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.body
  ret void
}

define void @loop_contains_store_uncounted_exit_is_not_guaranteed_to_execute(ptr noalias dereferenceable(40) %array, ptr readonly align 2 dereferenceable(40) %pred) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %rem = urem i64 %iv, 5
  %skip.ee.cmp = icmp eq i64 %rem, 0
  br i1 %skip.ee.cmp, label %for.inc, label %ee.block

ee.block:                                         ; preds = %for.body
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %ee.block, %for.body
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %ee.block
  ret void
}

define void @histogram_with_uncountable_exit(ptr noalias %buckets, ptr readonly %indices, ptr readonly align 2 dereferenceable(40) %pred) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %gep.indices = getelementptr inbounds i32, ptr %indices, i64 %iv
  %l.idx = load i32, ptr %gep.indices, align 4
  %idxprom1 = zext i32 %l.idx to i64
  %gep.bucket = getelementptr inbounds i32, ptr %buckets, i64 %idxprom1
  %l.bucket = load i32, ptr %gep.bucket, align 4
  %inc = add nsw i32 %l.bucket, 1
  store i32 %inc, ptr %gep.bucket, align 4
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %for.body
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.body
  ret void
}

define void @loop_contains_store_between_two_early_exits(ptr noalias dereferenceable(40) %array, ptr readonly align 2 dereferenceable(40) %pred, ptr readonly align 2 dereferenceable(40) %pred2) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp slt i16 %ee.val, 250
  br i1 %ee.cond, label %exit, label %for.cont

for.cont:                                         ; preds = %for.body
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee2.addr = getelementptr inbounds nuw i16, ptr %pred2, i64 %iv
  %ee2.val = load i16, ptr %ee2.addr, align 2
  %ee2.cond = icmp sgt i16 %ee2.val, 500
  br i1 %ee2.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %for.cont
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.cont, %for.body
  ret void
}

define void @loop_contains_store_before_two_early_exits(ptr noalias dereferenceable(40) %array, ptr readonly align 2 dereferenceable(40) %pred, ptr readonly align 2 dereferenceable(40) %pred2) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp slt i16 %ee.val, 250
  br i1 %ee.cond, label %exit, label %for.cont

for.cont:                                         ; preds = %for.body
  %ee2.addr = getelementptr inbounds nuw i16, ptr %pred2, i64 %iv
  %ee2.val = load i16, ptr %ee2.addr, align 2
  %ee2.cond = icmp sgt i16 %ee2.val, 500
  br i1 %ee2.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %for.cont
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.cont, %for.body
  ret void
}

define void @one_uncountable_two_countable_exits(ptr noalias dereferenceable(1024) %array, ptr readonly dereferenceable(1024) %pred) #0 {
entry:
  br label %loop

loop:                                             ; preds = %loop.inc, %entry
  %iv = phi i64 [ %iv.next, %loop.inc ], [ 3, %entry ]
  %ce.ee.cmp = icmp ne i64 %iv, 64
  br i1 %ce.ee.cmp, label %update, label %loop.end

update:                                           ; preds = %loop
  %st.addr = getelementptr inbounds i8, ptr %array, i64 %iv
  %data = load i8, ptr %st.addr, align 1
  %inc = add nsw i8 %data, 1
  store i8 %inc, ptr %st.addr, align 1
  %ee.addr = getelementptr inbounds i8, ptr %pred, i64 %iv
  %ee.val = load i8, ptr %ee.addr, align 1
  %ee.cond = icmp eq i8 %ee.val, 37
  br i1 %ee.cond, label %loop.end, label %loop.inc

loop.inc:                                         ; preds = %update
  %iv.next = add i64 %iv, 1
  %ce.latch.cmp = icmp ne i64 %iv.next, 128
  br i1 %ce.latch.cmp, label %loop, label %loop.end

loop.end:                                         ; preds = %loop.inc, %update, %loop
  ret void
}

define i16 @uncountable_exit_with_reduction(ptr noalias dereferenceable(40) %array, ptr readonly align 2 dereferenceable(40) %pred) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %rdx = phi i16 [ 0, %entry ], [ %rdx.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %for.body
  %rdx.next = add i16 %rdx, %data
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.body
  %res = phi i16 [ %rdx, %for.body ], [ %rdx.next, %for.inc ]
  ret i16 %res
}

define void @uncountable_exit_with_constant_nonunit_stride(ptr noalias dereferenceable(4000) %array, ptr readonly align 2 dereferenceable(4000) %pred) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %for.body
  %iv.next = add nuw nsw i64 %iv, 20
  %counted.cond = icmp slt i64 %iv.next, 2001
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.body
  ret void
}

define void @uncountable_exit_with_invariant_but_unknown_stride(ptr noalias dereferenceable(4000) %array, ptr readonly align 2 dereferenceable(4000) %pred, i64 %stride) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit, label %for.inc

for.inc:                                          ; preds = %for.body
  %iv.next = add nuw nsw i64 %iv, %stride
  %counted.cond = icmp slt i64 %iv.next, 2001
  br i1 %counted.cond, label %exit, label %for.body

exit:                                             ; preds = %for.inc, %for.body
  ret void
}

define i32 @uncountable_exit_with_separate_exit_block(ptr noalias dereferenceable(40) %array, ptr readonly align 2 dereferenceable(40) %pred) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.inc ]
  %st.addr = getelementptr inbounds nuw i16, ptr %array, i64 %iv
  %data = load i16, ptr %st.addr, align 2
  %inc = add nsw i16 %data, 1
  store i16 %inc, ptr %st.addr, align 2
  %ee.addr = getelementptr inbounds nuw i16, ptr %pred, i64 %iv
  %ee.val = load i16, ptr %ee.addr, align 2
  %ee.cond = icmp sgt i16 %ee.val, 500
  br i1 %ee.cond, label %exit.uncountable, label %for.inc

for.inc:                                          ; preds = %for.body
  %iv.next = add nuw nsw i64 %iv, 1
  %counted.cond = icmp eq i64 %iv.next, 20
  br i1 %counted.cond, label %exit.countable, label %for.body

exit.countable:                                   ; preds = %for.inc
  ret i32 0

exit.uncountable:                                 ; preds = %for.body
  ret i32 1
}

declare i64 @get_an_unknown_offset() #0

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #1

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) "target-features"="+v" }
