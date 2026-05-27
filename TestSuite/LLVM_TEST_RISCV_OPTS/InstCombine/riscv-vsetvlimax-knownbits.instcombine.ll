; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/InstCombine/RISCV/riscv-vsetvlimax-knownbits.ll
; Variant: instcombine
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=instcombine -S
; Original: RUN: opt < %s -passes=instcombine -S | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


declare i32 @llvm.riscv.vsetvlimax.i32(i32, i32)
declare i64 @llvm.riscv.vsetvlimax.i64(i64, i64)

define i32 @vsetvlimax_i32() nounwind #0 {
entry:
  %0 = call i32 @llvm.riscv.vsetvlimax.i32(i32 1, i32 1)
  %1 = and i32 %0, 2147483647
  ret i32 %1
}

define i64 @vsetvlimax_sext_i64() nounwind #0 {
entry:
  %0 = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 1)
  %1 = trunc i64 %0 to i32
  %2 = sext i32 %1 to i64
  ret i64 %2
}

define i64 @vsetvlimax_zext_i64() nounwind #0 {
entry:
  %0 = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 1)
  %1 = trunc i64 %0 to i32
  %2 = zext i32 %1 to i64
  ret i64 %2
}

define signext i32 @vsetvlmax_sext() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 1)
  %b = trunc i64 %a to i32
  ret i32 %b
}

define zeroext i32 @vsetvlmax_zext() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 1)
  %b = trunc i64 %a to i32
  ret i32 %b
}

define i32 @vsetvlimax_and17_i32() nounwind #0 {
entry:
  %0 = call i32 @llvm.riscv.vsetvlimax.i32(i32 1, i32 1)
  %1 = and i32 %0, 131071
  ret i32 %1
}

define i64 @vsetvlimax_and17_i64() nounwind #0 {
entry:
  %0 = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 1)
  %1 = and i64 %0, 131071
  ret i64 %1
}

define i64 @vsetvlmax_e8m1_and14bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 0)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvlmax_e8m1_and13bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 0)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvlmax_e8m2_and15bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 1)
  %b = and i64 %a, 32767
  ret i64 %b
}

define i64 @vsetvlmax_e8m2_and14bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 1)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvlmax_e8m4_and16bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 2)
  %b = and i64 %a, 65535
  ret i64 %b
}

define i64 @vsetvlmax_e8m4_and15bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 2)
  %b = and i64 %a, 32767
  ret i64 %b
}

define i64 @vsetvlmax_e8m8_and17bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 3)
  %b = and i64 %a, 131071
  ret i64 %b
}

define i64 @vsetvlmax_e8m8_and16bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 3)
  %b = and i64 %a, 65535
  ret i64 %b
}

define i64 @vsetvlmax_e8mf2_and11bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 5)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvlmax_e8mf2_and10bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 5)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvlmax_e8mf4_and12bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 6)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvlmax_e8mf4_and11bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 6)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvlmax_e8mf8_and13bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 7)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvlmax_e8mf8_and12bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 7)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvlmax_e16m1_and13bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 0)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvlmax_e16m1_and12bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 0)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvlmax_e16m2_and14bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 1)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvlmax_e16m2_and13bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 1)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvlmax_e16m4_and15bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 2)
  %b = and i64 %a, 32767
  ret i64 %b
}

define i64 @vsetvlmax_e16m4_and14bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 2)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvlmax_e16m8_and16bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 3)
  %b = and i64 %a, 65535
  ret i64 %b
}

define i64 @vsetvlmax_e16m8_and15bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 3)
  %b = and i64 %a, 32767
  ret i64 %b
}

define i64 @vsetvlmax_e16mf2_and10bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 5)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvlmax_e16mf2_and9bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 5)
  %b = and i64 %a, 511
  ret i64 %b
}

define i64 @vsetvlmax_e16mf4_and11bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 6)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvlmax_e16mf4_and10bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 6)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvlmax_e16mf8_and12bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 7)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvlmax_e16mf8_and11bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 7)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvlmax_e32m1_and12bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 0)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvlmax_e32m1_and11bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 0)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvlmax_e32m2_and13bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 1)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvlmax_e32m2_and12bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 1)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvlmax_e32m4_and14bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 2)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvlmax_e32m4_and13bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 2)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvlmax_e32m8_and15bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 3)
  %b = and i64 %a, 32767
  ret i64 %b
}

define i64 @vsetvlmax_e32m8_and14bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 3)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvlmax_e32mf2_and9bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 5)
  %b = and i64 %a, 511
  ret i64 %b
}

define i64 @vsetvlmax_e32mf2_and8bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 5)
  %b = and i64 %a, 255
  ret i64 %b
}

define i64 @vsetvlmax_e32mf4_and10bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 6)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvlmax_e32mf4_and9bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 6)
  %b = and i64 %a, 511
  ret i64 %b
}

define i64 @vsetvlmax_e32mf8_and11bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 7)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvlmax_e32mf8_and10bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 7)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvlmax_e64m1_and11bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 0)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvlmax_e64m1_and10bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 0)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvlmax_e64m2_and12bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 1)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvlmax_e64m2_and11bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 1)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvlmax_e64m4_and13bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 2)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvlmax_e64m4_and12bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 2)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvlmax_e64m8_and14bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 3)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvlmax_e64m8_and13bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 3)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvlmax_e64mf2_and8bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 5)
  %b = and i64 %a, 255
  ret i64 %b
}

define i64 @vsetvlmax_e64mf2_and7bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 5)
  %b = and i64 %a, 127
  ret i64 %b
}

define i64 @vsetvlmax_e64mf4_and9bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 6)
  %b = and i64 %a, 511
  ret i64 %b
}

define i64 @vsetvlmax_e64mf4_and8bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 6)
  %b = and i64 %a, 255
  ret i64 %b
}

define i64 @vsetvlmax_e64mf8_and10bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 7)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvlmax_e64mf8_and9bits() nounwind #0 {
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 7)
  %b = and i64 %a, 511
  ret i64 %b
}

attributes #0 = { vscale_range(2,1024) }

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmpm1thaom1.ll'
source_filename = "/tmp/tmpm1thaom1.ll"

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i32 @llvm.riscv.vsetvlimax.i32(i32 immarg, i32 immarg) #0

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i64 @llvm.riscv.vsetvlimax.i64(i64 immarg, i64 immarg) #0

; Function Attrs: nounwind vscale_range(2,1024)
define i32 @vsetvlimax_i32() #1 {
entry:
  %0 = call i32 @llvm.riscv.vsetvlimax.i32(i32 1, i32 1)
  ret i32 %0
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlimax_sext_i64() #1 {
entry:
  %0 = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 1)
  ret i64 %0
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlimax_zext_i64() #1 {
entry:
  %0 = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 1)
  ret i64 %0
}

; Function Attrs: nounwind vscale_range(2,1024)
define signext i32 @vsetvlmax_sext() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 1)
  %b = trunc nuw nsw i64 %a to i32
  ret i32 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define zeroext i32 @vsetvlmax_zext() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 1)
  %b = trunc nuw nsw i64 %a to i32
  ret i32 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i32 @vsetvlimax_and17_i32() #1 {
entry:
  %0 = call i32 @llvm.riscv.vsetvlimax.i32(i32 1, i32 1)
  ret i32 %0
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlimax_and17_i64() #1 {
entry:
  %0 = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 1)
  ret i64 %0
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e8m1_and14bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 0, i64 0)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e8m1_and13bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 0, i64 0)
  %b = and i64 %a, 8191
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e8m2_and15bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 0, i64 1)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e8m2_and14bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 0, i64 1)
  %b = and i64 %a, 16383
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e8m4_and16bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 0, i64 2)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e8m4_and15bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 0, i64 2)
  %b = and i64 %a, 32767
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e8m8_and17bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 0, i64 3)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e8m8_and16bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 0, i64 3)
  %b = and i64 %a, 65535
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e8mf2_and11bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 0, i64 5)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e8mf2_and10bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 0, i64 5)
  %b = and i64 %a, 1023
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e8mf4_and12bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 0, i64 6)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e8mf4_and11bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 0, i64 6)
  %b = and i64 %a, 2047
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e8mf8_and13bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 0, i64 7)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e8mf8_and12bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 0, i64 7)
  %b = and i64 %a, 4095
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e16m1_and13bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 0)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e16m1_and12bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 0)
  %b = and i64 %a, 4095
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e16m2_and14bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 1)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e16m2_and13bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 1)
  %b = and i64 %a, 8191
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e16m4_and15bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 2)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e16m4_and14bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 2)
  %b = and i64 %a, 16383
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e16m8_and16bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 3)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e16m8_and15bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 3)
  %b = and i64 %a, 32767
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e16mf2_and10bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 5)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e16mf2_and9bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 5)
  %b = and i64 %a, 511
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e16mf4_and11bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 6)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e16mf4_and10bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 6)
  %b = and i64 %a, 1023
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e16mf8_and12bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 7)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e16mf8_and11bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 1, i64 7)
  %b = and i64 %a, 2047
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e32m1_and12bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 2, i64 0)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e32m1_and11bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 2, i64 0)
  %b = and i64 %a, 2047
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e32m2_and13bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 2, i64 1)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e32m2_and12bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 2, i64 1)
  %b = and i64 %a, 4095
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e32m4_and14bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 2, i64 2)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e32m4_and13bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 2, i64 2)
  %b = and i64 %a, 8191
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e32m8_and15bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 2, i64 3)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e32m8_and14bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 2, i64 3)
  %b = and i64 %a, 16383
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e32mf2_and9bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 2, i64 5)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e32mf2_and8bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 2, i64 5)
  %b = and i64 %a, 255
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e32mf4_and10bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 2, i64 6)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e32mf4_and9bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 2, i64 6)
  %b = and i64 %a, 511
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e32mf8_and11bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 2, i64 7)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e32mf8_and10bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 2, i64 7)
  %b = and i64 %a, 1023
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e64m1_and11bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 3, i64 0)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e64m1_and10bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 3, i64 0)
  %b = and i64 %a, 1023
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e64m2_and12bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 3, i64 1)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e64m2_and11bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 3, i64 1)
  %b = and i64 %a, 2047
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e64m4_and13bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 3, i64 2)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e64m4_and12bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 3, i64 2)
  %b = and i64 %a, 4095
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e64m8_and14bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 3, i64 3)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e64m8_and13bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 3, i64 3)
  %b = and i64 %a, 8191
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e64mf2_and8bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 3, i64 5)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e64mf2_and7bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 3, i64 5)
  %b = and i64 %a, 127
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e64mf4_and9bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 3, i64 6)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e64mf4_and8bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 3, i64 6)
  %b = and i64 %a, 255
  ret i64 %b
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e64mf8_and10bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 3, i64 7)
  ret i64 %a
}

; Function Attrs: nounwind vscale_range(2,1024)
define i64 @vsetvlmax_e64mf8_and9bits() #1 {
  %a = call i64 @llvm.riscv.vsetvlimax.i64(i64 3, i64 7)
  %b = and i64 %a, 511
  ret i64 %b
}

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #1 = { nounwind vscale_range(2,1024) }
