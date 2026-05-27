; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/unsigned-node-trunc-with-signed-users.ll
; Variant: riscv64-unknown-linux_+v_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux -mattr=+v -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @test(ptr %p, i16 %load794) {
  %zext795 = zext i16 %load794 to i32
  %load798 = load i16, ptr %p, align 2
  %gep799 = getelementptr inbounds i8, ptr %p, i64 16
  %load800 = load i16, ptr %gep799, align 2
  %zext801 = zext i16 %load798 to i32
  %zext802 = zext i16 %load800 to i32
  %sub809 = sub nsw i32 %zext802, %zext801
  %add810 = add nsw i32 %sub809, 3329
  %mul811 = mul i32 %add810, %zext795
  %zext812 = zext i32 %mul811 to i64
  %mul813 = mul nuw nsw i64 %zext812, 5039
  %lshr814 = lshr i64 %mul813, 24
  %trunc815 = trunc nuw nsw i64 %lshr814 to i32
  %mul816 = mul i32 %trunc815, 62207
  %add817 = add i32 %mul816, %mul811
  %trunc818 = trunc i32 %add817 to i16
  %add819 = add i16 %trunc818, -3329
  %icmp820 = icmp slt i16 %add819, 0
  %select821 = select i1 %icmp820, i16 %trunc818, i16 0
  %call822 = call i16 @llvm.smax.i16(i16 %add819, i16 0)
  %or823 = or i16 %select821, %call822
  store i16 %or823, ptr %p, align 2
  %gep826 = getelementptr inbounds i8, ptr %p, i64 2
  %load827 = load i16, ptr %gep826, align 2
  %gep828 = getelementptr inbounds i8, ptr %p, i64 18
  %load829 = load i16, ptr %gep828, align 2
  %zext830 = zext i16 %load827 to i32
  %zext831 = zext i16 %load829 to i32
  %sub838 = sub nsw i32 %zext831, %zext830
  %add839 = add nsw i32 %sub838, 3329
  %mul840 = mul i32 %add839, %zext795
  %zext841 = zext i32 %mul840 to i64
  %mul842 = mul nuw nsw i64 %zext841, 5039
  %lshr843 = lshr i64 %mul842, 24
  %trunc844 = trunc nuw nsw i64 %lshr843 to i32
  %mul845 = mul i32 %trunc844, 62207
  %add846 = add i32 %mul845, %mul840
  %trunc847 = trunc i32 %add846 to i16
  %add848 = add i16 %trunc847, -3329
  %icmp849 = icmp slt i16 %add848, 0
  %select850 = select i1 %icmp849, i16 %trunc847, i16 0
  %call851 = call i16 @llvm.smax.i16(i16 %add848, i16 0)
  %or852 = or i16 %select850, %call851
  store i16 %or852, ptr %gep826, align 2
  ret void
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpf3tgs8kq.ll'
source_filename = "/tmp/tmpf3tgs8kq.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux"

define void @test(ptr %p, i16 %load794) #0 {
  %zext795 = zext i16 %load794 to i32
  %gep799 = getelementptr inbounds i8, ptr %p, i64 16
  %1 = load <2 x i16>, ptr %p, align 2
  %2 = load <2 x i16>, ptr %gep799, align 2
  %3 = zext <2 x i16> %1 to <2 x i32>
  %4 = zext <2 x i16> %2 to <2 x i32>
  %5 = sub nsw <2 x i32> %4, %3
  %6 = add nsw <2 x i32> %5, splat (i32 3329)
  %7 = insertelement <2 x i32> poison, i32 %zext795, i32 0
  %8 = shufflevector <2 x i32> %7, <2 x i32> poison, <2 x i32> zeroinitializer
  %9 = mul <2 x i32> %6, %8
  %10 = zext <2 x i32> %9 to <2 x i64>
  %11 = mul nuw nsw <2 x i64> %10, splat (i64 5039)
  %12 = lshr <2 x i64> %11, splat (i64 24)
  %13 = trunc <2 x i64> %12 to <2 x i32>
  %14 = mul <2 x i32> %13, splat (i32 62207)
  %15 = add <2 x i32> %14, %9
  %16 = trunc <2 x i32> %15 to <2 x i16>
  %17 = add <2 x i16> %16, splat (i16 -3329)
  %18 = icmp slt <2 x i16> %17, zeroinitializer
  %19 = select <2 x i1> %18, <2 x i16> %16, <2 x i16> zeroinitializer
  %20 = call <2 x i16> @llvm.smax.v2i16(<2 x i16> %17, <2 x i16> zeroinitializer)
  %21 = or <2 x i16> %19, %20
  store <2 x i16> %21, ptr %p, align 2
  ret void
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.smax.i16(i16, i16) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x i16> @llvm.smax.v2i16(<2 x i16>, <2 x i16>) #2

attributes #0 = { "target-features"="+v" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-features"="+v" }
attributes #2 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
