; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/LoopIdiom/RISCV/popcnt.ll
; Variant: riscv64_loop-idiom_NOCPOP
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -passes=loop-idiom -mtriple=riscv64 -S
; Original: RUN: opt -passes=loop-idiom -mtriple=riscv64 -S < %s | FileCheck %s --check-prefixes=NOCPOP

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


; Mostly copied from AMDGPU version.

;To recognize this pattern:
;int popcount(unsigned long long a) {
;    int c = 0;
;    while (a) {
;        c++;
;        a &= a - 1;
;    }
;    return c;
;}

define i32 @popcount_i64(i64 %a) nounwind uwtable readnone ssp {
entry:
  %tobool3 = icmp eq i64 %a, 0
  br i1 %tobool3, label %while.end, label %while.body

while.body:                                       ; preds = %entry, %while.body
  %c.05 = phi i32 [ %inc, %while.body ], [ 0, %entry ]
  %a.addr.04 = phi i64 [ %and, %while.body ], [ %a, %entry ]
  %inc = add nsw i32 %c.05, 1
  %sub = add i64 %a.addr.04, -1
  %and = and i64 %sub, %a.addr.04
  %tobool = icmp eq i64 %and, 0
  br i1 %tobool, label %while.end, label %while.body

while.end:                                        ; preds = %while.body, %entry
  %c.0.lcssa = phi i32 [ 0, %entry ], [ %inc, %while.body ]
  ret i32 %c.0.lcssa
}

define i32 @popcount_i32(i32 %a) nounwind uwtable readnone ssp {
entry:
  %tobool3 = icmp eq i32 %a, 0
  br i1 %tobool3, label %while.end, label %while.body

while.body:                                       ; preds = %entry, %while.body
  %c.05 = phi i32 [ %inc, %while.body ], [ 0, %entry ]
  %a.addr.04 = phi i32 [ %and, %while.body ], [ %a, %entry ]
  %inc = add nsw i32 %c.05, 1
  %sub = add i32 %a.addr.04, -1
  %and = and i32 %sub, %a.addr.04
  %tobool = icmp eq i32 %and, 0
  br i1 %tobool, label %while.end, label %while.body

while.end:                                        ; preds = %while.body, %entry
  %c.0.lcssa = phi i32 [ 0, %entry ], [ %inc, %while.body ]
  ret i32 %c.0.lcssa
}

define i32 @popcount_i128(i128 %a) nounwind uwtable readnone ssp {
entry:
  %tobool3 = icmp eq i128 %a, 0
  br i1 %tobool3, label %while.end, label %while.body

while.body:                                       ; preds = %entry, %while.body
  %c.05 = phi i32 [ %inc, %while.body ], [ 0, %entry ]
  %a.addr.04 = phi i128 [ %and, %while.body ], [ %a, %entry ]
  %inc = add nsw i32 %c.05, 1
  %sub = add i128 %a.addr.04, -1
  %and = and i128 %sub, %a.addr.04
  %tobool = icmp eq i128 %and, 0
  br i1 %tobool, label %while.end, label %while.body

while.end:                                        ; preds = %while.body, %entry
  %c.0.lcssa = phi i32 [ 0, %entry ], [ %inc, %while.body ]
  ret i32 %c.0.lcssa
}

; To recognize this pattern:
;int popcount(unsigned long long a, int mydata1, int mydata2) {
;    int c = 0;
;    while (a) {
;        c++;
;        a &= a - 1;
;        mydata1 *= c;
;        mydata2 *= (int)a;
;    }
;    return c + mydata1 + mydata2;
;}

define i32 @popcount2(i64 %a, i32 %mydata1, i32 %mydata2) nounwind uwtable readnone ssp {
entry:
  %tobool9 = icmp eq i64 %a, 0
  br i1 %tobool9, label %while.end, label %while.body

while.body:                                       ; preds = %entry, %while.body
  %c.013 = phi i32 [ %inc, %while.body ], [ 0, %entry ]
  %mydata2.addr.012 = phi i32 [ %mul1, %while.body ], [ %mydata2, %entry ]
  %mydata1.addr.011 = phi i32 [ %mul, %while.body ], [ %mydata1, %entry ]
  %a.addr.010 = phi i64 [ %and, %while.body ], [ %a, %entry ]
  %inc = add nsw i32 %c.013, 1
  %sub = add i64 %a.addr.010, -1
  %and = and i64 %sub, %a.addr.010
  %mul = mul nsw i32 %inc, %mydata1.addr.011
  %conv = trunc i64 %and to i32
  %mul1 = mul nsw i32 %conv, %mydata2.addr.012
  %tobool = icmp eq i64 %and, 0
  br i1 %tobool, label %while.end, label %while.body

while.end:                                        ; preds = %while.body, %entry
  %c.0.lcssa = phi i32 [ 0, %entry ], [ %inc, %while.body ]
  %mydata2.addr.0.lcssa = phi i32 [ %mydata2, %entry ], [ %mul1, %while.body ]
  %mydata1.addr.0.lcssa = phi i32 [ %mydata1, %entry ], [ %mul, %while.body ]
  %add = add i32 %mydata2.addr.0.lcssa, %mydata1.addr.0.lcssa
  %add2 = add i32 %add, %c.0.lcssa
  ret i32 %add2
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmprneidoyt.ll'
source_filename = "/tmp/tmprneidoyt.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

; Function Attrs: nounwind ssp memory(none) uwtable
define i32 @popcount_i64(i64 %a) #0 {
entry:
  %tobool3 = icmp eq i64 %a, 0
  br i1 %tobool3, label %while.end, label %while.body.preheader

while.body.preheader:                             ; preds = %entry
  br label %while.body

while.body:                                       ; preds = %while.body.preheader, %while.body
  %c.05 = phi i32 [ %inc, %while.body ], [ 0, %while.body.preheader ]
  %a.addr.04 = phi i64 [ %and, %while.body ], [ %a, %while.body.preheader ]
  %inc = add nsw i32 %c.05, 1
  %sub = add i64 %a.addr.04, -1
  %and = and i64 %sub, %a.addr.04
  %tobool = icmp eq i64 %and, 0
  br i1 %tobool, label %while.end.loopexit, label %while.body

while.end.loopexit:                               ; preds = %while.body
  %inc.lcssa = phi i32 [ %inc, %while.body ]
  br label %while.end

while.end:                                        ; preds = %while.end.loopexit, %entry
  %c.0.lcssa = phi i32 [ 0, %entry ], [ %inc.lcssa, %while.end.loopexit ]
  ret i32 %c.0.lcssa
}

; Function Attrs: nounwind ssp memory(none) uwtable
define i32 @popcount_i32(i32 %a) #0 {
entry:
  %tobool3 = icmp eq i32 %a, 0
  br i1 %tobool3, label %while.end, label %while.body.preheader

while.body.preheader:                             ; preds = %entry
  br label %while.body

while.body:                                       ; preds = %while.body.preheader, %while.body
  %c.05 = phi i32 [ %inc, %while.body ], [ 0, %while.body.preheader ]
  %a.addr.04 = phi i32 [ %and, %while.body ], [ %a, %while.body.preheader ]
  %inc = add nsw i32 %c.05, 1
  %sub = add i32 %a.addr.04, -1
  %and = and i32 %sub, %a.addr.04
  %tobool = icmp eq i32 %and, 0
  br i1 %tobool, label %while.end.loopexit, label %while.body

while.end.loopexit:                               ; preds = %while.body
  %inc.lcssa = phi i32 [ %inc, %while.body ]
  br label %while.end

while.end:                                        ; preds = %while.end.loopexit, %entry
  %c.0.lcssa = phi i32 [ 0, %entry ], [ %inc.lcssa, %while.end.loopexit ]
  ret i32 %c.0.lcssa
}

; Function Attrs: nounwind ssp memory(none) uwtable
define i32 @popcount_i128(i128 %a) #0 {
entry:
  %tobool3 = icmp eq i128 %a, 0
  br i1 %tobool3, label %while.end, label %while.body.preheader

while.body.preheader:                             ; preds = %entry
  br label %while.body

while.body:                                       ; preds = %while.body.preheader, %while.body
  %c.05 = phi i32 [ %inc, %while.body ], [ 0, %while.body.preheader ]
  %a.addr.04 = phi i128 [ %and, %while.body ], [ %a, %while.body.preheader ]
  %inc = add nsw i32 %c.05, 1
  %sub = add i128 %a.addr.04, -1
  %and = and i128 %sub, %a.addr.04
  %tobool = icmp eq i128 %and, 0
  br i1 %tobool, label %while.end.loopexit, label %while.body

while.end.loopexit:                               ; preds = %while.body
  %inc.lcssa = phi i32 [ %inc, %while.body ]
  br label %while.end

while.end:                                        ; preds = %while.end.loopexit, %entry
  %c.0.lcssa = phi i32 [ 0, %entry ], [ %inc.lcssa, %while.end.loopexit ]
  ret i32 %c.0.lcssa
}

; Function Attrs: nounwind ssp memory(none) uwtable
define i32 @popcount2(i64 %a, i32 %mydata1, i32 %mydata2) #0 {
entry:
  %tobool9 = icmp eq i64 %a, 0
  br i1 %tobool9, label %while.end, label %while.body.preheader

while.body.preheader:                             ; preds = %entry
  br label %while.body

while.body:                                       ; preds = %while.body.preheader, %while.body
  %c.013 = phi i32 [ %inc, %while.body ], [ 0, %while.body.preheader ]
  %mydata2.addr.012 = phi i32 [ %mul1, %while.body ], [ %mydata2, %while.body.preheader ]
  %mydata1.addr.011 = phi i32 [ %mul, %while.body ], [ %mydata1, %while.body.preheader ]
  %a.addr.010 = phi i64 [ %and, %while.body ], [ %a, %while.body.preheader ]
  %inc = add nsw i32 %c.013, 1
  %sub = add i64 %a.addr.010, -1
  %and = and i64 %sub, %a.addr.010
  %mul = mul nsw i32 %inc, %mydata1.addr.011
  %conv = trunc i64 %and to i32
  %mul1 = mul nsw i32 %conv, %mydata2.addr.012
  %tobool = icmp eq i64 %and, 0
  br i1 %tobool, label %while.end.loopexit, label %while.body

while.end.loopexit:                               ; preds = %while.body
  %inc.lcssa = phi i32 [ %inc, %while.body ]
  %mul.lcssa = phi i32 [ %mul, %while.body ]
  %mul1.lcssa = phi i32 [ %mul1, %while.body ]
  br label %while.end

while.end:                                        ; preds = %while.end.loopexit, %entry
  %c.0.lcssa = phi i32 [ 0, %entry ], [ %inc.lcssa, %while.end.loopexit ]
  %mydata2.addr.0.lcssa = phi i32 [ %mydata2, %entry ], [ %mul1.lcssa, %while.end.loopexit ]
  %mydata1.addr.0.lcssa = phi i32 [ %mydata1, %entry ], [ %mul.lcssa, %while.end.loopexit ]
  %add = add i32 %mydata2.addr.0.lcssa, %mydata1.addr.0.lcssa
  %add2 = add i32 %add, %c.0.lcssa
  ret i32 %add2
}

attributes #0 = { nounwind ssp memory(none) uwtable }
