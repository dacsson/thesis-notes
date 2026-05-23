; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/AtomicExpand/RISCV/atomicrmw-fp.ll
; Variant: riscv32--_require<libcall-lowering-info>,atomic-expand
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv32-- -passes='require<libcall-lowering-info>,atomic-expand' -S
; Original: RUN: opt -S -mtriple=riscv32-- -passes='require<libcall-lowering-info>,atomic-expand' %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define float @test_atomicrmw_fadd_f32(ptr %ptr, float %value) {
  %res = atomicrmw fadd ptr %ptr, float %value seq_cst
  ret float %res
}

define float @test_atomicrmw_fsub_f32(ptr %ptr, float %value) {
  %res = atomicrmw fsub ptr %ptr, float %value seq_cst
  ret float %res
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpkxrzmtcp.ll'
source_filename = "/tmp/tmpkxrzmtcp.ll"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32-unknown-unknown"

define float @test_atomicrmw_fadd_f32(ptr %ptr, float %value) {
  %1 = alloca float, align 4
  %2 = call i32 @__atomic_load_4(ptr %ptr, i32 0)
  %3 = bitcast i32 %2 to float
  br label %atomicrmw.start

atomicrmw.start:                                  ; preds = %atomicrmw.start, %0
  %loaded = phi float [ %3, %0 ], [ %newloaded, %atomicrmw.start ]
  %new = fadd float %loaded, %value
  call void @llvm.lifetime.start.p0(ptr %1)
  store float %loaded, ptr %1, align 4
  %4 = bitcast float %new to i32
  %5 = call zeroext i1 @__atomic_compare_exchange_4(ptr %ptr, ptr %1, i32 %4, i32 5, i32 5)
  %6 = load float, ptr %1, align 4
  call void @llvm.lifetime.end.p0(ptr %1)
  %7 = insertvalue { float, i1 } poison, float %6, 0
  %8 = insertvalue { float, i1 } %7, i1 %5, 1
  %success = extractvalue { float, i1 } %8, 1
  %newloaded = extractvalue { float, i1 } %8, 0
  br i1 %success, label %atomicrmw.end, label %atomicrmw.start

atomicrmw.end:                                    ; preds = %atomicrmw.start
  ret float %newloaded
}

define float @test_atomicrmw_fsub_f32(ptr %ptr, float %value) {
  %1 = alloca float, align 4
  %2 = call i32 @__atomic_load_4(ptr %ptr, i32 0)
  %3 = bitcast i32 %2 to float
  br label %atomicrmw.start

atomicrmw.start:                                  ; preds = %atomicrmw.start, %0
  %loaded = phi float [ %3, %0 ], [ %newloaded, %atomicrmw.start ]
  %new = fsub float %loaded, %value
  call void @llvm.lifetime.start.p0(ptr %1)
  store float %loaded, ptr %1, align 4
  %4 = bitcast float %new to i32
  %5 = call zeroext i1 @__atomic_compare_exchange_4(ptr %ptr, ptr %1, i32 %4, i32 5, i32 5)
  %6 = load float, ptr %1, align 4
  call void @llvm.lifetime.end.p0(ptr %1)
  %7 = insertvalue { float, i1 } poison, float %6, 0
  %8 = insertvalue { float, i1 } %7, i1 %5, 1
  %success = extractvalue { float, i1 } %8, 1
  %newloaded = extractvalue { float, i1 } %8, 0
  br i1 %success, label %atomicrmw.end, label %atomicrmw.start

atomicrmw.end:                                    ; preds = %atomicrmw.start
  ret float %newloaded
}

declare i32 @__atomic_load_4(ptr, i32)

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #0

declare zeroext i1 @__atomic_compare_exchange_4(ptr, ptr, i32, i32, i32)

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
