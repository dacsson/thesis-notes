(set-logic HORN)

; ----------------------------------------------------------------------
; OVERVIEW
; ----------------------------------------------------------------------
;
; This is a small, self-contained CHC/SMT-LIB encoding of the constant-folding
; example from the thesis notes.
;
; We compare two RISC-V functions:
;
;   foo1 = stack-based, unoptimized code
;   foo2 = constant-folded code that directly returns 3
;
; The purpose of the file is to make one theoretical point precise:
;
;   "Equivalence depends on what part of the final state we observe."
;
; Therefore the file contains TWO bad-state queries:
;
;   1. bad_obs
;      Counterexample to observable equivalence.
;      We only compare:
;      - return register a0
;      - preserved/boundary registers ra, sp, s0
;
;      Expected result: UNSAT
;      Reason: both functions compute the same returned result and restore the
;      same boundary registers.
;
;   2. bad_full
;      Counterexample to full final-state equality.
;      We compare:
;      - the same registers as above
;      - AND the entire final memory array
;
;      Expected result: SAT
;      Reason: foo1 writes temporary values to stack memory, while foo2 does
;      not. So the final memory states can differ even though the functions are
;      equivalent at a normal function boundary.
;
; This file is intentionally not a full ISA model. It is a hand-written,
; example-sized CHC encoding in the same style as the current Rust prototype.
;
; Run with:
;   z3 Implementation/RICOVER/examples/foo_constant_folding.smt2

; ----------------------------------------------------------------------
; Standard library
; ----------------------------------------------------------------------
;
; State components used here:
; - Regs: array from 5-bit register indices to 64-bit values
; - Mem : array from 64-bit addresses to 8-bit bytes
;
; We do not model PC here because the point of the example is function-level
; outcome, not exact control-flow addresses.
;
; get_reg / set_reg enforce the x0 invariant:
; - reads from x0 always produce 0
; - writes to x0 are ignored

(define-fun get_reg ((regs (Array (_ BitVec 5) (_ BitVec 64)))
                     (idx (_ BitVec 5))) (_ BitVec 64)
  (ite (= idx (_ bv0 5))
       (_ bv0 64)
       (select regs idx)))

(define-fun set_reg ((regs (Array (_ BitVec 5) (_ BitVec 64)))
                     (idx (_ BitVec 5))
                     (val (_ BitVec 64))) (Array (_ BitVec 5) (_ BitVec 64))
  (ite (= idx (_ bv0 5))
       regs
       (store regs idx val)))

(define-fun read_mem_word ((mem (Array (_ BitVec 64) (_ BitVec 8)))
                           (addr (_ BitVec 64))) (_ BitVec 64)
  ((_ sign_extend 32)
    (concat (select mem (bvadd addr (_ bv3 64)))
            (concat (select mem (bvadd addr (_ bv2 64)))
                    (concat (select mem (bvadd addr (_ bv1 64)))
                            (select mem addr))))))

(define-fun read_mem_dword ((mem (Array (_ BitVec 64) (_ BitVec 8)))
                            (addr (_ BitVec 64))) (_ BitVec 64)
  (concat (select mem (bvadd addr (_ bv7 64)))
          (concat (select mem (bvadd addr (_ bv6 64)))
                  (concat (select mem (bvadd addr (_ bv5 64)))
                          (concat (select mem (bvadd addr (_ bv4 64)))
                                  (concat (select mem (bvadd addr (_ bv3 64)))
                                          (concat (select mem (bvadd addr (_ bv2 64)))
                                                  (concat (select mem (bvadd addr (_ bv1 64)))
                                                          (select mem addr)))))))))

(define-fun write_mem_word ((mem (Array (_ BitVec 64) (_ BitVec 8)))
                            (addr (_ BitVec 64))
                            (val (_ BitVec 64))) (Array (_ BitVec 64) (_ BitVec 8))
  (store (store (store (store mem
    addr                       ((_ extract 7 0) val))
    (bvadd addr (_ bv1 64))    ((_ extract 15 8) val))
    (bvadd addr (_ bv2 64))    ((_ extract 23 16) val))
    (bvadd addr (_ bv3 64))    ((_ extract 31 24) val)))

(define-fun write_mem_dword ((mem (Array (_ BitVec 64) (_ BitVec 8)))
                             (addr (_ BitVec 64))
                             (val (_ BitVec 64))) (Array (_ BitVec 64) (_ BitVec 8))
  (store (store (store (store (store (store (store (store mem
    addr                       ((_ extract 7 0) val))
    (bvadd addr (_ bv1 64))    ((_ extract 15 8) val))
    (bvadd addr (_ bv2 64))    ((_ extract 23 16) val))
    (bvadd addr (_ bv3 64))    ((_ extract 31 24) val))
    (bvadd addr (_ bv4 64))    ((_ extract 39 32) val))
    (bvadd addr (_ bv5 64))    ((_ extract 47 40) val))
    (bvadd addr (_ bv6 64))    ((_ extract 55 48) val))
    (bvadd addr (_ bv7 64))    ((_ extract 63 56) val)))

(define-fun reg_zero () (_ BitVec 5) (_ bv0 5))
(define-fun reg_ra   () (_ BitVec 5) (_ bv1 5))
(define-fun reg_sp   () (_ BitVec 5) (_ bv2 5))
(define-fun reg_s0   () (_ BitVec 5) (_ bv8 5))
(define-fun reg_a0   () (_ BitVec 5) (_ bv10 5))

; ----------------------------------------------------------------------
; Instruction relations
; ----------------------------------------------------------------------
;
; Each instruction is encoded as a relation:
;
;   instr(regs_before, mem_before, regs_after, mem_after, operands...)
;
; This is the CHC view of a single transition step.
;
; Important: the operand order in the relations below follows the semantic
; argument order, not the printed assembly order.
;
; For example:
;
;   (addi regs0 mem0 regs1 mem1 imm rs1 rd)
;
; corresponds to the assembly instruction:
;
;   addi rd, rs1, imm
;
; Therefore:
;
;   (addi regs0 mem0 regs1 mem1 (_ bv3 12) reg_zero reg_a0)
;
; means exactly:
;
;   addi a0, zero, 3
;
; and not "addi on a0 as both source and destination".

(declare-rel addi
  ((Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))
   (Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))
   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0  (Array (_ BitVec 64) (_ BitVec 8)))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1  (Array (_ BitVec 64) (_ BitVec 8)))
           (imm (_ BitVec 12)) (rs1 (_ BitVec 5)) (rd (_ BitVec 5)))
    (=> (and
             ; addi:
             ;   rd := X(rs1) + sign_extend(imm)
             (= regs1 (set_reg regs0 rd
                               (bvadd (get_reg regs0 rs1)
                                      ((_ sign_extend 52) imm))))
             ; addi does not modify memory
             (= mem1 mem0))
        (addi regs0 mem0 regs1 mem1 imm rs1 rd))))

(declare-rel addiw
  ((Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))
   (Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))
   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0  (Array (_ BitVec 64) (_ BitVec 8)))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1  (Array (_ BitVec 64) (_ BitVec 8)))
           (imm (_ BitVec 12)) (rs1 (_ BitVec 5)) (rd (_ BitVec 5)))
    (=> (and
          ; addiw:
          ;   compute a 32-bit result, then sign-extend it back to 64 bits
          (= regs1
             (set_reg regs0 rd
               ((_ sign_extend 32)
                 ((_ extract 31 0)
                   (bvadd (get_reg regs0 rs1)
                          ((_ sign_extend 52) imm))))))
          ; addiw does not modify memory
          (= mem1 mem0))
        (addiw regs0 mem0 regs1 mem1 imm rs1 rd))))

(declare-rel sw
  ((Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))
   (Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))
   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0  (Array (_ BitVec 64) (_ BitVec 8)))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1  (Array (_ BitVec 64) (_ BitVec 8)))
           (imm (_ BitVec 12)) (base (_ BitVec 5)) (rs2 (_ BitVec 5)))
    (=> (and
          ; sw stores the low 32 bits of rs2 to memory at base + imm
          (= regs1 regs0)
          (= mem1
             (write_mem_word mem0
                             (bvadd (get_reg regs0 base)
                                    ((_ sign_extend 52) imm))
                             (get_reg regs0 rs2))))
        (sw regs0 mem0 regs1 mem1 imm base rs2))))

(declare-rel lw
  ((Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))
   (Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))
   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0  (Array (_ BitVec 64) (_ BitVec 8)))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1  (Array (_ BitVec 64) (_ BitVec 8)))
           (imm (_ BitVec 12)) (base (_ BitVec 5)) (rd (_ BitVec 5)))
    (=> (and
          ; lw loads 4 bytes from memory and sign-extends to 64 bits
          (= regs1
             (set_reg regs0 rd
               (read_mem_word mem0
                              (bvadd (get_reg regs0 base)
                                     ((_ sign_extend 52) imm)))))
          (= mem1 mem0))
        (lw regs0 mem0 regs1 mem1 imm base rd))))

(declare-rel sd
  ((Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))
   (Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))
   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0  (Array (_ BitVec 64) (_ BitVec 8)))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1  (Array (_ BitVec 64) (_ BitVec 8)))
           (imm (_ BitVec 12)) (base (_ BitVec 5)) (rs2 (_ BitVec 5)))
    (=> (and
          ; sd stores a full 64-bit register value to memory
          (= regs1 regs0)
          (= mem1
             (write_mem_dword mem0
                              (bvadd (get_reg regs0 base)
                                     ((_ sign_extend 52) imm))
                              (get_reg regs0 rs2))))
        (sd regs0 mem0 regs1 mem1 imm base rs2))))

(declare-rel ld
  ((Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))
   (Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))
   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0  (Array (_ BitVec 64) (_ BitVec 8)))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1  (Array (_ BitVec 64) (_ BitVec 8)))
           (imm (_ BitVec 12)) (base (_ BitVec 5)) (rd (_ BitVec 5)))
    (=> (and
          ; ld loads a full 64-bit value from memory
          (= regs1
             (set_reg regs0 rd
               (read_mem_dword mem0
                               (bvadd (get_reg regs0 base)
                                      ((_ sign_extend 52) imm)))))
          (= mem1 mem0))
        (ld regs0 mem0 regs1 mem1 imm base rd))))

; Function return via `jalr zero, 0(ra)`.
;
; In the real ISA this changes control flow. For the current example we compress
; it into a "return" relation that simply terminates the current function while
; leaving the final boundary state unchanged.
(declare-rel ret
  ((Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))
   (Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0  (Array (_ BitVec 64) (_ BitVec 8)))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1  (Array (_ BitVec 64) (_ BitVec 8))))
    (=> (and (= regs1 regs0) (= mem1 mem0))
        (ret regs0 mem0 regs1 mem1))))

; ----------------------------------------------------------------------
; Program relations
; ----------------------------------------------------------------------
;
; foo1 and foo2 are encoded by chaining the instruction relations.
; The intermediate variables regs1/mem1, regs2/mem2, ... are the threaded
; program states between instructions.

(declare-rel foo1
  ((Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))
   (Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))))

(rule
  (forall ((regs0  (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0   (Array (_ BitVec 64) (_ BitVec 8)))
           (regs1  (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1   (Array (_ BitVec 64) (_ BitVec 8)))
           (regs2  (Array (_ BitVec 5) (_ BitVec 64)))
           (mem2   (Array (_ BitVec 64) (_ BitVec 8)))
           (regs3  (Array (_ BitVec 5) (_ BitVec 64)))
           (mem3   (Array (_ BitVec 64) (_ BitVec 8)))
           (regs4  (Array (_ BitVec 5) (_ BitVec 64)))
           (mem4   (Array (_ BitVec 64) (_ BitVec 8)))
           (regs5  (Array (_ BitVec 5) (_ BitVec 64)))
           (mem5   (Array (_ BitVec 64) (_ BitVec 8)))
           (regs6  (Array (_ BitVec 5) (_ BitVec 64)))
           (mem6   (Array (_ BitVec 64) (_ BitVec 8)))
           (regs7  (Array (_ BitVec 5) (_ BitVec 64)))
           (mem7   (Array (_ BitVec 64) (_ BitVec 8)))
           (regs8  (Array (_ BitVec 5) (_ BitVec 64)))
           (mem8   (Array (_ BitVec 64) (_ BitVec 8)))
           (regs9  (Array (_ BitVec 5) (_ BitVec 64)))
           (mem9   (Array (_ BitVec 64) (_ BitVec 8)))
           (regs10 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem10  (Array (_ BitVec 64) (_ BitVec 8)))
           (regs11 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem11  (Array (_ BitVec 64) (_ BitVec 8)))
           (regs12 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem12  (Array (_ BitVec 64) (_ BitVec 8)))
           (regs13 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem13  (Array (_ BitVec 64) (_ BitVec 8)))
           (regs14 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem14  (Array (_ BitVec 64) (_ BitVec 8))))
    (=> (and
          ; ASM: addi sp, sp, -32
          ; Prologue: allocate a 32-byte stack frame
          (addi regs0 mem0 regs1 mem1 (_ bv4064 12) reg_sp reg_sp)
          ; ASM: sd ra, 24(sp)
          ; Save ra
          (sd regs1 mem1 regs2 mem2 (_ bv24 12) reg_sp reg_ra)
          ; ASM: sd s0, 16(sp)
          ; Save s0
          (sd regs2 mem2 regs3 mem3 (_ bv16 12) reg_sp reg_s0)
          ; ASM: addi s0, sp, 32
          ; Set frame pointer s0 = sp + 32
          (addi regs3 mem3 regs4 mem4 (_ bv32 12) reg_sp reg_s0)
          ; ASM: addi a0, zero, 1
          ; x := 1, placed in a0 temporarily
          (addi regs4 mem4 regs5 mem5 (_ bv1 12) reg_zero reg_a0)
          ; ASM: sw a0, -20(s0)
          ; spill x to stack
          (sw regs5 mem5 regs6 mem6 (_ bv4076 12) reg_s0 reg_a0)
          ; ASM: lw a0, -20(s0)
          ; reload x
          (lw regs6 mem6 regs7 mem7 (_ bv4076 12) reg_s0 reg_a0)
          ; ASM: addiw a0, a0, 2
          ; y := x + 2 = 3
          (addiw regs7 mem7 regs8 mem8 (_ bv2 12) reg_a0 reg_a0)
          ; ASM: sw a0, -24(s0)
          ; spill y to stack
          (sw regs8 mem8 regs9 mem9 (_ bv4072 12) reg_s0 reg_a0)
          ; ASM: lw a0, -24(s0)
          ; reload y into the return register
          (lw regs9 mem9 regs10 mem10 (_ bv4072 12) reg_s0 reg_a0)
          ; ASM: ld ra, 24(sp)
          ; Restore ra
          (ld regs10 mem10 regs11 mem11 (_ bv24 12) reg_sp reg_ra)
          ; ASM: ld s0, 16(sp)
          ; Restore s0
          (ld regs11 mem11 regs12 mem12 (_ bv16 12) reg_sp reg_s0)
          ; ASM: addi sp, sp, 32
          ; Deallocate stack frame
          (addi regs12 mem12 regs13 mem13 (_ bv32 12) reg_sp reg_sp)
          ; ASM: jalr zero, 0(ra)
          ; Return
          (ret regs13 mem13 regs14 mem14))
        (foo1 regs0 mem0 regs14 mem14))))

(declare-rel foo2
  ((Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))
   (Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0  (Array (_ BitVec 64) (_ BitVec 8)))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1  (Array (_ BitVec 64) (_ BitVec 8)))
           (regs2 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem2  (Array (_ BitVec 64) (_ BitVec 8))))
    (=> (and
          ; ASM: addi a0, zero, 3
          ; The optimized function materializes the known result directly.
          ; No spills, no stack frame, no memory writes.
          (addi regs0 mem0 regs1 mem1 (_ bv3 12) reg_zero reg_a0)
          ; ASM: jalr zero, 0(ra)
          ; Return
          (ret regs1 mem1 regs2 mem2))
        (foo2 regs0 mem0 regs2 mem2))))

; ----------------------------------------------------------------------
; Queries
; ----------------------------------------------------------------------
;
; We encode equivalence checking as reachability of a "bad" relation.
;
; If bad_* is SAT:
;   there exists a counterexample initial state that makes the two functions
;   disagree under the chosen notion of equivalence.
;
; If bad_* is UNSAT:
;   no such counterexample exists.

(declare-rel bad_obs ())
(declare-rel bad_full ())

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0  (Array (_ BitVec 64) (_ BitVec 8)))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1  (Array (_ BitVec 64) (_ BitVec 8)))
           (regs2 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem2  (Array (_ BitVec 64) (_ BitVec 8))))
    (=> (and
          (foo1 regs0 mem0 regs1 mem1)
          (foo2 regs0 mem0 regs2 mem2)
          ; bad_obs asks whether the two programs can disagree on what a caller
          ; normally observes at the function boundary.
          ;
          ; We compare:
          ; - a0: return value
          ; - ra, sp, s0: boundary/preserved registers
          ;
          ; We intentionally do NOT compare memory here.
          ;
          ; Z3 answers UNSAT:
          ; there is no initial state that makes these observables differ.
          (not (and
                 (= (get_reg regs1 reg_a0) (get_reg regs2 reg_a0))
                 (= (get_reg regs1 reg_ra) (get_reg regs2 reg_ra))
                 (= (get_reg regs1 reg_sp) (get_reg regs2 reg_sp))
                 (= (get_reg regs1 reg_s0) (get_reg regs2 reg_s0)))))
        bad_obs)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0  (Array (_ BitVec 64) (_ BitVec 8)))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1  (Array (_ BitVec 64) (_ BitVec 8)))
           (regs2 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem2  (Array (_ BitVec 64) (_ BitVec 8))))
    (=> (and
          (foo1 regs0 mem0 regs1 mem1)
          (foo2 regs0 mem0 regs2 mem2)
          ; bad_full asks a much stronger question:
          ; "Are the final states exactly equal, including memory?"
          ;
          ; Z3 answers SAT:
          ; foo1 stores temporary values in its stack frame, while foo2 leaves
          ; memory unchanged. Hence a model exists where mem1 != mem2 even
          ; though the returned value and preserved registers agree.
          (not (and
                 (= (get_reg regs1 reg_a0) (get_reg regs2 reg_a0))
                 (= (get_reg regs1 reg_ra) (get_reg regs2 reg_ra))
                 (= (get_reg regs1 reg_sp) (get_reg regs2 reg_sp))
                 (= (get_reg regs1 reg_s0) (get_reg regs2 reg_s0))
                 (= mem1 mem2))))
        bad_full)))

(echo "Observable equivalence query (expected: unsat)")
(query bad_obs)

(echo "Full final-state equality query (expected: sat)")
(query bad_full)
