; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/revec.ll
; Variant: riscv64_slp-vectorizer
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64 -mcpu=sifive-x280 -passes=slp-vectorizer -slp-revec -slp-max-reg-size=1024 -slp-threshold=-100 -S
; Original: RUN: opt -mtriple=riscv64 -mcpu=sifive-x280 -passes=slp-vectorizer -S -slp-revec -slp-max-reg-size=1024 -slp-threshold=-100 %s | FileCheck --check-prefixes=CHECK,POWEROF2 %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define i32 @test() {
entry:
  %getelementptr0 = getelementptr i8, ptr null, i64 64036
  %getelementptr1 = getelementptr i8, ptr null, i64 64064
  br label %if.end.i87

if.end.i87:                                       ; preds = %entry
  %0 = load <2 x i32>, ptr %getelementptr0, align 4
  %1 = load <2 x i32>, ptr %getelementptr1, align 8
  switch i32 0, label %sw.bb509.i [
  i32 1, label %sw.bb509.i
  i32 0, label %if.then458.i
  ]

if.then458.i:                                     ; preds = %if.end.i87
  br label %sw.bb509.i

sw.bb509.i:                                       ; preds = %if.then458.i, %if.end.i87, %if.end.i87
  %4 = phi <2 x i32> [ %0, %if.then458.i ], [ %0, %if.end.i87 ], [ %0, %if.end.i87 ]
  %5 = phi <2 x i32> [ %1, %if.then458.i ], [ zeroinitializer, %if.end.i87 ], [ zeroinitializer, %if.end.i87 ]
  ret i32 0
}

define void @test2() {
entry:
  %0 = getelementptr i8, ptr null, i64 132
  %1 = getelementptr i8, ptr null, i64 164
  %2 = getelementptr i8, ptr null, i64 200
  %3 = getelementptr i8, ptr null, i64 300
  %4 = load <8 x float>, ptr %0, align 4
  %5 = load <8 x float>, ptr %1, align 4
  %6 = load <8 x float>, ptr %2, align 4
  %7 = load <8 x float>, ptr %3, align 4
  %8 = fpext <8 x float> %4 to <8 x double>
  %9 = fpext <8 x float> %5 to <8 x double>
  %10 = fpext <8 x float> %6 to <8 x double>
  %11 = fpext <8 x float> %7 to <8 x double>
  %12 = fadd <8 x double> zeroinitializer, %8
  %13 = fadd <8 x double> zeroinitializer, %9
  %14 = fadd <8 x double> zeroinitializer, %10
  %15 = fadd <8 x double> zeroinitializer, %11
  %16 = fptrunc <8 x double> %12 to <8 x float>
  %17 = fptrunc <8 x double> %13 to <8 x float>
  %18 = fptrunc <8 x double> %14 to <8 x float>
  %19 = fptrunc <8 x double> %15 to <8 x float>
  %20 = fcmp ogt <8 x float> zeroinitializer, %16
  %21 = fcmp ogt <8 x float> zeroinitializer, %17
  %22 = fcmp ogt <8 x float> zeroinitializer, %18
  %23 = fcmp ogt <8 x float> zeroinitializer, %19
  ret void
}

define void @test3(float %0) {
entry:
  br label %for.body.lr.ph

for.body.lr.ph:
  br i1 false, label %for.cond.cleanup, label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %for.body.lr.ph
  %1 = phi <2 x float> [ zeroinitializer, %for.body.lr.ph ], [ %5, %for.body ]
  %2 = phi <2 x float> [ zeroinitializer, %for.body.lr.ph ], [ %6, %for.body ]
  ret void

for.body:
  %3 = load <2 x float>, ptr null, align 4
  %4 = fcmp olt <2 x float> zeroinitializer, %3
  %5 = select <2 x i1> <i1 true, i1 true>, <2 x float> %3, <2 x float> zeroinitializer
  %6 = select <2 x i1> %4, <2 x float> %3, <2 x float> zeroinitializer
  br label %for.cond.cleanup
}

define ptr @test4() {
  %1 = fadd <8 x float> zeroinitializer, zeroinitializer
  %2 = extractelement <8 x float> %1, i64 0
  %3 = extractelement <8 x float> %1, i64 1
  %4 = extractelement <8 x float> %1, i64 2
  %5 = extractelement <8 x float> %1, i64 4
  %6 = extractelement <8 x float> %1, i64 5
  %7 = extractelement <8 x float> %1, i64 6
  br label %9

8:
  br label %9

9:
  %10 = phi float [ 0.000000e+00, %8 ], [ %7, %0 ]
  %11 = phi float [ 0.000000e+00, %8 ], [ %6, %0 ]
  %12 = phi float [ 0.000000e+00, %8 ], [ %5, %0 ]
  %13 = phi float [ 0.000000e+00, %8 ], [ %4, %0 ]
  %14 = phi float [ 0.000000e+00, %8 ], [ %3, %0 ]
  %15 = phi float [ 0.000000e+00, %8 ], [ %2, %0 ]
  br label %16

16:
  %17 = fmul float %14, 0.000000e+00
  %18 = fmul float 0.000000e+00, %11
  %19 = fmul float 0.000000e+00, %15
  %20 = fmul float %12, 0.000000e+00
  %21 = fadd reassoc nsz float %17, %19
  %22 = fadd reassoc nsz float %18, %20
  %23 = fmul float %13, 0.000000e+00
  %24 = fmul float %10, 0.000000e+00
  %25 = fadd reassoc nsz float %21, %23
  %26 = fadd reassoc nsz float %22, %24
  %27 = tail call float @llvm.sqrt.f32(float %25)
  %28 = tail call float @llvm.sqrt.f32(float %26)
  ret ptr null
}

define i32 @test5() {
entry:
  %div0 = fdiv <2 x double> zeroinitializer, zeroinitializer
  %div1 = fdiv <2 x double> zeroinitializer, zeroinitializer
  %add0 = fadd <2 x double> zeroinitializer, %div0
  %add1 = fadd <2 x double> zeroinitializer, zeroinitializer
  %add2 = fadd <2 x double> %div1, zeroinitializer
  %add3 = fadd <2 x double> zeroinitializer, zeroinitializer
  br label %for.end47

for.end47:                                        ; preds = %entry
  %add0.lcssa = phi <2 x double> [ %add0, %entry ]
  %add1.lcssa = phi <2 x double> [ %add1, %entry ]
  %add2.lcssa = phi <2 x double> [ %add2, %entry ]
  %add3.lcssa = phi <2 x double> [ %add3, %entry ]
  ret i32 0
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpbx3ait1m.ll'
source_filename = "/tmp/tmpbx3ait1m.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define i32 @test() #0 {
entry:
  br label %if.end.i87

if.end.i87:                                       ; preds = %entry
  %0 = call <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr> align 4 getelementptr (i32, <4 x ptr> <ptr inttoptr (i64 64036 to ptr), ptr inttoptr (i64 64036 to ptr), ptr inttoptr (i64 64064 to ptr), ptr inttoptr (i64 64064 to ptr)>, <4 x i64> <i64 0, i64 1, i64 0, i64 1>), <4 x i1> splat (i1 true), <4 x i32> poison)
  %1 = shufflevector <4 x i32> %0, <4 x i32> <i32 undef, i32 undef, i32 0, i32 0>, <4 x i32> <i32 0, i32 1, i32 6, i32 7>
  switch i32 0, label %sw.bb509.i [
    i32 1, label %sw.bb509.i
    i32 0, label %if.then458.i
  ]

if.then458.i:                                     ; preds = %if.end.i87
  br label %sw.bb509.i

sw.bb509.i:                                       ; preds = %if.then458.i, %if.end.i87, %if.end.i87
  %2 = phi <4 x i32> [ %0, %if.then458.i ], [ %1, %if.end.i87 ], [ %1, %if.end.i87 ]
  ret i32 0
}

define void @test2() #0 {
entry:
  %0 = getelementptr i8, ptr null, i64 132
  %1 = getelementptr i8, ptr null, i64 200
  %2 = getelementptr i8, ptr null, i64 300
  %3 = load <8 x float>, ptr %1, align 4
  %4 = load <8 x float>, ptr %2, align 4
  %5 = load <16 x float>, ptr %0, align 4
  %6 = shufflevector <8 x float> %4, <8 x float> poison, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %7 = shufflevector <8 x float> %3, <8 x float> poison, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %8 = shufflevector <32 x float> %6, <32 x float> %7, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  %9 = shufflevector <16 x float> %5, <16 x float> poison, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %10 = shufflevector <32 x float> %8, <32 x float> %9, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47>
  %11 = fpext <32 x float> %10 to <32 x double>
  %12 = fadd <32 x double> zeroinitializer, %11
  %13 = fptrunc <32 x double> %12 to <32 x float>
  %14 = fcmp ogt <32 x float> zeroinitializer, %13
  ret void
}

define void @test3(float %0) #0 {
entry:
  br label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %entry
  br i1 false, label %for.cond.cleanup, label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %for.body.lr.ph
  %1 = phi <4 x float> [ zeroinitializer, %for.body.lr.ph ], [ %7, %for.body ]
  ret void

for.body:                                         ; preds = %for.body.lr.ph
  %2 = load <2 x float>, ptr null, align 4
  %3 = fcmp olt <2 x float> zeroinitializer, %2
  %4 = shufflevector <2 x i1> %3, <2 x i1> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
  %5 = shufflevector <4 x i1> <i1 true, i1 true, i1 undef, i1 undef>, <4 x i1> %4, <4 x i32> <i32 0, i32 1, i32 4, i32 5>
  %6 = shufflevector <2 x float> %2, <2 x float> poison, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  %7 = select <4 x i1> %5, <4 x float> %6, <4 x float> zeroinitializer
  br label %for.cond.cleanup
}

define ptr @test4() #0 {
  %1 = fadd <8 x float> zeroinitializer, zeroinitializer
  %2 = shufflevector <8 x float> %1, <8 x float> poison, <2 x i32> <i32 1, i32 2>
  %3 = shufflevector <8 x float> %1, <8 x float> poison, <2 x i32> <i32 5, i32 6>
  %4 = shufflevector <8 x float> %1, <8 x float> poison, <2 x i32> <i32 0, i32 4>
  %5 = shufflevector <2 x float> %2, <2 x float> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
  %6 = shufflevector <2 x float> %3, <2 x float> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
  %7 = shufflevector <4 x float> %5, <4 x float> %6, <4 x i32> <i32 0, i32 1, i32 4, i32 5>
  br label %9

8:                                                ; No predecessors!
  br label %9

9:                                                ; preds = %8, %0
  %10 = phi <2 x float> [ poison, %8 ], [ %4, %0 ]
  %11 = phi <4 x float> [ poison, %8 ], [ %7, %0 ]
  br label %12

12:                                               ; preds = %9
  %13 = shufflevector <4 x float> %11, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  %14 = fmul <2 x float> %13, zeroinitializer
  %15 = shufflevector <4 x float> %11, <4 x float> poison, <2 x i32> <i32 2, i32 3>
  %16 = fmul <2 x float> zeroinitializer, %15
  %17 = extractelement <2 x float> %10, i32 0
  %18 = fmul float 0.000000e+00, %17
  %19 = extractelement <2 x float> %10, i32 1
  %20 = fmul float %19, 0.000000e+00
  %21 = extractelement <2 x float> %14, i32 0
  %22 = fadd reassoc nsz float %21, %18
  %23 = extractelement <2 x float> %16, i32 0
  %24 = fadd reassoc nsz float %23, %20
  %25 = extractelement <2 x float> %14, i32 1
  %26 = fadd reassoc nsz float %22, %25
  %27 = extractelement <2 x float> %16, i32 1
  %28 = fadd reassoc nsz float %24, %27
  %29 = tail call float @llvm.sqrt.f32(float %26)
  %30 = tail call float @llvm.sqrt.f32(float %28)
  ret ptr null
}

define i32 @test5() #0 {
entry:
  br label %for.end47

for.end47:                                        ; preds = %entry
  %0 = phi <8 x double> [ <double +qnan, double +qnan, double 0.000000e+00, double 0.000000e+00, double +qnan, double +qnan, double 0.000000e+00, double 0.000000e+00>, %entry ]
  ret i32 0
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.sqrt.f32(float) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <4 x i32> @llvm.masked.gather.v4i32.v4p0(<4 x ptr>, <4 x i1>, <4 x i32>) #2

attributes #0 = { "target-cpu"="sifive-x280" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) "target-cpu"="sifive-x280" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(read) }
