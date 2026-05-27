; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/reordered-buildvector-scalars.ll
; Variant: riscv64-unknown-linux-gnu_slp-vectorizer_THRESH
; Command: /home/artjom/Tools/llvm-project/build/bin/opt --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mcpu=sifive-x280 -slp-threshold=-3 -S
; Original: RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux-gnu -mcpu=sifive-x280 < %s -slp-threshold=-3 | FileCheck %s --check-prefix=THRESH

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


%struct.ImageParameters = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, float, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, ptr, ptr, i32, ptr, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, [9 x [16 x [16 x i16]]], [5 x [16 x [16 x i16]]], [9 x [8 x [8 x i16]]], [2 x [4 x [16 x [16 x i16]]]], [16 x [16 x i16]], [16 x [16 x i32]], ptr, ptr, ptr, ptr, ptr, [1200 x %struct.syntaxelement], ptr, ptr, i32, i32, i32, i32, [4 x [4 x i32]], i32, i32, i32, i32, i32, double, i32, i32, i32, i32, ptr, ptr, ptr, ptr, [15 x i16], i32, i32, i32, i32, i32, i32, i32, i32, [6 x [15 x i32]], i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, [1 x i32], i32, i32, [2 x i32], i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, ptr, i32, i32, i32, i32, i32, double, i32, i32, i32, i32, i32, i32, i32, ptr, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, [2 x i32], i32, i32, i32 }
%struct.syntaxelement = type { i32, i32, i32, i32, i32, i32, i32, i32, ptr, ptr }

@images = external global %struct.ImageParameters

define fastcc i32 @test(i32 %0, i32 %add111.i.i, <4 x i32> %PredPel.i.sroa.86.72.vec.extract, <4 x i32> %1) {
entry:
  %LoopArray.sroa.24.0.i.i3 = ashr i32 %0, 1
  %shr143.5.i.i9 = ashr i32 %0, 1
  %add1392.i = add i32 %0, 1
  %PredPel.i.sroa.86.80.vec.extract59312 = extractelement <4 x i32> %PredPel.i.sroa.86.72.vec.extract, i64 0
  %mul1445.i = shl i32 %0, 1
  %PredPel.i.sroa.7.4.vec.extract446 = extractelement <4 x i32> %1, i64 0
  %add1571.i = add i32 %PredPel.i.sroa.7.4.vec.extract446, 1
  %shr1572.i = lshr i32 %add1571.i, 1
  %conv1573.i = trunc i32 %shr1572.i to i16
  %add2136.i = or i32 %LoopArray.sroa.24.0.i.i3, %0
  %shr2137.i = lshr i32 %add2136.i, 1
  %conv2138.i = trunc i32 %shr2137.i to i16
  %add2157.i = add i32 %PredPel.i.sroa.86.80.vec.extract59312, 1
  %shr2158.i = lshr i32 %add2157.i, 1
  %conv2159.i = trunc i32 %shr2158.i to i16
  %add2174.i = add i32 %mul1445.i, 2
  %shr2175.i = lshr i32 %add2174.i, 2
  %conv2176.i = trunc i32 %shr2175.i to i16
  %add2190.i = or i32 %add1392.i, 1
  %add2191.i = add i32 %add2190.i, %0
  %conv2193.i = trunc i32 %add2191.i to i16
  %add2203.i = or i32 %0, 1
  %add2204.i = add i32 %add2203.i, %0
  %conv2206.i = trunc i32 %add2204.i to i16
  %add2214.i = add i32 %LoopArray.sroa.24.0.i.i3, 1
  %shr2215.i = lshr i32 %add2214.i, 1
  %conv2216.i = trunc i32 %shr2215.i to i16
  store i16 %conv2216.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8180), align 4
  %add2235.i16 = or i32 %0, 1
  %add2236.i = add i32 %add2235.i16, 1
  %shr2237.i = lshr i32 %add2236.i, 1
  %conv2238.i = trunc i32 %shr2237.i to i16
  store i16 %conv2238.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8196), align 4
  store i16 %conv2238.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8176), align 8
  %add2258.i = or i32 %add111.i.i, %0
  %shr2259.i = lshr i32 %add2258.i, 1
  %conv2260.i = trunc i32 %shr2259.i to i16
  store i16 %conv2260.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8212), align 4
  store i16 %conv2260.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8192), align 8
  store i16 %conv2260.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8172), align 4
  %add2280.i = add i32 %add111.i.i, 1
  %shr2281.i = lshr i32 %add2280.i, 1
  %conv2282.i = trunc i32 %shr2281.i to i16
  store i16 %conv2282.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8228), align 4
  store i16 %conv2282.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8208), align 8
  store i16 %conv2282.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8188), align 4
  %add2302.i = add i32 %0, 1
  %shr2303.i = lshr i32 %add2302.i, 1
  %conv2304.i = trunc i32 %shr2303.i to i16
  store i16 %conv2304.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8224), align 8
  store i16 %conv2304.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8204), align 4
  store i16 %conv2304.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8184), align 8
  %add2323.i = add i32 %0, 1
  %add2324.i = or i32 %add2323.i, %0
  %shr2325.i = lshr i32 %add2324.i, 1
  %conv2326.i = trunc i32 %shr2325.i to i16
  store i16 %conv2326.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8220), align 4
  store i16 %conv2326.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8200), align 8
  %add2342.i = add i32 %shr143.5.i.i9, 1
  %shr2343.i = lshr i32 %add2342.i, 1
  %conv2344.i = trunc i32 %shr2343.i to i16
  store i16 %conv2344.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8216), align 8
  %add2355.i = or i32 %shr143.5.i.i9, 1
  %add2356.i = add i32 %add2355.i, %0
  %conv2358.i = trunc i32 %add2356.i to i16
  store i16 %conv2358.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8232), align 8
  store i16 %conv1573.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8182), align 2
  %add2393.i = or i32 %LoopArray.sroa.24.0.i.i3, 1
  %add2394.i = add i32 %add2393.i, %0
  %conv2396.i = trunc i32 %add2394.i to i16
  store i16 %conv2396.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8198), align 2
  store i16 %conv2396.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8178), align 2
  store i16 %conv2138.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8214), align 2
  store i16 %conv2138.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8194), align 2
  store i16 %conv2138.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8174), align 2
  store i16 %conv2159.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8230), align 2
  store i16 %conv2159.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8210), align 2
  store i16 %conv2159.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8190), align 2
  store i16 %conv2159.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8170), align 2
  store i16 %conv2176.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8226), align 2
  store i16 %conv2176.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8206), align 2
  store i16 %conv2176.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8186), align 2
  store i16 %conv2193.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8222), align 2
  store i16 %conv2193.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8202), align 2
  store i16 %conv2206.i, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8218), align 2
  ret i32 0
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmp42jm466l.ll'
source_filename = "/tmp/tmp42jm466l.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

%struct.ImageParameters = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, float, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, ptr, ptr, i32, ptr, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, [9 x [16 x [16 x i16]]], [5 x [16 x [16 x i16]]], [9 x [8 x [8 x i16]]], [2 x [4 x [16 x [16 x i16]]]], [16 x [16 x i16]], [16 x [16 x i32]], ptr, ptr, ptr, ptr, ptr, [1200 x %struct.syntaxelement], ptr, ptr, i32, i32, i32, i32, [4 x [4 x i32]], i32, i32, i32, i32, i32, double, i32, i32, i32, i32, ptr, ptr, ptr, ptr, [15 x i16], i32, i32, i32, i32, i32, i32, i32, i32, [6 x [15 x i32]], i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, [1 x i32], i32, i32, [2 x i32], i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, ptr, i32, i32, i32, i32, i32, double, i32, i32, i32, i32, i32, i32, i32, ptr, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, [2 x i32], i32, i32, i32 }
%struct.syntaxelement = type { i32, i32, i32, i32, i32, i32, i32, i32, ptr, ptr }

@images = external global %struct.ImageParameters

define fastcc i32 @test(i32 %0, i32 %add111.i.i, <4 x i32> %PredPel.i.sroa.86.72.vec.extract, <4 x i32> %1) #0 {
entry:
  %LoopArray.sroa.24.0.i.i3 = ashr i32 %0, 1
  %shr143.5.i.i9 = ashr i32 %0, 1
  %add1392.i = add i32 %0, 1
  %mul1445.i = shl i32 %0, 1
  %add2235.i16 = or i32 %0, 1
  %add2323.i = add i32 %0, 1
  %2 = insertelement <3 x i32> poison, i32 %add111.i.i, i32 0
  %3 = insertelement <3 x i32> %2, i32 %LoopArray.sroa.24.0.i.i3, i32 1
  %4 = insertelement <3 x i32> %3, i32 %add2323.i, i32 2
  %5 = insertelement <3 x i32> poison, i32 %0, i32 0
  %6 = shufflevector <3 x i32> %5, <3 x i32> poison, <3 x i32> zeroinitializer
  %7 = or <3 x i32> %4, %6
  %8 = shufflevector <4 x i32> %PredPel.i.sroa.86.72.vec.extract, <4 x i32> %1, <8 x i32> <i32 0, i32 poison, i32 poison, i32 4, i32 poison, i32 poison, i32 poison, i32 poison>
  %9 = shufflevector <3 x i32> %4, <3 x i32> poison, <8 x i32> <i32 poison, i32 poison, i32 1, i32 poison, i32 poison, i32 poison, i32 0, i32 poison>
  %10 = shufflevector <8 x i32> %8, <8 x i32> %9, <8 x i32> <i32 0, i32 poison, i32 10, i32 3, i32 poison, i32 poison, i32 14, i32 poison>
  %11 = insertelement <8 x i32> %10, i32 %0, i32 4
  %12 = insertelement <8 x i32> %11, i32 %add2235.i16, i32 1
  %13 = insertelement <8 x i32> %12, i32 %mul1445.i, i32 5
  %14 = insertelement <8 x i32> %13, i32 %shr143.5.i.i9, i32 7
  %15 = add <8 x i32> %14, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 2, i32 1, i32 1>
  %16 = shufflevector <8 x i32> %15, <8 x i32> poison, <11 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison>
  %17 = shufflevector <3 x i32> %7, <3 x i32> poison, <11 x i32> <i32 0, i32 1, i32 2, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %18 = shufflevector <11 x i32> %16, <11 x i32> %17, <11 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 11, i32 12, i32 13>
  %19 = lshr <11 x i32> %18, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 2, i32 1, i32 1, i32 1, i32 1, i32 1>
  %20 = shufflevector <8 x i32> %14, <8 x i32> poison, <4 x i32> <i32 2, i32 poison, i32 4, i32 7>
  %21 = insertelement <4 x i32> %20, i32 %add1392.i, i32 1
  %22 = or <4 x i32> %21, splat (i32 1)
  %23 = shufflevector <8 x i32> %14, <8 x i32> poison, <4 x i32> <i32 4, i32 4, i32 4, i32 4>
  %24 = add <4 x i32> %22, %23
  %25 = shufflevector <11 x i32> %19, <11 x i32> poison, <15 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 poison, i32 poison, i32 poison, i32 poison>
  %26 = shufflevector <4 x i32> %24, <4 x i32> poison, <15 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
  %27 = shufflevector <15 x i32> %25, <15 x i32> %26, <15 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 15, i32 16, i32 17, i32 18>
  %28 = trunc <15 x i32> %27 to <15 x i16>
  %29 = shufflevector <15 x i16> %28, <15 x i16> poison, <32 x i32> <i32 0, i32 8, i32 9, i32 1, i32 11, i32 2, i32 3, i32 4, i32 5, i32 6, i32 0, i32 8, i32 9, i32 1, i32 11, i32 10, i32 12, i32 4, i32 5, i32 6, i32 0, i32 8, i32 9, i32 7, i32 13, i32 10, i32 12, i32 4, i32 5, i32 6, i32 0, i32 14>
  store <32 x i16> %29, ptr getelementptr inbounds nuw (i8, ptr @images, i64 8170), align 2
  ret i32 0
}

attributes #0 = { "target-cpu"="sifive-x280" }
