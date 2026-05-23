(set-logic HORN)

; ----------------------------------------------------------------------
; Overview
; ----------------------------------------------------------------------
;
; This file demonstrates three different post-return equivalence notions for
; the same constant-folding example:
;
;   foo1 = unoptimized stack-based function
;   foo2 = optimized function that returns 3 directly
;
; The program relations here have explicit PC:
;
;   fooX(regs_in, mem_in, pc_in, regs_out, mem_out, pc_out)
;
; and we query three bad-state predicates:
;
;   bad_full : full machine-state equality
;   bad_abi  : ABI-level observable equality
;   bad_proj : ABI-level equality + projected memory equality
;
; Expected results:
;   bad_full -> sat
;   bad_abi  -> unsat
;   bad_proj -> unsat

; ----------------------------------------------------------------------
; Library
; ----------------------------------------------------------------------

(define-fun get_reg ((regs (Array (_ BitVec 5) (_ BitVec 64)))
                     (idx (_ BitVec 5))) (_ BitVec 64)
  (ite (= idx (_ bv0 5))
       (_ bv0 64)
       (select regs idx)))

(define-fun set_reg ((regs (Array (_ BitVec 5) (_ BitVec 64)))
                     (idx (_ BitVec 5))
                     (val (_ BitVec 64))) (Array (_ BitVec 5) (_ BitVec  64))
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
; Instruction relations with explicit PC
; ----------------------------------------------------------------------
;
; Operand order is semantic order:
;   addi(..., imm, rs1, rd)  corresponds to  addi rd, rs1, imm

(declare-rel addi
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (imm (_ BitVec 12)) (rs1 (_ BitVec 5)) (rd (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 rd
                               (bvadd (get_reg regs0 rs1)
                                      ((_ sign_extend 52) imm))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (addi regs0 mem0 pc0 regs1 mem1 pc1 imm rs1 rd))))

(declare-rel addiw
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (imm (_ BitVec 12)) (rs1 (_ BitVec 5)) (rd (_ BitVec 5)))
    (=> (and
          (= regs1
             (set_reg regs0 rd
               ((_ sign_extend 32)
                 ((_ extract 31 0)
                   (bvadd (get_reg regs0 rs1)
                          ((_ sign_extend 52) imm))))))
          (= mem1 mem0)
          (= pc1 (bvadd pc0 (_ bv4 64))))
        (addiw regs0 mem0 pc0 regs1 mem1 pc1 imm rs1 rd))))

(declare-rel sw
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (imm (_ BitVec 12)) (base (_ BitVec 5)) (rs2 (_ BitVec 5)))
    (=> (and
          (= regs1 regs0)
          (= mem1 (write_mem_word mem0
                                  (bvadd (get_reg regs0 base)
                                         ((_ sign_extend 52) imm))
                                  (get_reg regs0 rs2)))
          (= pc1 (bvadd pc0 (_ bv4 64))))
        (sw regs0 mem0 pc0 regs1 mem1 pc1 imm base rs2))))

(declare-rel lw
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (imm (_ BitVec 12)) (base (_ BitVec 5)) (rd (_ BitVec 5)))
    (=> (and
          (= regs1 (set_reg regs0 rd
                            (read_mem_word mem0
                                           (bvadd (get_reg regs0 base)
                                                  ((_ sign_extend 52) imm)))))
          (= mem1 mem0)
          (= pc1 (bvadd pc0 (_ bv4 64))))
        (lw regs0 mem0 pc0 regs1 mem1 pc1 imm base rd))))

(declare-rel sd
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (imm (_ BitVec 12)) (base (_ BitVec 5)) (rs2 (_ BitVec 5)))
    (=> (and
          (= regs1 regs0)
          (= mem1 (write_mem_dword mem0
                                   (bvadd (get_reg regs0 base)
                                          ((_ sign_extend 52) imm))
                                   (get_reg regs0 rs2)))
          (= pc1 (bvadd pc0 (_ bv4 64))))
        (sd regs0 mem0 pc0 regs1 mem1 pc1 imm base rs2))))

(declare-rel ld
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (imm (_ BitVec 12)) (base (_ BitVec 5)) (rd (_ BitVec 5)))
    (=> (and
          (= regs1 (set_reg regs0 rd
                            (read_mem_dword mem0
                                            (bvadd (get_reg regs0 base)
                                                   ((_ sign_extend 52) imm)))))
          (= mem1 mem0)
          (= pc1 (bvadd pc0 (_ bv4 64))))
        (ld regs0 mem0 pc0 regs1 mem1 pc1 imm base rd))))

; Return as an architectural boundary:
; - PC becomes the return address stored in ra
; - registers and memory otherwise unchanged
(declare-rel ret
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (get_reg regs0 reg_ra)))
        (ret regs0 mem0 pc0 regs1 mem1 pc1))))

; ----------------------------------------------------------------------
; Programs
; ----------------------------------------------------------------------

(declare-rel foo1
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)))

(rule
  (forall ((regs0  (Array (_ BitVec 5) (_ BitVec 64))) (mem0  (Array (_ BitVec 64) (_ BitVec 8))) (pc0  (_ BitVec 64))
           (regs1  (Array (_ BitVec 5) (_ BitVec 64))) (mem1  (Array (_ BitVec 64) (_ BitVec 8))) (pc1  (_ BitVec 64))
           (regs2  (Array (_ BitVec 5) (_ BitVec 64))) (mem2  (Array (_ BitVec 64) (_ BitVec 8))) (pc2  (_ BitVec 64))
           (regs3  (Array (_ BitVec 5) (_ BitVec 64))) (mem3  (Array (_ BitVec 64) (_ BitVec 8))) (pc3  (_ BitVec 64))
           (regs4  (Array (_ BitVec 5) (_ BitVec 64))) (mem4  (Array (_ BitVec 64) (_ BitVec 8))) (pc4  (_ BitVec 64))
           (regs5  (Array (_ BitVec 5) (_ BitVec 64))) (mem5  (Array (_ BitVec 64) (_ BitVec 8))) (pc5  (_ BitVec 64))
           (regs6  (Array (_ BitVec 5) (_ BitVec 64))) (mem6  (Array (_ BitVec 64) (_ BitVec 8))) (pc6  (_ BitVec 64))
           (regs7  (Array (_ BitVec 5) (_ BitVec 64))) (mem7  (Array (_ BitVec 64) (_ BitVec 8))) (pc7  (_ BitVec 64))
           (regs8  (Array (_ BitVec 5) (_ BitVec 64))) (mem8  (Array (_ BitVec 64) (_ BitVec 8))) (pc8  (_ BitVec 64))
           (regs9  (Array (_ BitVec 5) (_ BitVec 64))) (mem9  (Array (_ BitVec 64) (_ BitVec 8))) (pc9  (_ BitVec 64))
           (regs10 (Array (_ BitVec 5) (_ BitVec 64))) (mem10 (Array (_ BitVec 64) (_ BitVec 8))) (pc10 (_ BitVec 64))
           (regs11 (Array (_ BitVec 5) (_ BitVec 64))) (mem11 (Array (_ BitVec 64) (_ BitVec 8))) (pc11 (_ BitVec 64))
           (regs12 (Array (_ BitVec 5) (_ BitVec 64))) (mem12 (Array (_ BitVec 64) (_ BitVec 8))) (pc12 (_ BitVec 64))
           (regs13 (Array (_ BitVec 5) (_ BitVec 64))) (mem13 (Array (_ BitVec 64) (_ BitVec 8))) (pc13 (_ BitVec 64))
           (regs14 (Array (_ BitVec 5) (_ BitVec 64))) (mem14 (Array (_ BitVec 64) (_ BitVec 8))) (pc14 (_ BitVec 64)))
    (=> (and
          ; addi sp, sp, -32
          (addi regs0 mem0 pc0 regs1 mem1 pc1 (_ bv4064 12) reg_sp reg_sp)
          ; sd ra, 24(sp)
          (sd regs1 mem1 pc1 regs2 mem2 pc2 (_ bv24 12) reg_sp reg_ra)
          ; sd s0, 16(sp)
          (sd regs2 mem2 pc2 regs3 mem3 pc3 (_ bv16 12) reg_sp reg_s0)
          ; addi s0, sp, 32
          (addi regs3 mem3 pc3 regs4 mem4 pc4 (_ bv32 12) reg_sp reg_s0)
          ; addi a0, zero, 1
          (addi regs4 mem4 pc4 regs5 mem5 pc5 (_ bv1 12) reg_zero reg_a0)
          ; sw a0, -20(s0)
          (sw regs5 mem5 pc5 regs6 mem6 pc6 (_ bv4076 12) reg_s0 reg_a0)
          ; lw a0, -20(s0)
          (lw regs6 mem6 pc6 regs7 mem7 pc7 (_ bv4076 12) reg_s0 reg_a0)
          ; addiw a0, a0, 2
          (addiw regs7 mem7 pc7 regs8 mem8 pc8 (_ bv2 12) reg_a0 reg_a0)
          ; sw a0, -24(s0)
          (sw regs8 mem8 pc8 regs9 mem9 pc9 (_ bv4072 12) reg_s0 reg_a0)
          ; lw a0, -24(s0)
          (lw regs9 mem9 pc9 regs10 mem10 pc10 (_ bv4072 12) reg_s0 reg_a0)
          ; ld ra, 24(sp)
          (ld regs10 mem10 pc10 regs11 mem11 pc11 (_ bv24 12) reg_sp reg_ra)
          ; ld s0, 16(sp)
          (ld regs11 mem11 pc11 regs12 mem12 pc12 (_ bv16 12) reg_sp reg_s0)
          ; addi sp, sp, 32
          (addi regs12 mem12 pc12 regs13 mem13 pc13 (_ bv32 12) reg_sp reg_sp)
          ; jalr zero, 0(ra)
          (ret regs13 mem13 pc13 regs14 mem14 pc14))
        (foo1 regs0 mem0 pc0 regs14 mem14 pc14))))

(declare-rel foo2
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64))) (mem0 (Array (_ BitVec 64) (_ BitVec 8))) (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64))) (mem1 (Array (_ BitVec 64) (_ BitVec 8))) (pc1 (_ BitVec 64))
           (regs2 (Array (_ BitVec 5) (_ BitVec 64))) (mem2 (Array (_ BitVec 64) (_ BitVec 8))) (pc2 (_ BitVec 64)))
    (=> (and
          ; addi a0, zero, 3
          (addi regs0 mem0 pc0 regs1 mem1 pc1 (_ bv3 12) reg_zero reg_a0)
          ; jalr zero, 0(ra)
          (ret regs1 mem1 pc1 regs2 mem2 pc2))
        (foo2 regs0 mem0 pc0 regs2 mem2 pc2))))

; ----------------------------------------------------------------------
; Observable-address predicate
; ----------------------------------------------------------------------
;
; We define the initial stack frame [sp0 - 32, sp0) as private/dead memory.
; All addresses outside that interval are observable.
;
; This interpretation assumes the initial stack pointer is at least 32, so that
; the frame does not wrap around modulo 2^64.

(declare-rel obs_addr ((_ BitVec 64) (_ BitVec 64)))

(rule
  (forall ((sp0 (_ BitVec 64)) (a (_ BitVec 64)))
    (=> (or (bvult a (bvsub sp0 (_ bv32 64)))
            (bvuge a sp0))
        (obs_addr sp0 a))))

; ----------------------------------------------------------------------
; Queries
; ----------------------------------------------------------------------

(declare-rel bad_full ())
(declare-rel bad_abi ())
(declare-rel bad_proj ())

; Full equality of pc, full register file, and full memory
(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0  (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0   (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1  (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1   (_ BitVec 64))
           (regs2 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem2  (Array (_ BitVec 64) (_ BitVec 8)))
           (pc2   (_ BitVec 64)))
    (=> (and
          ; Avoid modular wraparound of the private frame interval.
          (bvuge pc0 (_ bv0 64))
          (bvuge (get_reg regs0 reg_sp) (_ bv32 64))
          (foo1 regs0 mem0 pc0 regs1 mem1 pc1)
          (foo2 regs0 mem0 pc0 regs2 mem2 pc2)
          (not (and (= pc1 pc2) (= regs1 regs2) (= mem1 mem2))))
        bad_full)))

; ABI-level equivalence: compare only caller-visible outputs
(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0  (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0   (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1  (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1   (_ BitVec 64))
           (regs2 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem2  (Array (_ BitVec 64) (_ BitVec 8)))
           (pc2   (_ BitVec 64)))
    (=> (and
          ; Same well-formed stack assumption as above.
          (bvuge (get_reg regs0 reg_sp) (_ bv32 64))
          (foo1 regs0 mem0 pc0 regs1 mem1 pc1)
          (foo2 regs0 mem0 pc0 regs2 mem2 pc2)
          (not (and
                 (= pc1 pc2)
                 (= (get_reg regs1 reg_a0) (get_reg regs2 reg_a0))
                 (= (get_reg regs1 reg_ra) (get_reg regs2 reg_ra))
                 (= (get_reg regs1 reg_sp) (get_reg regs2 reg_sp))
                 (= (get_reg regs1 reg_s0) (get_reg regs2 reg_s0)))))
        bad_abi)))

; ABI-level equivalence + equality on observable memory only
(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0  (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0   (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1  (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1   (_ BitVec 64))
           (regs2 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem2  (Array (_ BitVec 64) (_ BitVec 8)))
           (pc2   (_ BitVec 64))
           (sp0   (_ BitVec 64))
           (a     (_ BitVec 64)))
    (=> (and
          (= sp0 (get_reg regs0 reg_sp))
          ; Without this, stack-frame addresses may wrap modulo 2^64 and escape
          ; the intended "private frame" interval.
          (bvuge sp0 (_ bv32 64))
          (foo1 regs0 mem0 pc0 regs1 mem1 pc1)
          (foo2 regs0 mem0 pc0 regs2 mem2 pc2)
          (= pc1 pc2)
          (= (get_reg regs1 reg_a0) (get_reg regs2 reg_a0))
          (= (get_reg regs1 reg_ra) (get_reg regs2 reg_ra))
          (= (get_reg regs1 reg_sp) (get_reg regs2 reg_sp))
          (= (get_reg regs1 reg_s0) (get_reg regs2 reg_s0))
          (obs_addr sp0 a)
          (not (= (select mem1 a) (select mem2 a))))
        bad_proj)))

(echo "Full machine-state equality (expected: sat)")
(query bad_full)

(echo "ABI-level equality (expected: unsat)")
(query bad_abi)

(echo "Projected-memory equality (expected: unsat)")
(query bad_proj)
