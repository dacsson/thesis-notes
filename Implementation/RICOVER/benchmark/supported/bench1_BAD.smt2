(set-logic HORN)

;; ============================================================
;; RICOVER CHC Standard Library
;; State representation and register/memory operations
;; for RISC-V 64-bit (RV64)
;; ============================================================

;; --- State representation ---
;; State = (PC: BV64, Regs: Array(BV5 -> BV64), Mem: Array(BV64 -> BV8))
;;
;; Regs maps 5-bit register index to 64-bit value.
;; x0 (zero) is handled by always reading 0 regardless of array contents.
;; Mem is byte-addressable.

;; --- Register operations ---

;; Read register: returns 0 for x0, otherwise reads from Regs array
;; get_reg(regs, idx) = ite(idx == 0, 0, select(regs, idx))
(define-fun get_reg ((regs (Array (_ BitVec 5) (_ BitVec 64)))
                     (idx (_ BitVec 5))) (_ BitVec 64)
  (ite (= idx (_ bv0 5))
       (_ bv0 64)
       (select regs idx)))

;; Write register: writes to x0 are discarded
;; set_reg(regs, idx, val) = ite(idx == 0, regs, store(regs, idx, val))
(define-fun set_reg ((regs (Array (_ BitVec 5) (_ BitVec 64)))
                     (idx (_ BitVec 5))
                     (val (_ BitVec 64))) (Array (_ BitVec 5) (_ BitVec 64))
  (ite (= idx (_ bv0 5))
       regs
       (store regs idx val)))

;; --- Memory operations (byte-addressable, little-endian) ---
;;
;; Two families of read functions:
;;   - mem_read_N:     raw reads returning BV(N*8), no extension.
;;                     Used by the IR transpiler — the IR path's own EXTS/EXTZ
;;                     handles sign/zero extension.
;;   - read_mem_word/dword/byte/half:  reads returning BV64 (sign-extended).
;;                     Used by hand-written assembly rules (lw, ld, lb, lh)
;;                     where the instruction semantics bake in sign extension.

;; --- Raw reads (actual width, no extension) — for IR transpiler ---

;; Read 1 byte, returns BV8
(define-fun mem_read_1 ((mem (Array (_ BitVec 64) (_ BitVec 8)))
                        (addr (_ BitVec 64))) (_ BitVec 8)
  (select mem addr))

;; Read 2 bytes (halfword), returns BV16, little-endian
(define-fun mem_read_2 ((mem (Array (_ BitVec 64) (_ BitVec 8)))
                        (addr (_ BitVec 64))) (_ BitVec 16)
  (concat (select mem (bvadd addr (_ bv1 64)))
          (select mem addr)))

;; Read 4 bytes (word), returns BV32, little-endian
(define-fun mem_read_4 ((mem (Array (_ BitVec 64) (_ BitVec 8)))
                        (addr (_ BitVec 64))) (_ BitVec 32)
  (concat (select mem (bvadd addr (_ bv3 64)))
          (concat (select mem (bvadd addr (_ bv2 64)))
                  (concat (select mem (bvadd addr (_ bv1 64)))
                          (select mem addr)))))

;; Read 8 bytes (doubleword), returns BV64, little-endian
(define-fun mem_read_8 ((mem (Array (_ BitVec 64) (_ BitVec 8)))
                        (addr (_ BitVec 64))) (_ BitVec 64)
  (concat (select mem (bvadd addr (_ bv7 64)))
          (concat (select mem (bvadd addr (_ bv6 64)))
                  (concat (select mem (bvadd addr (_ bv5 64)))
                          (concat (select mem (bvadd addr (_ bv4 64)))
                                  (concat (select mem (bvadd addr (_ bv3 64)))
                                          (concat (select mem (bvadd addr (_ bv2 64)))
                                                  (concat (select mem (bvadd addr (_ bv1 64)))
                                                          (select mem addr)))))))))

;; --- Sign-extending reads (return BV64) — for hand-written assembly rules ---

;; Read 1 byte from memory, sign-extended to 64 bits (for lb)
(define-fun read_mem_byte ((mem (Array (_ BitVec 64) (_ BitVec 8)))
                           (addr (_ BitVec 64))) (_ BitVec 64)
  ((_ sign_extend 56) (select mem addr)))

;; Read 2 bytes (halfword) from memory, sign-extended to 64 bits (for lh)
(define-fun read_mem_half ((mem (Array (_ BitVec 64) (_ BitVec 8)))
                           (addr (_ BitVec 64))) (_ BitVec 64)
  ((_ sign_extend 48)
    (concat (select mem (bvadd addr (_ bv1 64)))
            (select mem addr))))

;; Read 4 bytes (word) from memory, sign-extended to 64 bits (for lw)
(define-fun read_mem_word ((mem (Array (_ BitVec 64) (_ BitVec 8)))
                           (addr (_ BitVec 64))) (_ BitVec 64)
  ((_ sign_extend 32)
    (concat (select mem (bvadd addr (_ bv3 64)))
            (concat (select mem (bvadd addr (_ bv2 64)))
                    (concat (select mem (bvadd addr (_ bv1 64)))
                            (select mem addr))))))

;; Read 8 bytes (doubleword) from memory (for ld)
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

;; --- Memory writes (little-endian) ---
;; Write functions take BV64 values and extract the appropriate low bytes.

;; Write 1 byte to memory (for sb)
(define-fun write_mem_byte ((mem (Array (_ BitVec 64) (_ BitVec 8)))
                            (addr (_ BitVec 64))
                            (val (_ BitVec 64))) (Array (_ BitVec 64) (_ BitVec 8))
  (store mem addr ((_ extract 7 0) val)))

;; Write 2 bytes (halfword) to memory, little-endian (for sh)
(define-fun write_mem_half ((mem (Array (_ BitVec 64) (_ BitVec 8)))
                            (addr (_ BitVec 64))
                            (val (_ BitVec 64))) (Array (_ BitVec 64) (_ BitVec 8))
  (store (store mem
    addr                       ((_ extract 7 0) val))
    (bvadd addr (_ bv1 64))    ((_ extract 15 8) val)))

;; Write 4 bytes (word) to memory (little-endian)
(define-fun write_mem_word ((mem (Array (_ BitVec 64) (_ BitVec 8)))
                            (addr (_ BitVec 64))
                            (val (_ BitVec 64))) (Array (_ BitVec 64) (_ BitVec 8))
  (store (store (store (store mem
    addr                       ((_ extract 7 0) val))
    (bvadd addr (_ bv1 64))    ((_ extract 15 8) val))
    (bvadd addr (_ bv2 64))    ((_ extract 23 16) val))
    (bvadd addr (_ bv3 64))    ((_ extract 31 24) val)))

;; Write 8 bytes (doubleword) to memory (little-endian)
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

;; --- Register index constants (ABI names) ---
(define-fun reg_zero () (_ BitVec 5) (_ bv0 5))
(define-fun reg_ra   () (_ BitVec 5) (_ bv1 5))
(define-fun reg_sp   () (_ BitVec 5) (_ bv2 5))
(define-fun reg_s0   () (_ BitVec 5) (_ bv8 5))
(define-fun reg_a0   () (_ BitVec 5) (_ bv10 5))


; ======================================================================
; Programs (instruction semantics inlined)
; ======================================================================

;; ── bench1_BAD1 (1 blocks) ──

(declare-rel bench1_BAD1_bb0
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64))) (mem0 (Array (_ BitVec 64) (_ BitVec 8))) (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64))) (pc1 (_ BitVec 64))
           (regs2 (Array (_ BitVec 5) (_ BitVec 64))) (pc2 (_ BitVec 64))
           (regs3 (Array (_ BitVec 5) (_ BitVec 64))) (pc3 (_ BitVec 64))
           (regs4 (Array (_ BitVec 5) (_ BitVec 64))) (pc4 (_ BitVec 64))
           (regs5 (Array (_ BitVec 5) (_ BitVec 64))) (pc5 (_ BitVec 64))
           (regs6 (Array (_ BitVec 5) (_ BitVec 64))) (pc6 (_ BitVec 64))
           (regs7 (Array (_ BitVec 5) (_ BitVec 64))) (pc7 (_ BitVec 64))
           (regs8 (Array (_ BitVec 5) (_ BitVec 64))) (pc8 (_ BitVec 64))
           (regs9 (Array (_ BitVec 5) (_ BitVec 64))) (pc9 (_ BitVec 64))
           (regs10 (Array (_ BitVec 5) (_ BitVec 64))) (pc10 (_ BitVec 64)))
    (=> (and
          ; slli a2, a0, 56
          (= regs1 (set_reg regs0 (_ bv12 5) (bvshl (get_reg regs0 reg_a0) ((_ zero_extend 58) ((_ extract 5 0) (_ bv56 6))))))
          (= pc1 (bvadd pc0 (_ bv4 64)))
          ; sll a0, a0, a1
          (= regs2 (set_reg regs1 reg_a0 (bvshl (get_reg regs1 reg_a0) ((_ zero_extend 58) ((_ extract 5 0) (get_reg regs1 (_ bv11 5)))))))
          (= pc2 (bvadd pc1 (_ bv4 64)))
          ; srai a2, a2, 56
          (= regs3 (set_reg regs2 (_ bv12 5) (bvashr (get_reg regs2 (_ bv12 5)) ((_ zero_extend 58) ((_ extract 5 0) (_ bv56 6))))))
          (= pc3 (bvadd pc2 (_ bv4 64)))
          ; zext.b a0, a0
          (= regs4 (set_reg regs3 reg_a0 (bvand (get_reg regs3 reg_a0) ((_ sign_extend 52) (_ bv255 12)))))
          (= pc4 (bvadd pc3 (_ bv4 64)))
          ; srl a0, a0, a1
          (= regs5 (set_reg regs4 reg_a0 (bvlshr (get_reg regs4 reg_a0) ((_ zero_extend 58) ((_ extract 5 0) (get_reg regs4 (_ bv11 5)))))))
          (= pc5 (bvadd pc4 (_ bv4 64)))
          ; slli a0, a0, 56
          (= regs6 (set_reg regs5 reg_a0 (bvshl (get_reg regs5 reg_a0) ((_ zero_extend 58) ((_ extract 5 0) (_ bv56 6))))))
          (= pc6 (bvadd pc5 (_ bv4 64)))
          ; srai a0, a0, 56
          (= regs7 (set_reg regs6 reg_a0 (bvashr (get_reg regs6 reg_a0) ((_ zero_extend 58) ((_ extract 5 0) (_ bv56 6))))))
          (= pc7 (bvadd pc6 (_ bv4 64)))
          ; slt a0, a0, a2
          (= regs8 (set_reg regs7 reg_a0 ((_ zero_extend 63) (ite (bvslt (get_reg regs7 reg_a0) (get_reg regs7 (_ bv12 5))) (_ bv1 1) (_ bv0 1)))))
          (= pc8 (bvadd pc7 (_ bv4 64)))
          ; xori a0, a0, 1
          (= regs9 (set_reg regs8 reg_a0 (bvxor (get_reg regs8 reg_a0) ((_ sign_extend 52) (_ bv1 12)))))
          (= pc9 (bvadd pc8 (_ bv4 64)))
          ; ret
          (= regs10 (set_reg regs9 reg_zero (bvadd pc9 (_ bv4 64))))
          (= pc10 (concat ((_ extract 63 1) (bvadd (get_reg regs9 reg_ra) ((_ sign_extend 52) (_ bv0 12)))) (_ bv0 1)))
        )
        (bench1_BAD1_bb0 regs0 mem0 pc0 regs10 mem0 pc10))))

(declare-rel bench1_BAD1
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64)))
    (=> (bench1_BAD1_bb0 regs0 mem0 pc0 regs1 mem1 pc1)
        (bench1_BAD1 regs0 mem0 pc0 regs1 mem1 pc1))))

;; ── bench1_BAD2 (1 blocks) ──

(declare-rel bench1_BAD2_bb0
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64))) (mem0 (Array (_ BitVec 64) (_ BitVec 8))) (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64))) (pc1 (_ BitVec 64))
           (regs2 (Array (_ BitVec 5) (_ BitVec 64))) (pc2 (_ BitVec 64))
           (regs3 (Array (_ BitVec 5) (_ BitVec 64))) (pc3 (_ BitVec 64))
           (regs4 (Array (_ BitVec 5) (_ BitVec 64))) (pc4 (_ BitVec 64))
           (regs5 (Array (_ BitVec 5) (_ BitVec 64))) (pc5 (_ BitVec 64))
           (regs6 (Array (_ BitVec 5) (_ BitVec 64))) (pc6 (_ BitVec 64))
           (regs7 (Array (_ BitVec 5) (_ BitVec 64))) (pc7 (_ BitVec 64))
           (regs8 (Array (_ BitVec 5) (_ BitVec 64))) (pc8 (_ BitVec 64))
           (regs9 (Array (_ BitVec 5) (_ BitVec 64))) (pc9 (_ BitVec 64)))
    (=> (and
          ; slli a0, a0, 56
          (= regs1 (set_reg regs0 reg_a0 (bvshl (get_reg regs0 reg_a0) ((_ zero_extend 58) ((_ extract 5 0) (_ bv56 6))))))
          (= pc1 (bvadd pc0 (_ bv4 64)))
          ; li a2, 255
          (= regs2 (set_reg regs1 (_ bv12 5) (bvadd (get_reg regs1 reg_zero) ((_ sign_extend 52) (_ bv255 12)))))
          (= pc2 (bvadd pc1 (_ bv4 64)))
          ; srai a0, a0, 56
          (= regs3 (set_reg regs2 reg_a0 (bvashr (get_reg regs2 reg_a0) ((_ zero_extend 58) ((_ extract 5 0) (_ bv56 6))))))
          (= pc3 (bvadd pc2 (_ bv4 64)))
          ; srl a1, a2, a1
          (= regs4 (set_reg regs3 (_ bv11 5) (bvlshr (get_reg regs3 (_ bv12 5)) ((_ zero_extend 58) ((_ extract 5 0) (get_reg regs3 (_ bv11 5)))))))
          (= pc4 (bvadd pc3 (_ bv4 64)))
          ; slli a1, a1, 56
          (= regs5 (set_reg regs4 (_ bv11 5) (bvshl (get_reg regs4 (_ bv11 5)) ((_ zero_extend 58) ((_ extract 5 0) (_ bv56 6))))))
          (= pc5 (bvadd pc4 (_ bv4 64)))
          ; srai a1, a1, 56
          (= regs6 (set_reg regs5 (_ bv11 5) (bvashr (get_reg regs5 (_ bv11 5)) ((_ zero_extend 58) ((_ extract 5 0) (_ bv56 6))))))
          (= pc6 (bvadd pc5 (_ bv4 64)))
          ; slt a0, a1, a0
          (= regs7 (set_reg regs6 reg_a0 ((_ zero_extend 63) (ite (bvslt (get_reg regs6 (_ bv11 5)) (get_reg regs6 reg_a0)) (_ bv1 1) (_ bv0 1)))))
          (= pc7 (bvadd pc6 (_ bv4 64)))
          ; xori a0, a0, 1
          (= regs8 (set_reg regs7 reg_a0 (bvxor (get_reg regs7 reg_a0) ((_ sign_extend 52) (_ bv1 12)))))
          (= pc8 (bvadd pc7 (_ bv4 64)))
          ; ret
          (= regs9 (set_reg regs8 reg_zero (bvadd pc8 (_ bv4 64))))
          (= pc9 (concat ((_ extract 63 1) (bvadd (get_reg regs8 reg_ra) ((_ sign_extend 52) (_ bv0 12)))) (_ bv0 1)))
        )
        (bench1_BAD2_bb0 regs0 mem0 pc0 regs9 mem0 pc9))))

(declare-rel bench1_BAD2
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64)))
    (=> (bench1_BAD2_bb0 regs0 mem0 pc0 regs1 mem1 pc1)
        (bench1_BAD2 regs0 mem0 pc0 regs1 mem1 pc1))))

; ======================================================================
; Observable-address predicate
; ======================================================================
;
; The initial stack frame [sp0 - 0, sp0) is private/dead memory.
; All addresses outside that interval are observable.

(declare-rel obs_addr ((_ BitVec 64) (_ BitVec 64)))

(rule
  (forall ((sp0 (_ BitVec 64)) (a (_ BitVec 64)))
    (=> (or (bvult a (bvsub sp0 (_ bv0 64)))
            (bvuge a sp0))
        (obs_addr sp0 a))))

; ======================================================================
; Equivalence query
; ======================================================================
;
; ABI-level registers + projected memory (ignore stack-allocated memory).
; UNSAT = equivalent, SAT = counterexample found.

(declare-rel bad ())

; ABI register a0 divergence
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
           (sp0   (_ BitVec 64)))
    (=> (and
          (= sp0 (get_reg regs0 reg_sp))
          (bvuge sp0 (_ bv0 64))
          (bench1_BAD1 regs0 mem0 pc0 regs1 mem1 pc1)
          (bench1_BAD2 regs0 mem0 pc0 regs2 mem2 pc2)
          (not (= (get_reg regs1 reg_a0) (get_reg regs2 reg_a0))))
        bad)))

; ABI register ra divergence
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
           (sp0   (_ BitVec 64)))
    (=> (and
          (= sp0 (get_reg regs0 reg_sp))
          (bvuge sp0 (_ bv0 64))
          (bench1_BAD1 regs0 mem0 pc0 regs1 mem1 pc1)
          (bench1_BAD2 regs0 mem0 pc0 regs2 mem2 pc2)
          (not (= (get_reg regs1 reg_ra) (get_reg regs2 reg_ra))))
        bad)))

; ABI register sp divergence
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
           (sp0   (_ BitVec 64)))
    (=> (and
          (= sp0 (get_reg regs0 reg_sp))
          (bvuge sp0 (_ bv0 64))
          (bench1_BAD1 regs0 mem0 pc0 regs1 mem1 pc1)
          (bench1_BAD2 regs0 mem0 pc0 regs2 mem2 pc2)
          (not (= (get_reg regs1 reg_sp) (get_reg regs2 reg_sp))))
        bad)))

; ABI register s0 divergence
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
           (sp0   (_ BitVec 64)))
    (=> (and
          (= sp0 (get_reg regs0 reg_sp))
          (bvuge sp0 (_ bv0 64))
          (bench1_BAD1 regs0 mem0 pc0 regs1 mem1 pc1)
          (bench1_BAD2 regs0 mem0 pc0 regs2 mem2 pc2)
          (not (= (get_reg regs1 reg_s0) (get_reg regs2 reg_s0))))
        bad)))

; ABI register pc divergence
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
           (sp0   (_ BitVec 64)))
    (=> (and
          (= sp0 (get_reg regs0 reg_sp))
          (bvuge sp0 (_ bv0 64))
          (bench1_BAD1 regs0 mem0 pc0 regs1 mem1 pc1)
          (bench1_BAD2 regs0 mem0 pc0 regs2 mem2 pc2)
          (not (= pc1 pc2)))
        bad)))

; Observable memory divergence
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
          (bvuge sp0 (_ bv0 64))
          (bench1_BAD1 regs0 mem0 pc0 regs1 mem1 pc1)
          (bench1_BAD2 regs0 mem0 pc0 regs2 mem2 pc2)
          (obs_addr sp0 a)
          (not (= (select mem1 a) (select mem2 a))))
        bad)))

(query bad)
