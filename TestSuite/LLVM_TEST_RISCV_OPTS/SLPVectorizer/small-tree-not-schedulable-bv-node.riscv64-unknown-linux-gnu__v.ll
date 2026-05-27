; Source: /home/artjom/Tools/llvm-project/llvm/test/Transforms/SLPVectorizer/RISCV/small-tree-not-schedulable-bv-node.ll
; Variant: riscv64-unknown-linux-gnu_+v
; Command: /home/artjom/Tools/llvm-project/build/bin/opt -mtriple=riscv64-unknown-linux-gnu -slp-threshold=-100 -mattr=+v -S
; Original: RUN: opt -S -mtriple=riscv64-unknown-linux-gnu -slp-threshold=-100 -mattr=+v < %s | FileCheck %s

; ======================================================================
; PRE-OPT (input IR)
; ======================================================================


define void @test1() personality ptr null {
entry:
  %call33 = invoke ptr null(i64 0, ptr null)
  to label %invoke.cont32 unwind label %lpad31.loopexit

invoke.cont32:
  invoke void null(ptr null, ptr null)
  to label %invoke.cont37 unwind label %lpad34.loopexit

invoke.cont37:
  unreachable

lpad31.loopexit:
  %lpad.loopexit = landingpad { ptr, i32 }
  cleanup
  br label %ehcleanup47

lpad34.loopexit:
  %.lcssa101 = phi ptr [ null, %invoke.cont32 ]
  %call33.lcssa96 = phi ptr [ %call33, %invoke.cont32 ]
  %lpad.loopexit56 = landingpad { ptr, i32 }
  cleanup
  br label %lpad34.body

lpad34.loopexit.split-lp:
  %lpad.loopexit.split-lp57 = landingpad { ptr, i32 }
  cleanup
  br label %lpad34.body

lpad34.body:
  %0 = phi ptr [ %.lcssa101, %lpad34.loopexit ], [ null, %lpad34.loopexit.split-lp ]
  %call3399 = phi ptr [ %call33.lcssa96, %lpad34.loopexit ], [ null, %lpad34.loopexit.split-lp ]
  br label %ehcleanup47

ehcleanup47:
  resume { ptr, i32 } zeroinitializer
}

define i32 @test2(i64 %idx.ext.i48.pre-phi) {
entry:
  br label %do_action

do_action:
  switch i32 0, label %sw.default [
  i32 1, label %cleanup185
  i32 2, label %cleanup185
  i32 0, label %cleanup185
  i32 4, label %cleanup185
  i32 5, label %cleanup185
  i32 6, label %cleanup185
  i32 7, label %cleanup185
  i32 8, label %cleanup185
  i32 9, label %cleanup185
  i32 10, label %cleanup185
  i32 11, label %cleanup185
  i32 12, label %cleanup185
  i32 13, label %cleanup185
  i32 14, label %cleanup185
  i32 15, label %cleanup185
  i32 16, label %cleanup185
  i32 17, label %cleanup185
  i32 18, label %cleanup185
  i32 19, label %cleanup185
  i32 20, label %cleanup185
  i32 21, label %cleanup185
  i32 22, label %cleanup185
  i32 23, label %cleanup185
  i32 24, label %cleanup185
  i32 25, label %cleanup185
  i32 26, label %cleanup185
  i32 27, label %cleanup185
  i32 28, label %cleanup185
  i32 29, label %cleanup185
  i32 30, label %cleanup185
  i32 31, label %cleanup185
  i32 32, label %cleanup185
  i32 33, label %cleanup185
  i32 34, label %cleanup185
  i32 35, label %cleanup185
  i32 36, label %cleanup185
  i32 37, label %cleanup185
  i32 38, label %cleanup185
  i32 39, label %cleanup185
  i32 40, label %cleanup185
  i32 41, label %cleanup185
  i32 42, label %cleanup185
  i32 43, label %cleanup185
  i32 44, label %cleanup185
  i32 45, label %cleanup185
  i32 46, label %cleanup185
  i32 47, label %cleanup185
  i32 48, label %cleanup185
  i32 49, label %cleanup185
  i32 50, label %cleanup185
  i32 51, label %cleanup185
  i32 52, label %cleanup185
  i32 53, label %cleanup185
  i32 54, label %cleanup185
  i32 55, label %cleanup185
  i32 56, label %cleanup185
  i32 57, label %do_action
  i32 58, label %cleanup185
  i32 59, label %cleanup185
  i32 60, label %do_action
  i32 61, label %do_action
  i32 62, label %cleanup185
  i32 70, label %sw.bb175
  i32 64, label %cleanup185
  i32 65, label %do_action
  i32 66, label %do_action
  i32 67, label %cleanup185
  i32 72, label %cleanup185
  i32 69, label %do_action
  i32 71, label %cleanup185
  ]

yy_get_previous_state.exit.loopexit:
  br label %yy_find_action.backedge

yy_find_action.backedge:
  %yy_bp.1.be = phi ptr [ %add.ptr.i49, %sw.bb175 ], [ null, %yy_get_previous_state.exit.loopexit ]
  %yy_cp.2.be = phi ptr [ %arrayidx178, %sw.bb175 ], [ null, %yy_get_previous_state.exit.loopexit ]
  br label %do_action

sw.bb175:
  %arrayidx178 = getelementptr i8, ptr null, i64 0
  %add.ptr.i49 = getelementptr i8, ptr null, i64 %idx.ext.i48.pre-phi
  %cmp5.i50 = icmp ult ptr %add.ptr.i49, %arrayidx178
  br label %yy_find_action.backedge

sw.default:
  unreachable

cleanup185:
  ret i32 0
}

; ======================================================================
; POST-OPT (actual opt output)
; ======================================================================

; ModuleID = '/tmp/tmprerhewh8.ll'
source_filename = "/tmp/tmprerhewh8.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

define void @test1() #0 personality ptr null {
entry:
  %call33 = invoke ptr null(i64 0, ptr null)
          to label %invoke.cont32 unwind label %lpad31.loopexit

invoke.cont32:                                    ; preds = %entry
  invoke void null(ptr null, ptr null)
          to label %invoke.cont37 unwind label %lpad34.loopexit

invoke.cont37:                                    ; preds = %invoke.cont32
  unreachable

lpad31.loopexit:                                  ; preds = %entry
  %lpad.loopexit = landingpad { ptr, i32 }
          cleanup
  br label %ehcleanup47

lpad34.loopexit:                                  ; preds = %invoke.cont32
  %.lcssa101 = phi ptr [ null, %invoke.cont32 ]
  %call33.lcssa96 = phi ptr [ %call33, %invoke.cont32 ]
  %lpad.loopexit56 = landingpad { ptr, i32 }
          cleanup
  br label %lpad34.body

lpad34.loopexit.split-lp:                         ; No predecessors!
  %lpad.loopexit.split-lp57 = landingpad { ptr, i32 }
          cleanup
  br label %lpad34.body

lpad34.body:                                      ; preds = %lpad34.loopexit.split-lp, %lpad34.loopexit
  %0 = phi ptr [ %.lcssa101, %lpad34.loopexit ], [ null, %lpad34.loopexit.split-lp ]
  %call3399 = phi ptr [ %call33.lcssa96, %lpad34.loopexit ], [ null, %lpad34.loopexit.split-lp ]
  br label %ehcleanup47

ehcleanup47:                                      ; preds = %lpad34.body, %lpad31.loopexit
  resume { ptr, i32 } zeroinitializer
}

define i32 @test2(i64 %idx.ext.i48.pre-phi) #0 {
entry:
  br label %do_action

do_action:                                        ; preds = %yy_find_action.backedge, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %entry
  switch i32 0, label %sw.default [
    i32 1, label %cleanup185
    i32 2, label %cleanup185
    i32 0, label %cleanup185
    i32 4, label %cleanup185
    i32 5, label %cleanup185
    i32 6, label %cleanup185
    i32 7, label %cleanup185
    i32 8, label %cleanup185
    i32 9, label %cleanup185
    i32 10, label %cleanup185
    i32 11, label %cleanup185
    i32 12, label %cleanup185
    i32 13, label %cleanup185
    i32 14, label %cleanup185
    i32 15, label %cleanup185
    i32 16, label %cleanup185
    i32 17, label %cleanup185
    i32 18, label %cleanup185
    i32 19, label %cleanup185
    i32 20, label %cleanup185
    i32 21, label %cleanup185
    i32 22, label %cleanup185
    i32 23, label %cleanup185
    i32 24, label %cleanup185
    i32 25, label %cleanup185
    i32 26, label %cleanup185
    i32 27, label %cleanup185
    i32 28, label %cleanup185
    i32 29, label %cleanup185
    i32 30, label %cleanup185
    i32 31, label %cleanup185
    i32 32, label %cleanup185
    i32 33, label %cleanup185
    i32 34, label %cleanup185
    i32 35, label %cleanup185
    i32 36, label %cleanup185
    i32 37, label %cleanup185
    i32 38, label %cleanup185
    i32 39, label %cleanup185
    i32 40, label %cleanup185
    i32 41, label %cleanup185
    i32 42, label %cleanup185
    i32 43, label %cleanup185
    i32 44, label %cleanup185
    i32 45, label %cleanup185
    i32 46, label %cleanup185
    i32 47, label %cleanup185
    i32 48, label %cleanup185
    i32 49, label %cleanup185
    i32 50, label %cleanup185
    i32 51, label %cleanup185
    i32 52, label %cleanup185
    i32 53, label %cleanup185
    i32 54, label %cleanup185
    i32 55, label %cleanup185
    i32 56, label %cleanup185
    i32 57, label %do_action
    i32 58, label %cleanup185
    i32 59, label %cleanup185
    i32 60, label %do_action
    i32 61, label %do_action
    i32 62, label %cleanup185
    i32 70, label %sw.bb175
    i32 64, label %cleanup185
    i32 65, label %do_action
    i32 66, label %do_action
    i32 67, label %cleanup185
    i32 72, label %cleanup185
    i32 69, label %do_action
    i32 71, label %cleanup185
  ]

yy_get_previous_state.exit.loopexit:              ; No predecessors!
  br label %yy_find_action.backedge

yy_find_action.backedge:                          ; preds = %sw.bb175, %yy_get_previous_state.exit.loopexit
  %yy_bp.1.be = phi ptr [ %add.ptr.i49, %sw.bb175 ], [ null, %yy_get_previous_state.exit.loopexit ]
  %yy_cp.2.be = phi ptr [ %arrayidx178, %sw.bb175 ], [ null, %yy_get_previous_state.exit.loopexit ]
  br label %do_action

sw.bb175:                                         ; preds = %do_action
  %arrayidx178 = getelementptr i8, ptr null, i64 0
  %add.ptr.i49 = getelementptr i8, ptr null, i64 %idx.ext.i48.pre-phi
  %cmp5.i50 = icmp ult ptr %add.ptr.i49, %arrayidx178
  br label %yy_find_action.backedge

sw.default:                                       ; preds = %do_action
  unreachable

cleanup185:                                       ; preds = %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action, %do_action
  ret i32 0
}

attributes #0 = { "target-features"="+v" }
