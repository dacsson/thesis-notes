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
; IR-derived instruction rules (from Sail spec via Isla)
; ======================================================================

;; Found 739 instruction variant(s) in execute function

;; --- ZICBOP instruction (from Isla IR [2..10)) ---
(declare-rel zicbop
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 12)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 12)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (zicbop regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- NTL instruction (from Isla IR [11..13)) ---
(declare-rel ntl
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (ntl regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- C_NTL instruction (from Isla IR [14..16)) ---
(declare-rel c_ntl
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_ntl regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- PAUSE instruction (from Isla IR [17..19)) ---
(declare-rel pause
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (pause regs0 mem0 pc0 regs1 mem1 pc1))))

;; SKIPPED variant LPAD — unsupported Sail function call: is_landing_pad_expected((_ unit))

;; --- LUI instruction (from Isla IR [105..129)+[130..132)+[141..146)) ---
(declare-rel lui
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 20)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 20))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p1 ((_ sign_extend 32) (concat p0 (_ bv0 12)))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (lui regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; SKIPPED variant AUIPC — unsupported Sail function call: get_arch_pc((_ unit))

;; --- JAL instruction (from Isla IR [147..182)) ---
(declare-rel jal
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 21)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 21))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p1 (bvadd pc0 (_ bv4 64))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 ((_ sign_extend 43) p0))))
        (jal regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- BEQ instruction (from Isla IR [183..193)+[194..204)+[257..279)) ---
(declare-rel beq
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 13)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 13))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (ite (= (get_reg regs0 p2) (get_reg regs0 p1)) (bvadd pc0 ((_ sign_extend 51) p0)) (bvadd pc0 (_ bv4 64)))))
        (beq regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- BNE instruction (from Isla IR [183..193)+[205..215)+[257..279)) ---
(declare-rel bne
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 13)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 13))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (ite (not (= (get_reg regs0 p2) (get_reg regs0 p1))) (bvadd pc0 ((_ sign_extend 51) p0)) (bvadd pc0 (_ bv4 64)))))
        (bne regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- BLT instruction (from Isla IR [183..193)+[216..226)+[257..279)) ---
(declare-rel blt
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 13)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 13))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (ite (bvslt (get_reg regs0 p2) (get_reg regs0 p1)) (bvadd pc0 ((_ sign_extend 51) p0)) (bvadd pc0 (_ bv4 64)))))
        (blt regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- BGE instruction (from Isla IR [183..193)+[227..237)+[257..279)) ---
(declare-rel bge
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 13)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 13))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (ite (bvsge (get_reg regs0 p2) (get_reg regs0 p1)) (bvadd pc0 ((_ sign_extend 51) p0)) (bvadd pc0 (_ bv4 64)))))
        (bge regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- BLTU instruction (from Isla IR [183..193)+[238..248)+[257..279)) ---
(declare-rel bltu
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 13)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 13))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (ite (bvult (get_reg regs0 p2) (get_reg regs0 p1)) (bvadd pc0 ((_ sign_extend 51) p0)) (bvadd pc0 (_ bv4 64)))))
        (bltu regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- BGEU instruction (from Isla IR [183..193)+[248..257)+[257..279)) ---
(declare-rel bgeu
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 13)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 13))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (ite (bvuge (get_reg regs0 p2) (get_reg regs0 p1)) (bvadd pc0 ((_ sign_extend 51) p0)) (bvadd pc0 (_ bv4 64)))))
        (bgeu regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- ADDI instruction (from Isla IR [280..298)+[299..309)+[378..383)) ---
(declare-rel addi
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvadd (get_reg regs0 p1) ((_ sign_extend 52) p0))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (addi regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SLTI instruction (from Isla IR [280..298)+[310..328)+[378..383)) ---
(declare-rel slti
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ zero_extend 63) (ite (bvslt (get_reg regs0 p1) ((_ sign_extend 52) p0)) (_ bv1 1) (_ bv0 1)))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (slti regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SLTIU instruction (from Isla IR [280..298)+[329..347)+[378..383)) ---
(declare-rel sltiu
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ zero_extend 63) (ite (bvult (get_reg regs0 p1) ((_ sign_extend 52) p0)) (_ bv1 1) (_ bv0 1)))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sltiu regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- ANDI instruction (from Isla IR [280..298)+[348..358)+[378..383)) ---
(declare-rel andi
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvand (get_reg regs0 p1) ((_ sign_extend 52) p0))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (andi regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- ORI instruction (from Isla IR [280..298)+[359..369)+[378..383)) ---
(declare-rel ori
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvor (get_reg regs0 p1) ((_ sign_extend 52) p0))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (ori regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- XORI instruction (from Isla IR [280..298)+[369..378)+[378..383)) ---
(declare-rel xori
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvxor (get_reg regs0 p1) ((_ sign_extend 52) p0))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (xori regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SLLI instruction (from Isla IR [384..412)+[413..423)+[443..448)) ---
(declare-rel slli
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 6)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 6))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvshl (get_reg regs0 p1) ((_ zero_extend 58) ((_ extract 5 0) p0)))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (slli regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SRLI instruction (from Isla IR [384..412)+[424..434)+[443..448)) ---
(declare-rel srli
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 6)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 6))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvlshr (get_reg regs0 p1) ((_ zero_extend 58) ((_ extract 5 0) p0)))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (srli regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SRAI instruction (from Isla IR [384..412)+[434..443)+[443..448)) ---
(declare-rel srai
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 6)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 6))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvashr (get_reg regs0 p1) ((_ zero_extend 58) ((_ extract 5 0) p0)))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (srai regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- ADD instruction (from Isla IR [449..459)+[460..472)+[657..662)) ---
(declare-rel add
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvadd (get_reg regs0 p1) (get_reg regs0 p0))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (add regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SLT instruction (from Isla IR [449..459)+[473..493)+[657..662)) ---
(declare-rel slt
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ zero_extend 63) (ite (bvslt (get_reg regs0 p1) (get_reg regs0 p0)) (_ bv1 1) (_ bv0 1)))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (slt regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SLTU instruction (from Isla IR [449..459)+[494..514)+[657..662)) ---
(declare-rel sltu
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ zero_extend 63) (ite (bvult (get_reg regs0 p1) (get_reg regs0 p0)) (_ bv1 1) (_ bv0 1)))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sltu regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- AND instruction (from Isla IR [449..459)+[515..527)+[657..662)) ---
(declare-rel and
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvand (get_reg regs0 p1) (get_reg regs0 p0))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (and regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- OR instruction (from Isla IR [449..459)+[528..540)+[657..662)) ---
(declare-rel or
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvor (get_reg regs0 p1) (get_reg regs0 p0))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (or regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- XOR instruction (from Isla IR [449..459)+[541..553)+[657..662)) ---
(declare-rel xor
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvxor (get_reg regs0 p1) (get_reg regs0 p0))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (xor regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SLL instruction (from Isla IR [449..459)+[554..584)+[657..662)) ---
(declare-rel sll
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvshl (get_reg regs0 p1) ((_ zero_extend 58) ((_ extract 5 0) (get_reg regs0 p0))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sll regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SRL instruction (from Isla IR [449..459)+[585..615)+[657..662)) ---
(declare-rel srl
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvlshr (get_reg regs0 p1) ((_ zero_extend 58) ((_ extract 5 0) (get_reg regs0 p0))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (srl regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SUB instruction (from Isla IR [449..459)+[616..628)+[657..662)) ---
(declare-rel sub
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvsub (get_reg regs0 p1) (get_reg regs0 p0))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sub regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SRA instruction (from Isla IR [449..459)+[628..657)+[657..662)) ---
(declare-rel sra
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvashr (get_reg regs0 p1) ((_ zero_extend 58) ((_ extract 5 0) (get_reg regs0 p0))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sra regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- load_1_s instruction (from Isla IR [663..697)+[698..706)) ---
(declare-rel load_1_s
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 56) (mem_read_1 mem0 (bvadd (get_reg regs0 p1) ((_ sign_extend 52) p0))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (load_1_s regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- load_1_u instruction (from Isla IR [663..697)+[698..706)) ---
(declare-rel load_1_u
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ zero_extend 56) (mem_read_1 mem0 (bvadd (get_reg regs0 p1) ((_ sign_extend 52) p0))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (load_1_u regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- load_2_s instruction (from Isla IR [663..697)+[698..706)) ---
(declare-rel load_2_s
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 48) (mem_read_2 mem0 (bvadd (get_reg regs0 p1) ((_ sign_extend 52) p0))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (load_2_s regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- load_2_u instruction (from Isla IR [663..697)+[698..706)) ---
(declare-rel load_2_u
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ zero_extend 48) (mem_read_2 mem0 (bvadd (get_reg regs0 p1) ((_ sign_extend 52) p0))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (load_2_u regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- load_4_s instruction (from Isla IR [663..697)+[698..706)) ---
(declare-rel load_4_s
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 32) (mem_read_4 mem0 (bvadd (get_reg regs0 p1) ((_ sign_extend 52) p0))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (load_4_s regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- load_4_u instruction (from Isla IR [663..697)+[698..706)) ---
(declare-rel load_4_u
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ zero_extend 32) (mem_read_4 mem0 (bvadd (get_reg regs0 p1) ((_ sign_extend 52) p0))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (load_4_u regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- load_8_s instruction (from Isla IR [663..697)+[698..706)) ---
(declare-rel load_8_s
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 0) (mem_read_8 mem0 (bvadd (get_reg regs0 p1) ((_ sign_extend 52) p0))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (load_8_s regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- load_8_u instruction (from Isla IR [663..697)+[698..706)) ---
(declare-rel load_8_u
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ zero_extend 0) (mem_read_8 mem0 (bvadd (get_reg regs0 p1) ((_ sign_extend 52) p0))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (load_8_u regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- store_1 instruction (from Isla IR [712..770)+[771..773)) ---
(declare-rel store_1
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 (write_mem_byte mem0 (bvadd (get_reg regs0 p2) ((_ sign_extend 52) p0)) ((_ zero_extend 56) ((_ extract 7 0) (get_reg regs0 p1)))))
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (store_1 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- store_2 instruction (from Isla IR [712..770)+[771..773)) ---
(declare-rel store_2
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 (write_mem_half mem0 (bvadd (get_reg regs0 p2) ((_ sign_extend 52) p0)) ((_ zero_extend 48) ((_ extract 15 0) (get_reg regs0 p1)))))
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (store_2 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- store_4 instruction (from Isla IR [712..770)+[771..773)) ---
(declare-rel store_4
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 (write_mem_word mem0 (bvadd (get_reg regs0 p2) ((_ sign_extend 52) p0)) ((_ zero_extend 32) ((_ extract 31 0) (get_reg regs0 p1)))))
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (store_4 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- store_8 instruction (from Isla IR [712..770)+[771..773)) ---
(declare-rel store_8
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 (write_mem_dword mem0 (bvadd (get_reg regs0 p2) ((_ sign_extend 52) p0)) ((_ extract 63 0) (get_reg regs0 p1))))
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (store_8 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- ADDIW instruction (from Isla IR [779..825)) ---
(declare-rel addiw
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 32) ((_ extract 31 0) (bvadd (get_reg regs0 p1) ((_ sign_extend 52) p0))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (addiw regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- ADDW instruction (from Isla IR [826..860)+[861..869)+[933..946)) ---
(declare-rel addw
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 32) (bvadd ((_ extract 31 0) (get_reg regs0 p1)) ((_ extract 31 0) (get_reg regs0 p0))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (addw regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SUBW instruction (from Isla IR [826..860)+[870..878)+[933..946)) ---
(declare-rel subw
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 32) (bvsub ((_ extract 31 0) (get_reg regs0 p1)) ((_ extract 31 0) (get_reg regs0 p0))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (subw regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SLLW instruction (from Isla IR [826..860)+[879..897)+[933..946)) ---
(declare-rel sllw
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 32) (bvshl ((_ extract 31 0) (get_reg regs0 p1)) ((_ zero_extend 27) ((_ extract 4 0) ((_ extract 31 0) (get_reg regs0 p0))))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sllw regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SRLW instruction (from Isla IR [826..860)+[898..916)+[933..946)) ---
(declare-rel srlw
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 32) (bvlshr ((_ extract 31 0) (get_reg regs0 p1)) ((_ zero_extend 27) ((_ extract 4 0) ((_ extract 31 0) (get_reg regs0 p0))))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (srlw regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SRAW instruction (from Isla IR [826..860)+[916..933)+[933..946)) ---
(declare-rel sraw
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 32) (bvashr ((_ extract 31 0) (get_reg regs0 p1)) ((_ zero_extend 27) ((_ extract 4 0) ((_ extract 31 0) (get_reg regs0 p0))))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sraw regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SLLIW instruction (from Isla IR [947..969)+[970..978)+[994..1007)) ---
(declare-rel slliw
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 32) (bvshl ((_ extract 31 0) (get_reg regs0 p1)) ((_ zero_extend 27) p0)))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (slliw regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SRLIW instruction (from Isla IR [947..969)+[979..987)+[994..1007)) ---
(declare-rel srliw
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 32) (bvlshr ((_ extract 31 0) (get_reg regs0 p1)) ((_ zero_extend 27) p0)))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (srliw regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SRAIW instruction (from Isla IR [947..969)+[987..994)+[994..1007)) ---
(declare-rel sraiw
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 32) (bvashr ((_ extract 31 0) (get_reg regs0 p1)) ((_ zero_extend 27) p0)))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sraiw regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- FENCE_TSO instruction (from Isla IR [1008..1012)) ---
(declare-rel fence_tso
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (fence_tso regs0 mem0 pc0 regs1 mem1 pc1))))

;; SKIPPED variant FENCE — unsupported Sail function call: is_fiom_active((_ unit))

;; --- User instruction (from Isla IR [1305..1307)+[1308..1310)+[1324..1337)) ---
(declare-rel user
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (user regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- Supervisor instruction (from Isla IR [1305..1307)+[1311..1313)+[1324..1337)) ---
(declare-rel supervisor
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (supervisor regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- Machine instruction (from Isla IR [1305..1307)+[1314..1316)+[1324..1337)) ---
(declare-rel machine
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (machine regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- VirtualUser instruction (from Isla IR [1305..1307)+[1317..1321)+[1324..1337)) ---
(declare-rel virtualuser
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (virtualuser regs0 mem0 pc0 regs1 mem1 pc1))))

;; SKIPPED variant MRET — unsupported Sail function call: neq_anything<EPrivilege%>(cur_privilege, Machine)

;; SKIPPED variant User — unsupported Sail function call: ext_check_xret_priv(Supervisor)

;; SKIPPED variant Supervisor — unsupported Sail function call: currentlyEnabled(Ext_S)

;; SKIPPED variant Machine — unsupported Sail function call: currentlyEnabled(Ext_S)

;; SKIPPED variant VirtualUser — unsupported IR expression: String("extensions/I/base_insts.sail")

;; --- EBREAK instruction (from Isla IR [1415..1423)) ---
(declare-rel ebreak
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (ebreak regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- Machine instruction (from Isla IR [1424..1425)+[1426..1428)+[1453..1455)) ---
(declare-rel machine
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (machine regs0 mem0 pc0 regs1 mem1 pc1))))

;; SKIPPED variant Supervisor — unsupported Sail function call: _get_Mstatus_TW(mstatus)

;; --- User instruction (from Isla IR [1424..1425)+[1443..1445)+[1453..1455)) ---
(declare-rel user
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (user regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- VirtualUser instruction (from Isla IR [1424..1425)+[1446..1450)+[1453..1455)) ---
(declare-rel virtualuser
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (virtualuser regs0 mem0 pc0 regs1 mem1 pc1))))

;; SKIPPED variant User — unsupported Sail function call: neq_anything<B5>(p0, zreg)

;; SKIPPED variant Supervisor — unsupported Sail function call: neq_anything<B5>(p0, zreg)

;; SKIPPED variant Machine — unsupported Sail function call: neq_anything<B5>(p0, zreg)

;; SKIPPED variant VirtualUser — unsupported Sail function call: neq_anything<B5>(p0, zreg)

;; --- JALR instruction (from Isla IR [1542..1591)) ---
(declare-rel jalr
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvadd pc0 (_ bv4 64))))
             (= mem1 mem0)
             (= pc1 (concat ((_ extract 63 1) (bvadd (get_reg regs0 p1) ((_ sign_extend 52) p0))) (_ bv0 1))))
        (jalr regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- amoswap_4 instruction (from Isla IR [1592..1784)+[1785..1787)+[1832..2014)) ---
(declare-rel amoswap_4
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 32) (mem_read_4 mem0 (bvadd (get_reg regs0 p1) (_ bv0 64))))))
             (= mem1 (write_mem_word mem0 (bvadd (get_reg regs0 p1) (_ bv0 64)) ((_ zero_extend 32) ((_ sign_extend 0) ((_ extract 31 0) (get_reg regs0 p0))))))
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (amoswap_4 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- amoswap_8 instruction (from Isla IR [1592..1784)+[1785..1787)+[1832..2014)) ---
(declare-rel amoswap_8
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 0) (mem_read_8 mem0 (bvadd (get_reg regs0 p1) (_ bv0 64))))))
             (= mem1 (write_mem_dword mem0 (bvadd (get_reg regs0 p1) (_ bv0 64)) ((_ sign_extend 0) ((_ extract 63 0) (get_reg regs0 p0)))))
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (amoswap_8 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- amoadd_4 instruction (from Isla IR [1592..1784)+[1788..1790)+[1832..2014)) ---
(declare-rel amoadd_4
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 32) (mem_read_4 mem0 (bvadd (get_reg regs0 p1) (_ bv0 64))))))
             (= mem1 (write_mem_word mem0 (bvadd (get_reg regs0 p1) (_ bv0 64)) ((_ zero_extend 32) ((_ sign_extend 0) (bvadd ((_ extract 31 0) (get_reg regs0 p0)) (mem_read_4 mem0 (bvadd (get_reg regs0 p1) (_ bv0 64))))))))
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (amoadd_4 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- amoadd_8 instruction (from Isla IR [1592..1784)+[1788..1790)+[1832..2014)) ---
(declare-rel amoadd_8
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 0) (mem_read_8 mem0 (bvadd (get_reg regs0 p1) (_ bv0 64))))))
             (= mem1 (write_mem_dword mem0 (bvadd (get_reg regs0 p1) (_ bv0 64)) ((_ sign_extend 0) (bvadd ((_ extract 63 0) (get_reg regs0 p0)) (mem_read_8 mem0 (bvadd (get_reg regs0 p1) (_ bv0 64)))))))
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (amoadd_8 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- amoxor_4 instruction (from Isla IR [1592..1784)+[1791..1793)+[1832..2014)) ---
(declare-rel amoxor_4
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 32) (mem_read_4 mem0 (bvadd (get_reg regs0 p1) (_ bv0 64))))))
             (= mem1 (write_mem_word mem0 (bvadd (get_reg regs0 p1) (_ bv0 64)) ((_ zero_extend 32) ((_ sign_extend 0) (bvxor ((_ extract 31 0) (get_reg regs0 p0)) (mem_read_4 mem0 (bvadd (get_reg regs0 p1) (_ bv0 64))))))))
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (amoxor_4 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- amoxor_8 instruction (from Isla IR [1592..1784)+[1791..1793)+[1832..2014)) ---
(declare-rel amoxor_8
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 0) (mem_read_8 mem0 (bvadd (get_reg regs0 p1) (_ bv0 64))))))
             (= mem1 (write_mem_dword mem0 (bvadd (get_reg regs0 p1) (_ bv0 64)) ((_ sign_extend 0) (bvxor ((_ extract 63 0) (get_reg regs0 p0)) (mem_read_8 mem0 (bvadd (get_reg regs0 p1) (_ bv0 64)))))))
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (amoxor_8 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- amoand_4 instruction (from Isla IR [1592..1784)+[1794..1796)+[1832..2014)) ---
(declare-rel amoand_4
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 32) (mem_read_4 mem0 (bvadd (get_reg regs0 p1) (_ bv0 64))))))
             (= mem1 (write_mem_word mem0 (bvadd (get_reg regs0 p1) (_ bv0 64)) ((_ zero_extend 32) ((_ sign_extend 0) (bvand ((_ extract 31 0) (get_reg regs0 p0)) (mem_read_4 mem0 (bvadd (get_reg regs0 p1) (_ bv0 64))))))))
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (amoand_4 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- amoand_8 instruction (from Isla IR [1592..1784)+[1794..1796)+[1832..2014)) ---
(declare-rel amoand_8
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 0) (mem_read_8 mem0 (bvadd (get_reg regs0 p1) (_ bv0 64))))))
             (= mem1 (write_mem_dword mem0 (bvadd (get_reg regs0 p1) (_ bv0 64)) ((_ sign_extend 0) (bvand ((_ extract 63 0) (get_reg regs0 p0)) (mem_read_8 mem0 (bvadd (get_reg regs0 p1) (_ bv0 64)))))))
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (amoand_8 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- amoor_4 instruction (from Isla IR [1592..1784)+[1797..1799)+[1832..2014)) ---
(declare-rel amoor_4
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 32) (mem_read_4 mem0 (bvadd (get_reg regs0 p1) (_ bv0 64))))))
             (= mem1 (write_mem_word mem0 (bvadd (get_reg regs0 p1) (_ bv0 64)) ((_ zero_extend 32) ((_ sign_extend 0) (bvor ((_ extract 31 0) (get_reg regs0 p0)) (mem_read_4 mem0 (bvadd (get_reg regs0 p1) (_ bv0 64))))))))
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (amoor_4 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- amoor_8 instruction (from Isla IR [1592..1784)+[1797..1799)+[1832..2014)) ---
(declare-rel amoor_8
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 0) (mem_read_8 mem0 (bvadd (get_reg regs0 p1) (_ bv0 64))))))
             (= mem1 (write_mem_dword mem0 (bvadd (get_reg regs0 p1) (_ bv0 64)) ((_ sign_extend 0) (bvor ((_ extract 63 0) (get_reg regs0 p0)) (mem_read_8 mem0 (bvadd (get_reg regs0 p1) (_ bv0 64)))))))
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (amoor_8 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; SKIPPED variant LOADRES — vmem_read: width not concrete literal 'p3' — LOAD must be specialized

;; SKIPPED variant STORECON — mult_atom: non-literal args 'p4', '8'

;; SKIPPED variant MUL — unsupported IR type in SMT translation: Struct(Name { id: 930 })

;; SKIPPED variant DIV — unsupported Sail function call: signed((get_reg regs0 p1))

;; SKIPPED variant REM — unsupported Sail function call: signed((get_reg regs0 p1))

;; SKIPPED variant MULW — unsupported Sail function call: signed(((_ extract 31 0) (get_reg regs0 p1)))

;; SKIPPED variant DIVW — unsupported Sail function call: signed(((_ extract 31 0) (get_reg regs0 p1)))

;; SKIPPED variant REMW — unsupported Sail function call: signed(((_ extract 31 0) (get_reg regs0 p1)))

;; --- SLLIUW instruction (from Isla IR [2627..2665)) ---
(declare-rel slliuw
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 6)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 6))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvshl ((_ zero_extend 32) ((_ extract 31 0) (get_reg regs0 p1))) ((_ zero_extend 58) p0))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (slliuw regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- ZBA_RTYPEUW instruction (from Isla IR [2666..2716)) ---
(declare-rel zba_rtypeuw
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 2)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5))
           (p3 (_ BitVec 2)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvadd (bvshl ((_ zero_extend 32) ((_ extract 31 0) (get_reg regs0 p1))) ((_ zero_extend 62) p3)) (get_reg regs0 p0))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (zba_rtypeuw regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2 p3))))

;; --- ZBA_RTYPE instruction (from Isla IR [2717..2749)) ---
(declare-rel zba_rtype
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 2)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5))
           (p3 (_ BitVec 2)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvadd (bvshl (get_reg regs0 p1) ((_ zero_extend 62) p3)) (get_reg regs0 p0))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (zba_rtype regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2 p3))))

;; --- RORIW instruction (from Isla IR [2750..2788)) ---
(declare-rel roriw
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 32) (_ unit))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (roriw regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- RORI instruction (from Isla IR [2789..2827)) ---
(declare-rel rori
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 6)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 6))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (_ unit)))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (rori regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- ROLW instruction (from Isla IR [2828..2862)+[2863..2871)+[2878..2891)) ---
(declare-rel rolw
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 32) (_ unit))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (rolw regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- RORW instruction (from Isla IR [2828..2862)+[2871..2878)+[2878..2891)) ---
(declare-rel rorw
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 32) (_ unit))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (rorw regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- ANDN instruction (from Isla IR [2892..2906)+[2907..2921)+[3051..3056)) ---
(declare-rel andn
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvand (get_reg regs0 p1) (_ unit))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (andn regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- ORN instruction (from Isla IR [2892..2906)+[2922..2936)+[3051..3056)) ---
(declare-rel orn
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (bvor (get_reg regs0 p1) (_ unit))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (orn regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- XNOR instruction (from Isla IR [2892..2906)+[2937..2951)+[3051..3056)) ---
(declare-rel xnor
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (_ unit)))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (xnor regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- MAX instruction (from Isla IR [2892..2906)+[2952..2963)+[3051..3056)) ---
(declare-rel max
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (get_reg regs0 p1)))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (max regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- MAXU instruction (from Isla IR [2892..2906)+[2964..2975)+[3051..3056)) ---
(declare-rel maxu
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (get_reg regs0 p1)))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (maxu regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- MIN instruction (from Isla IR [2892..2906)+[2976..2987)+[3051..3056)) ---
(declare-rel min
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (get_reg regs0 p1)))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (min regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- MINU instruction (from Isla IR [2892..2906)+[2988..2999)+[3051..3056)) ---
(declare-rel minu
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (get_reg regs0 p1)))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (minu regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- ROL instruction (from Isla IR [2892..2906)+[3000..3026)+[3051..3056)) ---
(declare-rel rol
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (_ unit)))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (rol regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- ROR instruction (from Isla IR [2892..2906)+[3026..3051)+[3051..3056)) ---
(declare-rel ror
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (_ unit)))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (ror regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SEXTB instruction (from Isla IR [3057..3067)+[3068..3086)+[3122..3127)) ---
(declare-rel sextb
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p1 ((_ sign_extend 56) ((_ extract 7 0) (get_reg regs0 p0)))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sextb regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- SEXTH instruction (from Isla IR [3057..3067)+[3087..3105)+[3122..3127)) ---
(declare-rel sexth
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p1 ((_ sign_extend 48) ((_ extract 15 0) (get_reg regs0 p0)))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sexth regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- ZEXTH instruction (from Isla IR [3057..3067)+[3105..3122)+[3122..3127)) ---
(declare-rel zexth
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p1 ((_ zero_extend 48) ((_ extract 15 0) (get_reg regs0 p0)))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (zexth regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- REV8 instruction (from Isla IR [3128..3144)) ---
(declare-rel rev8
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p1 (_ unit)))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (rev8 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; SKIPPED variant ORCB — unsupported Sail function call: add_atom(0, 7)

;; SKIPPED variant CPOP — unsupported Sail function call: count_ones((get_reg regs0 p0))

;; SKIPPED variant CPOPW — unsupported Sail function call: count_ones(((_ extract 31 0) (get_reg regs0 p0)))

;; SKIPPED variant CLZ — unsupported Sail function call: count_leading_zeros((get_reg regs0 p0))

;; SKIPPED variant CLZW — unsupported Sail function call: count_leading_zeros(((_ extract 31 0) (get_reg regs0 p0)))

;; SKIPPED variant CTZ — unsupported Sail function call: count_trailing_zeros((get_reg regs0 p0))

;; SKIPPED variant CTZW — unsupported Sail function call: count_trailing_zeros(((_ extract 31 0) (get_reg regs0 p0)))

;; --- CLMUL instruction (from Isla IR [3447..3487)) ---
(declare-rel clmul
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ extract 63 0) (_ unit))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (clmul regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- CLMULH instruction (from Isla IR [3488..3536)) ---
(declare-rel clmulh
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ extract 127 64) (_ unit))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (clmulh regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- CLMULR instruction (from Isla IR [3537..3559)) ---
(declare-rel clmulr
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (_ unit)))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (clmulr regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; SKIPPED variant BCLRI — unsupported Sail function call: eq_int(64, 32)

;; SKIPPED variant BEXTI — unsupported Sail function call: eq_int(64, 32)

;; SKIPPED variant BINVI — unsupported Sail function call: eq_int(64, 32)

;; SKIPPED variant BSETI — unsupported Sail function call: eq_int(64, 32)

;; SKIPPED variant BCLR — unsupported Sail function call: eq_int(64, 32)

;; SKIPPED variant BEXT — unsupported Sail function call: eq_int(64, 32)

;; SKIPPED variant BINV — unsupported Sail function call: eq_int(64, 32)

;; SKIPPED variant BSET — unsupported Sail function call: eq_int(64, 32)

;; --- C_NOP instruction (from Isla IR [3776..3778)) ---
(declare-rel c_nop
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_nop regs0 mem0 pc0 regs1 mem1 pc1))))

;; SKIPPED variant C_ADDI4SPN — unsupported Sail function call: creg2reg_idx(p0)

;; SKIPPED variant C_LW — unsupported Sail function call: creg2reg_idx(p2)

;; SKIPPED variant C_LD — unsupported Sail function call: creg2reg_idx(p2)

;; SKIPPED variant C_SW — unsupported Sail function call: creg2reg_idx(p1)

;; SKIPPED variant C_SD — unsupported Sail function call: creg2reg_idx(p1)

;; --- C_ADDI instruction (from Isla IR [3960..3976)) ---
(declare-rel c_addi
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 6)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 6))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_addi regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- C_JAL instruction (from Isla IR [3977..4001)) ---
(declare-rel c_jal
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_jal regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- C_ADDIW instruction (from Isla IR [4002..4020)) ---
(declare-rel c_addiw
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 6)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 6))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_addiw regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- C_LI instruction (from Isla IR [4021..4037)) ---
(declare-rel c_li
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 6)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 6))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_li regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- C_ADDI16SP instruction (from Isla IR [4038..4060)) ---
(declare-rel c_addi16sp
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_addi16sp regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- C_LUI instruction (from Isla IR [4061..4077)) ---
(declare-rel c_lui
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 6)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 6))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_lui regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; SKIPPED variant C_SRLI — unsupported Sail function call: creg2reg_idx(p1)

;; SKIPPED variant C_SRAI — unsupported Sail function call: creg2reg_idx(p1)

;; SKIPPED variant C_ANDI — unsupported Sail function call: creg2reg_idx(p1)

;; SKIPPED variant C_SUB — unsupported Sail function call: creg2reg_idx(p0)

;; SKIPPED variant C_XOR — unsupported Sail function call: creg2reg_idx(p0)

;; SKIPPED variant C_OR — unsupported Sail function call: creg2reg_idx(p0)

;; SKIPPED variant C_AND — unsupported Sail function call: creg2reg_idx(p0)

;; SKIPPED variant C_SUBW — unsupported Sail function call: creg2reg_idx(p0)

;; SKIPPED variant C_ADDW — unsupported Sail function call: creg2reg_idx(p0)

;; --- C_J instruction (from Isla IR [4199..4223)) ---
(declare-rel c_j
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_j regs0 mem0 pc0 regs1 mem1 pc1))))

;; SKIPPED variant C_BEQZ — unsupported Sail function call: creg2reg_idx(p1)

;; SKIPPED variant C_BNEZ — unsupported Sail function call: creg2reg_idx(p1)

;; --- C_SLLI instruction (from Isla IR [4282..4290)) ---
(declare-rel c_slli
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 6)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 6))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_slli regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- C_LWSP instruction (from Isla IR [4291..4323)) ---
(declare-rel c_lwsp
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 6)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 6))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_lwsp regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- C_LDSP instruction (from Isla IR [4324..4356)) ---
(declare-rel c_ldsp
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 6)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 6))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_ldsp regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- C_SWSP instruction (from Isla IR [4357..4388)) ---
(declare-rel c_swsp
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 6)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 6))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_swsp regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- C_SDSP instruction (from Isla IR [4389..4420)) ---
(declare-rel c_sdsp
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 6)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 6))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_sdsp regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- C_JR instruction (from Isla IR [4421..4435)) ---
(declare-rel c_jr
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_jr regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- C_JALR instruction (from Isla IR [4436..4450)) ---
(declare-rel c_jalr
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_jalr regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- C_MV instruction (from Isla IR [4451..4459)) ---
(declare-rel c_mv
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_mv regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- C_EBREAK instruction (from Isla IR [4460..4464)) ---
(declare-rel c_ebreak
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_ebreak regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- C_ADD instruction (from Isla IR [4465..4473)) ---
(declare-rel c_add
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_add regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; SKIPPED variant C_LBU — unsupported Sail function call: creg2reg_idx(p1)

;; SKIPPED variant C_LHU — unsupported Sail function call: creg2reg_idx(p1)

;; SKIPPED variant C_LH — unsupported Sail function call: creg2reg_idx(p1)

;; SKIPPED variant C_SB — unsupported Sail function call: creg2reg_idx(p1)

;; SKIPPED variant C_SH — unsupported Sail function call: creg2reg_idx(p1)

;; SKIPPED variant C_ZEXT_B — unsupported Sail function call: creg2reg_idx(merge_var)

;; SKIPPED variant C_SEXT_B — unsupported Sail function call: creg2reg_idx(merge_var)

;; SKIPPED variant C_ZEXT_H — unsupported Sail function call: creg2reg_idx(merge_var)

;; SKIPPED variant C_SEXT_H — unsupported Sail function call: creg2reg_idx(merge_var)

;; SKIPPED variant C_ZEXT_W — unsupported Sail function call: creg2reg_idx(merge_var)

;; SKIPPED variant C_NOT — unsupported Sail function call: creg2reg_idx(merge_var)

;; SKIPPED variant C_MUL — unsupported Sail function call: creg2reg_idx(p0)

;; SKIPPED variant LOAD_FP — vmem_read: width not concrete literal 'p3' — LOAD must be specialized

;; SKIPPED variant STORE_FP — unsupported Sail function call: rF_bits(p1)

;; SKIPPED variant FMADD_S — unsupported Sail function call: rF_or_X_S(p2)

;; SKIPPED variant FMSUB_S — unsupported Sail function call: rF_or_X_S(p2)

;; SKIPPED variant FNMSUB_S — unsupported Sail function call: rF_or_X_S(p2)

;; SKIPPED variant FNMADD_S — unsupported Sail function call: rF_or_X_S(p2)

;; SKIPPED variant FADD_S — unsupported Sail function call: rF_or_X_S(p1)

;; SKIPPED variant FSUB_S — unsupported Sail function call: rF_or_X_S(p1)

;; SKIPPED variant FMUL_S — unsupported Sail function call: rF_or_X_S(p1)

;; SKIPPED variant FDIV_S — unsupported Sail function call: rF_or_X_S(p1)

;; SKIPPED variant FSQRT_S — unsupported Sail function call: rF_or_X_S(p0)

;; SKIPPED variant FCVT_W_S — unsupported Sail function call: rF_or_X_S(p0)

;; SKIPPED variant FCVT_WU_S — unsupported Sail function call: rF_or_X_S(p0)

;; SKIPPED variant FCVT_S_W — unsupported Sail function call: encdec_rounding_mode_forwards((_ unit))

;; SKIPPED variant FCVT_S_WU — unsupported Sail function call: encdec_rounding_mode_forwards((_ unit))

;; SKIPPED variant FCVT_L_S — unsupported Sail function call: gteq_int(64, 64)

;; SKIPPED variant FCVT_LU_S — unsupported Sail function call: gteq_int(64, 64)

;; SKIPPED variant FCVT_S_L — unsupported Sail function call: gteq_int(64, 64)

;; SKIPPED variant FCVT_S_LU — unsupported Sail function call: gteq_int(64, 64)

;; SKIPPED variant FSGNJ_S — unsupported Sail function call: rF_or_X_S(p1)

;; SKIPPED variant FSGNJN_S — unsupported Sail function call: rF_or_X_S(p1)

;; SKIPPED variant FSGNJX_S — unsupported Sail function call: rF_or_X_S(p1)

;; SKIPPED variant FMIN_S — unsupported Sail function call: rF_or_X_S(p1)

;; SKIPPED variant FMAX_S — unsupported Sail function call: rF_or_X_S(p1)

;; SKIPPED variant FEQ_S — unsupported Sail function call: rF_or_X_S(p1)

;; SKIPPED variant FLT_S — unsupported Sail function call: rF_or_X_S(p1)

;; SKIPPED variant FLE_S — unsupported Sail function call: rF_or_X_S(p1)

;; SKIPPED variant FCLASS_S — unsupported Sail function call: rF_or_X_S(p0)

;; SKIPPED variant FMV_X_W — unsupported Sail function call: rF_bits(p0)

;; --- FMV_W_X instruction (from Isla IR [5856..5856)+[5857..5897)+[5897..5897)) ---
(declare-rel fmv_w_x
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (fmv_w_x regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- C_FLWSP instruction (from Isla IR [5898..5932)) ---
(declare-rel c_flwsp
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 6)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 6))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_flwsp regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- C_FSWSP instruction (from Isla IR [5933..5967)) ---
(declare-rel c_fswsp
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 6)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 6))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_fswsp regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; SKIPPED variant C_FLW — unsupported Sail function call: cfregidx_to_fregidx(p2)

;; SKIPPED variant C_FSW — unsupported Sail function call: creg2reg_idx(p1)

;; SKIPPED variant FMADD_D — unsupported Sail function call: rF_or_X_D(p2)

;; SKIPPED variant FMSUB_D — unsupported Sail function call: rF_or_X_D(p2)

;; SKIPPED variant FNMSUB_D — unsupported Sail function call: rF_or_X_D(p2)

;; SKIPPED variant FNMADD_D — unsupported Sail function call: rF_or_X_D(p2)

;; SKIPPED variant FADD_D — unsupported Sail function call: rF_or_X_D(p1)

;; SKIPPED variant FSUB_D — unsupported Sail function call: rF_or_X_D(p1)

;; SKIPPED variant FMUL_D — unsupported Sail function call: rF_or_X_D(p1)

;; SKIPPED variant FDIV_D — unsupported Sail function call: rF_or_X_D(p1)

;; SKIPPED variant FSQRT_D — unsupported Sail function call: rF_or_X_D(p0)

;; SKIPPED variant FCVT_W_D — unsupported Sail function call: rF_or_X_D(p0)

;; SKIPPED variant FCVT_WU_D — unsupported Sail function call: rF_or_X_D(p0)

;; SKIPPED variant FCVT_D_W — unsupported Sail function call: encdec_rounding_mode_forwards((_ unit))

;; SKIPPED variant FCVT_D_WU — unsupported Sail function call: encdec_rounding_mode_forwards((_ unit))

;; SKIPPED variant FCVT_S_D — unsupported Sail function call: rF_or_X_D(p0)

;; SKIPPED variant FCVT_D_S — unsupported Sail function call: rF_or_X_S(p0)

;; SKIPPED variant FCVT_L_D — unsupported Sail function call: gteq_int(64, 64)

;; SKIPPED variant FCVT_LU_D — unsupported Sail function call: gteq_int(64, 64)

;; SKIPPED variant FCVT_D_L — unsupported Sail function call: gteq_int(64, 64)

;; SKIPPED variant FCVT_D_LU — unsupported Sail function call: gteq_int(64, 64)

;; SKIPPED variant FSGNJ_D — unsupported Sail function call: rF_or_X_D(p1)

;; SKIPPED variant FSGNJN_D — unsupported Sail function call: rF_or_X_D(p1)

;; SKIPPED variant FSGNJX_D — unsupported Sail function call: rF_or_X_D(p1)

;; SKIPPED variant FMIN_D — unsupported Sail function call: rF_or_X_D(p1)

;; SKIPPED variant FMAX_D — unsupported Sail function call: rF_or_X_D(p1)

;; SKIPPED variant FEQ_D — unsupported Sail function call: rF_or_X_D(p1)

;; SKIPPED variant FLT_D — unsupported Sail function call: rF_or_X_D(p1)

;; SKIPPED variant FLE_D — unsupported Sail function call: rF_or_X_D(p1)

;; SKIPPED variant FCLASS_D — unsupported Sail function call: rF_or_X_D(p0)

;; SKIPPED variant FMV_X_D — unsupported Sail function call: gteq_int(64, 64)

;; SKIPPED variant FMV_D_X — unsupported Sail function call: gteq_int(64, 64)

;; --- C_FLDSP instruction (from Isla IR [7185..7219)) ---
(declare-rel c_fldsp
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 6)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 6))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_fldsp regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- C_FSDSP instruction (from Isla IR [7220..7254)) ---
(declare-rel c_fsdsp
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 6)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 6))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (c_fsdsp regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; SKIPPED variant C_FLD — unsupported Sail function call: cfregidx_to_fregidx(p2)

;; SKIPPED variant C_FSD — unsupported Sail function call: creg2reg_idx(p1)

;; SKIPPED variant FADD_H — unsupported Sail function call: rF_or_X_H(p1)

;; SKIPPED variant FSUB_H — unsupported Sail function call: rF_or_X_H(p1)

;; SKIPPED variant FMUL_H — unsupported Sail function call: rF_or_X_H(p1)

;; SKIPPED variant FDIV_H — unsupported Sail function call: rF_or_X_H(p1)

;; SKIPPED variant FMADD_H — unsupported Sail function call: rF_or_X_H(p2)

;; SKIPPED variant FMSUB_H — unsupported Sail function call: rF_or_X_H(p2)

;; SKIPPED variant FNMSUB_H — unsupported Sail function call: rF_or_X_H(p2)

;; SKIPPED variant FNMADD_H — unsupported Sail function call: rF_or_X_H(p2)

;; SKIPPED variant FSGNJ_H — unsupported Sail function call: rF_or_X_H(p1)

;; SKIPPED variant FSGNJN_H — unsupported Sail function call: rF_or_X_H(p1)

;; SKIPPED variant FSGNJX_H — unsupported Sail function call: rF_or_X_H(p1)

;; SKIPPED variant FMIN_H — unsupported Sail function call: rF_or_X_H(p1)

;; SKIPPED variant FMAX_H — unsupported Sail function call: rF_or_X_H(p1)

;; SKIPPED variant FEQ_H — unsupported Sail function call: rF_or_X_H(p1)

;; SKIPPED variant FLT_H — unsupported Sail function call: rF_or_X_H(p1)

;; SKIPPED variant FLE_H — unsupported Sail function call: rF_or_X_H(p1)

;; SKIPPED variant FSQRT_H — unsupported Sail function call: rF_or_X_H(p0)

;; SKIPPED variant FCVT_W_H — unsupported Sail function call: rF_or_X_H(p0)

;; SKIPPED variant FCVT_WU_H — unsupported Sail function call: rF_or_X_H(p0)

;; SKIPPED variant FCVT_H_W — unsupported Sail function call: encdec_rounding_mode_forwards((_ unit))

;; SKIPPED variant FCVT_H_WU — unsupported Sail function call: encdec_rounding_mode_forwards((_ unit))

;; SKIPPED variant FCVT_H_S — unsupported Sail function call: rF_or_X_S(p0)

;; SKIPPED variant FCVT_H_D — unsupported Sail function call: rF_or_X_D(p0)

;; SKIPPED variant FCVT_S_H — unsupported Sail function call: rF_or_X_H(p0)

;; SKIPPED variant FCVT_D_H — unsupported Sail function call: rF_or_X_H(p0)

;; SKIPPED variant FCVT_L_H — unsupported Sail function call: gteq_int(64, 64)

;; SKIPPED variant FCVT_LU_H — unsupported Sail function call: gteq_int(64, 64)

;; SKIPPED variant FCVT_H_L — unsupported Sail function call: gteq_int(64, 64)

;; SKIPPED variant FCVT_H_LU — unsupported Sail function call: gteq_int(64, 64)

;; SKIPPED variant FCLASS_H — unsupported Sail function call: rF_or_X_H(p0)

;; SKIPPED variant FMV_X_H — unsupported Sail function call: rF_bits(p0)

;; --- FMV_H_X instruction (from Isla IR [8464..8464)+[8465..8505)+[8505..8505)) ---
(declare-rel fmv_h_x
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (fmv_h_x regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; SKIPPED variant FLI_H — unsupported Sail function call: canonical_NaN_H((_ unit))

;; SKIPPED variant FLI_S — unsupported Sail function call: canonical_NaN_S((_ unit))

;; SKIPPED variant FLI_D — unsupported Sail function call: canonical_NaN_D((_ unit))

;; SKIPPED variant FMINM_H — unsupported Sail function call: rF_H(p1)

;; SKIPPED variant FMAXM_H — unsupported Sail function call: rF_H(p1)

;; SKIPPED variant FMINM_S — unsupported Sail function call: rF_S(p1)

;; SKIPPED variant FMAXM_S — unsupported Sail function call: rF_S(p1)

;; SKIPPED variant FMINM_D — unsupported Sail function call: rF_D(p1)

;; SKIPPED variant FMAXM_D — unsupported Sail function call: rF_D(p1)

;; SKIPPED variant FROUND_H — unsupported Sail function call: rF_H(p0)

;; SKIPPED variant FROUNDNX_H — unsupported Sail function call: rF_H(p0)

;; SKIPPED variant FROUND_S — unsupported Sail function call: rF_S(p0)

;; SKIPPED variant FROUNDNX_S — unsupported Sail function call: rF_S(p0)

;; SKIPPED variant FROUND_D — unsupported Sail function call: rF_D(p0)

;; SKIPPED variant FROUNDNX_D — unsupported Sail function call: rF_D(p0)

;; SKIPPED variant FMVH_X_D — unsupported Sail function call: rF_D(p0)

;; --- FMVP_D_X instruction (from Isla IR [10395..10437)) ---
(declare-rel fmvp_d_x
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (fmvp_d_x regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; SKIPPED variant FLEQ_H — unsupported Sail function call: rF_H(p1)

;; SKIPPED variant FLTQ_H — unsupported Sail function call: rF_H(p1)

;; SKIPPED variant FLEQ_S — unsupported Sail function call: rF_S(p1)

;; SKIPPED variant FLTQ_S — unsupported Sail function call: rF_S(p1)

;; SKIPPED variant FLEQ_D — unsupported Sail function call: rF_D(p1)

;; SKIPPED variant FLTQ_D — unsupported Sail function call: rF_D(p1)

;; SKIPPED variant FCVTMOD_W_D — unsupported Sail function call: rF_D(p0)

;; SKIPPED variant VSETVLI — unsupported Sail function call: neq_anything<B5>(p4, zreg)

;; SKIPPED variant VSETVL — unsupported Sail function call: _get_Vtype_vill((_ unit))

;; --- VSETIVLI instruction (from Isla IR [10806..10828)) ---
(declare-rel vsetivli
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 1)
   (_ BitVec 1)
   (_ BitVec 3)
   (_ BitVec 3)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 1))
           (p1 (_ BitVec 1))
           (p2 (_ BitVec 3))
           (p3 (_ BitVec 3))
           (p4 (_ BitVec 5))
           (p5 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (vsetivli regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2 p3 p4 p5))))

;; SKIPPED variant VV_VADD — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VSUB — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VAND — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VOR — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VXOR — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VSADDU — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VSADD — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VSSUBU — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VSSUB — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VSMUL — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VSLL — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VSRL — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VSRA — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VSSRL — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VSSRA — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VMINU — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VMIN — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VMAXU — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VMAX — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VRGATHER — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VV_VRGATHEREI16 — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant NVS_VNSRL — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant NVS_VNSRA — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant NV_VNCLIPU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant NV_VNCLIP — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant UNDISTURBED — unsupported Sail function call: get_end_element((_ unit))

;; SKIPPED variant AGNOSTIC — unsupported Sail function call: get_end_element((_ unit))

;; SKIPPED variant MOVETYPEV — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VADD — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VSUB — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VRSUB — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VAND — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VOR — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VXOR — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VSADDU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VSADD — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VSSUBU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VSSUB — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VSMUL — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VSLL — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VSRL — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VSRA — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VSSRL — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VSSRA — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VMINU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VMIN — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VMAXU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VMAX — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant NXS_VNSRL — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant NXS_VNSRA — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant NX_VNCLIPU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant NX_VNCLIP — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VX_VSLIDEUP — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VX_VSLIDEDOWN — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VX_VRGATHER — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant UNDISTURBED — unsupported Sail function call: get_end_element((_ unit))

;; SKIPPED variant AGNOSTIC — unsupported Sail function call: get_end_element((_ unit))

;; SKIPPED variant MOVETYPEX — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VI_VADD — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VI_VRSUB — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VI_VAND — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VI_VOR — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VI_VXOR — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VI_VSADDU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VI_VSADD — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VI_VSLL — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VI_VSRL — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VI_VSRA — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VI_VSSRL — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VI_VSSRA — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant NIS_VNSRL — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant NIS_VNSRA — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant NI_VNCLIPU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant NI_VNCLIP — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VI_VSLIDEUP — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VI_VSLIDEDOWN — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VI_VRGATHER — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant UNDISTURBED — unsupported Sail function call: get_end_element((_ unit))

;; SKIPPED variant AGNOSTIC — unsupported Sail function call: get_end_element((_ unit))

;; SKIPPED variant MOVETYPEI — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VMVRTYPE — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VAADDU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VAADD — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VASUBU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VASUB — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VMUL — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VMULH — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VMULHU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VMULHSU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VDIVU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VDIV — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VREMU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VREM — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VMACC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VNMSAC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VMADD — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VNMSUB — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WVV_VADD — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WVV_VSUB — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WVV_VADDU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WVV_VSUBU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WVV_VWMUL — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WVV_VWMULU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WVV_VWMULSU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WV_VADD — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WV_VSUB — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WV_VADDU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WV_VSUBU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WMVV_VWMACC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WMVV_VWMACCU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WMVV_VWMACCSU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VEXT2_ZVF2 — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VEXT2_SVF2 — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VEXT4_ZVF4 — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VEXT4_SVF4 — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VEXT8_ZVF8 — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VEXT2_ZVF2 — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VEXT2_SVF2 — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VEXT4_ZVF4 — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VEXT4_SVF4 — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VEXT8_ZVF8 — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VEXT8_SVF8 — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VMVXS — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant UNDISTURBED — unsupported Sail function call: get_end_element((_ unit))

;; SKIPPED variant AGNOSTIC — unsupported Sail function call: get_end_element((_ unit))

;; SKIPPED variant MVX_VAADDU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVX_VAADD — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVX_VASUBU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVX_VASUB — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVX_VSLIDE1UP — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVX_VSLIDE1DOWN — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVX_VMUL — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVX_VMULH — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVX_VMULHU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVX_VMULHSU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVX_VDIVU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVX_VDIV — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVX_VREMU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVX_VREM — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVX_VMACC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVX_VNMSAC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVX_VMADD — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVX_VNMSUB — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WVX_VADD — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WVX_VSUB — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WVX_VADDU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WVX_VSUBU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WVX_VWMUL — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WVX_VWMULU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WVX_VWMULSU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WX_VADD — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WX_VSUB — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WX_VADDU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WX_VSUBU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WMVX_VWMACCU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WMVX_VWMACC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WMVX_VWMACCUS — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant WMVX_VWMACCSU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant UNDISTURBED — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant AGNOSTIC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant FVV_VADD — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VSUB — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VMIN — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VMAX — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VMUL — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VDIV — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VSGNJ — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VSGNJN — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VSGNJX — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VMACC — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VNMACC — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VMSAC — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VNMSAC — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VMADD — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VNMADD — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VMSUB — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VNMSUB — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWVV_VADD — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWVV_VSUB — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWVV_VMUL — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWVV_VMACC — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWVV_VNMACC — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWVV_VMSAC — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWVV_VNMSAC — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWV_VADD — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWV_VSUB — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FV_CVT_XU_F — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FV_CVT_X_F — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FV_CVT_F_XU — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FV_CVT_F_X — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FV_CVT_RTZ_XU_F — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FV_CVT_RTZ_X_F — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWV_CVT_XU_F — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWV_CVT_X_F — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWV_CVT_F_XU — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWV_CVT_F_X — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWV_CVT_F_F — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWV_CVT_RTZ_XU_F — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWV_CVT_RTZ_X_F — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FNV_CVT_XU_F — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FNV_CVT_X_F — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FNV_CVT_F_XU — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FNV_CVT_F_X — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FNV_CVT_F_F — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FNV_CVT_ROD_F_F — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FNV_CVT_RTZ_XU_F — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FNV_CVT_RTZ_X_F — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VSQRT — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VRSQRT7 — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VREC7 — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVV_VCLASS — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VFMVFS — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VADD — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VSUB — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VRSUB — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VMIN — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VMAX — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VMUL — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VDIV — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VRDIV — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VSGNJ — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VSGNJN — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VSGNJX — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VSLIDE1UP — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VSLIDE1DOWN — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VMACC — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VNMACC — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VMSAC — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VNMSAC — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VMADD — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VNMADD — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VMSUB — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VF_VNMSUB — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWVF_VADD — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWVF_VSUB — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWVF_VMUL — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWVF_VMACC — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWVF_VNMACC — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWVF_VMSAC — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWVF_VNMSAC — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWF_VADD — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FWF_VSUB — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant UNDISTURBED — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant AGNOSTIC — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VFMV — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant UNDISTURBED — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant AGNOSTIC — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VLSEGTYPE — unsupported Sail function call: vlewidth_pow_forwards((_ unit))

;; SKIPPED variant VLSEGFFTYPE — unsupported Sail function call: vlewidth_pow_forwards((_ unit))

;; SKIPPED variant VSSEGTYPE — unsupported Sail function call: vlewidth_pow_forwards((_ unit))

;; SKIPPED variant VLSSEGTYPE — unsupported Sail function call: vlewidth_pow_forwards((_ unit))

;; SKIPPED variant VSSSEGTYPE — unsupported Sail function call: vlewidth_pow_forwards((_ unit))

;; SKIPPED variant VLXSEGTYPE — unsupported Sail function call: vlewidth_pow_forwards((_ unit))

;; SKIPPED variant VSXSEGTYPE — unsupported Sail function call: vlewidth_pow_forwards((_ unit))

;; SKIPPED variant VLRETYPE — unsupported Sail function call: vlewidth_pow_forwards((_ unit))

;; SKIPPED variant VSRETYPE — unsupported Sail function call: quot_positive_round_zero(vlen, 8)

;; SKIPPED variant VMTYPE — unsupported Sail function call: rem_positive_round_zero((bv2nat vl), 8)

;; SKIPPED variant MM_VMAND — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MM_VMNAND — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MM_VMANDN — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MM_VMXOR — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MM_VMOR — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MM_VMNOR — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MM_VMORN — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MM_VMXNOR — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VCPOP_M — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VFIRST_M — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VMSBF_M — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VMSIF_M — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VMSOF_M — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VIOTA_M — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VID_V — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VVM_VMADC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VVM_VMSBC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VVMC_VMADC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VVMC_VMSBC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VVMS_VADC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VVMS_VSBC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VVCMP_VMSEQ — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VVCMP_VMSNE — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VVCMP_VMSLTU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VVCMP_VMSLT — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VVCMP_VMSLEU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VVCMP_VMSLE — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VXM_VMADC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VXM_VMSBC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VXMC_VMADC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VXMC_VMSBC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VXMS_VADC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VXMS_VSBC — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VXCMP_VMSEQ — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VXCMP_VMSNE — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VXCMP_VMSLTU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VXCMP_VMSLT — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VXCMP_VMSLEU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VXCMP_VMSLE — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VXCMP_VMSGTU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VXCMP_VMSGT — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VIMTYPE — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VIMCTYPE — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VIMSTYPE — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VICMP_VMSEQ — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VICMP_VMSNE — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VICMP_VMSLEU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VICMP_VMSLE — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VICMP_VMSGTU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VICMP_VMSGT — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant FVVM_VMFEQ — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVVM_VMFNE — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVVM_VMFLE — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant FVVM_VMFLT — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VFM_VMFEQ — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VFM_VMFNE — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VFM_VMFLE — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VFM_VMFLT — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VFM_VMFGE — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VFM_VMFGT — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant IVV_VWREDSUMU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant IVV_VWREDSUM — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VREDSUM — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VREDAND — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VREDOR — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VREDXOR — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VREDMIN — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VREDMINU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VREDMAX — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant MVV_VREDMAXU — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant FVV_VFREDOSUM — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant FVV_VFREDUSUM — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant FVV_VFREDMAX — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant FVV_VFREDMIN — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant RFWVVTYPE — unsupported Sail function call: get_sew((_ unit))

;; --- SHA256SIG0 instruction (from Isla IR [33361..33429)) ---
(declare-rel sha256sig0
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p1 ((_ sign_extend 32) (bvxor (_ unit) (bvxor (_ unit) (_ unit))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sha256sig0 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- SHA256SIG1 instruction (from Isla IR [33430..33498)) ---
(declare-rel sha256sig1
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p1 ((_ sign_extend 32) (bvxor (_ unit) (bvxor (_ unit) (_ unit))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sha256sig1 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- SHA256SUM0 instruction (from Isla IR [33499..33567)) ---
(declare-rel sha256sum0
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p1 ((_ sign_extend 32) (bvxor (_ unit) (bvxor (_ unit) (_ unit))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sha256sum0 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- SHA256SUM1 instruction (from Isla IR [33568..33636)) ---
(declare-rel sha256sum1
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p1 ((_ sign_extend 32) (bvxor (_ unit) (bvxor (_ unit) (_ unit))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sha256sum1 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; SKIPPED variant AES32ESMI — unsupported Sail function call: aes_sbox_fwd(((_ extract 7 0) (bvlshr (get_reg regs0 p1) ((_ zero_extend 59) (concat p0 (_ bv0 3))))))

;; SKIPPED variant AES32ESI — unsupported Sail function call: aes_sbox_fwd(((_ extract 7 0) (bvlshr (get_reg regs0 p1) ((_ zero_extend 59) (concat p0 (_ bv0 3))))))

;; SKIPPED variant AES32DSMI — unsupported Sail function call: aes_sbox_inv(((_ extract 7 0) (bvlshr (get_reg regs0 p1) ((_ zero_extend 59) (concat p0 (_ bv0 3))))))

;; SKIPPED variant AES32DSI — unsupported Sail function call: aes_sbox_inv(((_ extract 7 0) (bvlshr (get_reg regs0 p1) ((_ zero_extend 59) (concat p0 (_ bv0 3))))))

;; --- SHA512SIG0H instruction (from Isla IR [33973..34073)) ---
(declare-rel sha512sig0h
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 0) (bvxor (_ unit) (bvxor (_ unit) (bvxor (_ unit) (bvxor (_ unit) (_ unit))))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sha512sig0h regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SHA512SIG0L instruction (from Isla IR [34074..34192)) ---
(declare-rel sha512sig0l
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 0) (bvxor (_ unit) (bvxor (_ unit) (bvxor (_ unit) (bvxor (_ unit) (bvxor (_ unit) (_ unit)))))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sha512sig0l regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SHA512SIG1H instruction (from Isla IR [34193..34293)) ---
(declare-rel sha512sig1h
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 0) (bvxor (_ unit) (bvxor (_ unit) (bvxor (_ unit) (bvxor (_ unit) (_ unit))))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sha512sig1h regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SHA512SIG1L instruction (from Isla IR [34294..34412)) ---
(declare-rel sha512sig1l
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 0) (bvxor (_ unit) (bvxor (_ unit) (bvxor (_ unit) (bvxor (_ unit) (bvxor (_ unit) (_ unit)))))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sha512sig1l regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SHA512SUM0R instruction (from Isla IR [34413..34531)) ---
(declare-rel sha512sum0r
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 0) (bvxor (_ unit) (bvxor (_ unit) (bvxor (_ unit) (bvxor (_ unit) (bvxor (_ unit) (_ unit)))))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sha512sum0r regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SHA512SUM1R instruction (from Isla IR [34532..34650)) ---
(declare-rel sha512sum1r
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ sign_extend 0) (bvxor (_ unit) (bvxor (_ unit) (bvxor (_ unit) (bvxor (_ unit) (bvxor (_ unit) (_ unit)))))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sha512sum1r regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; SKIPPED variant AES64KS1I — unsupported Sail function call: eq_int(64, 64)

;; SKIPPED variant AES64KS2 — unsupported Sail function call: eq_int(64, 64)

;; SKIPPED variant AES64IM — unsupported Sail function call: eq_int(64, 64)

;; SKIPPED variant AES64ESM — unsupported Sail function call: eq_int(64, 64)

;; SKIPPED variant AES64ES — unsupported Sail function call: eq_int(64, 64)

;; SKIPPED variant AES64DSM — unsupported Sail function call: eq_int(64, 64)

;; SKIPPED variant AES64DS — unsupported Sail function call: eq_int(64, 64)

;; SKIPPED variant SHA512SIG0 — unsupported Sail function call: eq_int(64, 64)

;; SKIPPED variant SHA512SIG1 — unsupported Sail function call: eq_int(64, 64)

;; SKIPPED variant SHA512SUM0 — unsupported Sail function call: eq_int(64, 64)

;; SKIPPED variant SHA512SUM1 — unsupported Sail function call: eq_int(64, 64)

;; --- SM3P0 instruction (from Isla IR [35331..35391)) ---
(declare-rel sm3p0
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p1 ((_ sign_extend 32) (bvxor ((_ extract 31 0) (get_reg regs0 p0)) (bvxor (_ unit) (_ unit))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sm3p0 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- SM3P1 instruction (from Isla IR [35392..35452)) ---
(declare-rel sm3p1
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p1 ((_ sign_extend 32) (bvxor ((_ extract 31 0) (get_reg regs0 p0)) (bvxor (_ unit) (_ unit))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sm3p1 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; SKIPPED variant SM4ED — unsupported Sail function call: sm4_sbox(((_ extract 7 0) (bvlshr ((_ extract 31 0) (get_reg regs0 p1)) ((_ zero_extend 27) (concat p0 (_ bv0 3))))))

;; SKIPPED variant SM4KS — unsupported Sail function call: sm4_sbox(((_ extract 7 0) (bvlshr ((_ extract 31 0) (get_reg regs0 p1)) ((_ zero_extend 27) (concat p0 (_ bv0 3))))))

;; --- PACK instruction (from Isla IR [35839..35853)+[35854..35914)+[35949..35954)) ---
(declare-rel pack
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (concat ((_ extract 31 0) (get_reg regs0 p0)) ((_ extract 31 0) (get_reg regs0 p1)))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (pack regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- PACKH instruction (from Isla IR [35839..35853)+[35914..35949)+[35949..35954)) ---
(declare-rel packh
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 ((_ zero_extend 48) (concat ((_ extract 7 0) (get_reg regs0 p0)) ((_ extract 7 0) (get_reg regs0 p1))))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (packh regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; SKIPPED variant ZBKB_PACKW — unsupported Sail function call: eq_int(64, 64)

;; SKIPPED variant ZIP — unsupported Sail function call: eq_int(64, 32)

;; SKIPPED variant UNZIP — unsupported Sail function call: eq_int(64, 32)

;; --- BREV8 instruction (from Isla IR [36044..36060)) ---
(declare-rel brev8
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p1 (_ unit)))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (brev8 regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; SKIPPED variant XPERM8 — unsupported Sail function call: add_atom(0, 7)

;; SKIPPED variant XPERM4 — unsupported Sail function call: add_atom(0, 3)

;; SKIPPED variant VANDN_VV — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VANDN_VX — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VBREV_V — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VBREV8_V — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VREV8_V — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VCLZ_V — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VCTZ_V — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VCPOP_V — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VROL_VV — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VROL_VX — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VROR_VV — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VROR_VX — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VROR_VI — unsupported Sail function call: get_sew_pow((_ unit))

;; SKIPPED variant VWSLL_VV — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VWSLL_VX — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VWSLL_VI — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VCLMUL_VV — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VCLMUL_VX — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VCLMULH_VV — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VCLMULH_VX — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VGHSH_VV — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VGMUL_VV — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant ZVK_VAESDF_VV — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant ZVK_VAESDF_VS — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant ZVK_VAESDM_VV — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant ZVK_VAESDM_VS — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant ZVK_VAESEF_VV — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant ZVK_VAESEF_VS — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant ZVK_VAESEM_VV — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant ZVK_VAESEM_VS — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VAESKF1_VI — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VAESKF2_VI — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VAESZ_VS — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VSM4K_VI — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant ZVKSM4RTYPE — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VSHA2MS_VV — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant ZVKSHA2TYPE — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VSM3ME_VV — unsupported Sail function call: get_sew((_ unit))

;; SKIPPED variant VSM3C_VI — unsupported Sail function call: get_sew((_ unit))

;; --- CSRReg instruction (from Isla IR [44358..44376)) ---
(declare-rel csrreg
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (csrreg regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- CSRImm instruction (from Isla IR [44377..44411)) ---
(declare-rel csrimm
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (csrimm regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- SINVAL_VMA instruction (from Isla IR [44412..44423)) ---
(declare-rel sinval_vma
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sinval_vma regs0 mem0 pc0 regs1 mem1 pc1 p0 p1))))

;; --- SFENCE_W_INVAL instruction (from Isla IR [44424..44431)) ---
(declare-rel sfence_w_inval
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sfence_w_inval regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- SFENCE_INVAL_IR instruction (from Isla IR [44432..44439)) ---
(declare-rel sfence_inval_ir
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (sfence_inval_ir regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- WRS_STO instruction (from Isla IR [44440..44440)+[44441..44443)+[44443..44443)) ---
(declare-rel wrs_sto
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (wrs_sto regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- WRS_NTO instruction (from Isla IR [44444..44444)+[44445..44447)+[44447..44447)) ---
(declare-rel wrs_nto
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (wrs_nto regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- CZERO_EQZ instruction (from Isla IR [44448..44458)+[44459..44473)+[44486..44500)) ---
(declare-rel czero_eqz
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (_ bv0 64)))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (czero_eqz regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- CZERO_NEZ instruction (from Isla IR [44448..44458)+[44473..44486)+[44486..44500)) ---
(declare-rel czero_nez
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (_ bv0 64)))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (czero_nez regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; SKIPPED variant CBO_CLEAN — unsupported Sail function call: cbo_clean_flush_enabled(cur_privilege)

;; SKIPPED variant CBO_FLUSH — unsupported Sail function call: cbo_clean_flush_enabled(cur_privilege)

;; --- CBO_INVAL instruction (from Isla IR [44529..44529)+[44530..44555)+[44555..44555)) ---
(declare-rel cbo_inval
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (cbo_inval regs0 mem0 pc0 regs1 mem1 pc1 p0))))

;; --- CBOP_ILLEGAL instruction (from Isla IR [44529..44529)+[44536..44538)+[44555..44555)) ---
(declare-rel cbop_illegal
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (cbop_illegal regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- CBOP_ILLEGAL_VIRTUAL instruction (from Isla IR [44529..44529)+[44539..44543)+[44555..44555)) ---
(declare-rel cbop_illegal_virtual
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (cbop_illegal_virtual regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- CBOP_INVAL_INVAL instruction (from Isla IR [44529..44529)+[44544..44549)+[44555..44555)) ---
(declare-rel cbop_inval_inval
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (cbop_inval_inval regs0 mem0 pc0 regs1 mem1 pc1))))

;; SKIPPED variant ZICBOZ — unsupported Sail function call: cbo_zero_enabled(cur_privilege)

;; --- FENCEI instruction (from Isla IR [44708..44718)) ---
(declare-rel fencei
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 12)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 12))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 regs0)
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (fencei regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; SKIPPED variant FCVT_BF16_S — unsupported Sail function call: rF_or_X_S(p0)

;; SKIPPED variant FCVT_S_BF16 — unsupported Sail function call: rF_BF16(p0)

;; SKIPPED variant VFNCVTBF16_F_F_W — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VFWCVTBF16_F_F_V — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VFWMACCBF16_VV — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; SKIPPED variant VFWMACCBF16_VF — unsupported Sail function call: _get_Fcsr_FRM(fcsr)

;; --- ZIMOP_MOP_R instruction (from Isla IR [45621..45637)) ---
(declare-rel zimop_mop_r
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 5))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p2 (_ bv0 64)))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (zimop_mop_r regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- ZIMOP_MOP_RR instruction (from Isla IR [45638..45656)) ---
(declare-rel zimop_mop_rr
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (_ BitVec 3)
   (_ BitVec 5)
   (_ BitVec 5)
   (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1 (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1 (_ BitVec 64))
           (p0 (_ BitVec 3))
           (p1 (_ BitVec 5))
           (p2 (_ BitVec 5))
           (p3 (_ BitVec 5)))
    (=> (and (= regs1 (set_reg regs0 p3 (_ bv0 64)))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (zimop_mop_rr regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2 p3))))

;; --- ZCMOP instruction (from Isla IR [45657..45661)) ---
(declare-rel zcmop
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (zcmop regs0 mem0 pc0 regs1 mem1 pc1))))

;; --- ILLEGAL instruction (from Isla IR [45662..45666)) ---
(declare-rel illegal
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
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (illegal regs0 mem0 pc0 regs1 mem1 pc1))))

; ======================================================================
; Hand-written fallback instruction rules
; ======================================================================

; ======================================================================
; Programs
; ======================================================================

(declare-rel constant_folding_simple_SUCCESS1
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64))) (mem0 (Array (_ BitVec 64) (_ BitVec 8))) (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64))) (mem1 (Array (_ BitVec 64) (_ BitVec 8))) (pc1 (_ BitVec 64))
           (regs2 (Array (_ BitVec 5) (_ BitVec 64))) (mem2 (Array (_ BitVec 64) (_ BitVec 8))) (pc2 (_ BitVec 64))
           (regs3 (Array (_ BitVec 5) (_ BitVec 64))) (mem3 (Array (_ BitVec 64) (_ BitVec 8))) (pc3 (_ BitVec 64))
           (regs4 (Array (_ BitVec 5) (_ BitVec 64))) (mem4 (Array (_ BitVec 64) (_ BitVec 8))) (pc4 (_ BitVec 64))
           (regs5 (Array (_ BitVec 5) (_ BitVec 64))) (mem5 (Array (_ BitVec 64) (_ BitVec 8))) (pc5 (_ BitVec 64))
           (regs6 (Array (_ BitVec 5) (_ BitVec 64))) (mem6 (Array (_ BitVec 64) (_ BitVec 8))) (pc6 (_ BitVec 64))
           (regs7 (Array (_ BitVec 5) (_ BitVec 64))) (mem7 (Array (_ BitVec 64) (_ BitVec 8))) (pc7 (_ BitVec 64))
           (regs8 (Array (_ BitVec 5) (_ BitVec 64))) (mem8 (Array (_ BitVec 64) (_ BitVec 8))) (pc8 (_ BitVec 64))
           (regs9 (Array (_ BitVec 5) (_ BitVec 64))) (mem9 (Array (_ BitVec 64) (_ BitVec 8))) (pc9 (_ BitVec 64))
           (regs10 (Array (_ BitVec 5) (_ BitVec 64))) (mem10 (Array (_ BitVec 64) (_ BitVec 8))) (pc10 (_ BitVec 64))
           (regs11 (Array (_ BitVec 5) (_ BitVec 64))) (mem11 (Array (_ BitVec 64) (_ BitVec 8))) (pc11 (_ BitVec 64))
           (regs12 (Array (_ BitVec 5) (_ BitVec 64))) (mem12 (Array (_ BitVec 64) (_ BitVec 8))) (pc12 (_ BitVec 64))
           (regs13 (Array (_ BitVec 5) (_ BitVec 64))) (mem13 (Array (_ BitVec 64) (_ BitVec 8))) (pc13 (_ BitVec 64))
           (regs14 (Array (_ BitVec 5) (_ BitVec 64))) (mem14 (Array (_ BitVec 64) (_ BitVec 8))) (pc14 (_ BitVec 64)))
    (=> (and
          ; addi sp, sp, -32
          (addi regs0 mem0 pc0 regs1 mem1 pc1 (_ bv4064 12) reg_sp reg_sp)
          ; sd ra, 24(sp)
          (store_8 regs1 mem1 pc1 regs2 mem2 pc2 (_ bv24 12) reg_ra reg_sp)
          ; sd s0, 16(sp)
          (store_8 regs2 mem2 pc2 regs3 mem3 pc3 (_ bv16 12) reg_s0 reg_sp)
          ; addi s0, sp, 32
          (addi regs3 mem3 pc3 regs4 mem4 pc4 (_ bv32 12) reg_sp reg_s0)
          ; addi a0, zero, 1
          (addi regs4 mem4 pc4 regs5 mem5 pc5 (_ bv1 12) reg_zero reg_a0)
          ; sw a0, -20(s0)
          (store_4 regs5 mem5 pc5 regs6 mem6 pc6 (_ bv4076 12) reg_a0 reg_s0)
          ; lw a0, -20(s0)
          (load_4_s regs6 mem6 pc6 regs7 mem7 pc7 (_ bv4076 12) reg_s0 reg_a0)
          ; addiw a0, a0, 2
          (addiw regs7 mem7 pc7 regs8 mem8 pc8 (_ bv2 12) reg_a0 reg_a0)
          ; sw a0, -24(s0)
          (store_4 regs8 mem8 pc8 regs9 mem9 pc9 (_ bv4072 12) reg_a0 reg_s0)
          ; lw a0, -24(s0)
          (load_4_s regs9 mem9 pc9 regs10 mem10 pc10 (_ bv4072 12) reg_s0 reg_a0)
          ; ld ra, 24(sp)
          (load_8_s regs10 mem10 pc10 regs11 mem11 pc11 (_ bv24 12) reg_sp reg_ra)
          ; ld s0, 16(sp)
          (load_8_s regs11 mem11 pc11 regs12 mem12 pc12 (_ bv16 12) reg_sp reg_s0)
          ; addi sp, sp, 32
          (addi regs12 mem12 pc12 regs13 mem13 pc13 (_ bv32 12) reg_sp reg_sp)
          ; ret
          (jalr regs13 mem13 pc13 regs14 mem14 pc14 (_ bv0 12) reg_ra reg_zero)
        )
        (constant_folding_simple_SUCCESS1 regs0 mem0 pc0 regs14 mem14 pc14))))

(declare-rel constant_folding_simple_SUCCESS2
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64))) (mem0 (Array (_ BitVec 64) (_ BitVec 8))) (pc0 (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64))) (mem1 (Array (_ BitVec 64) (_ BitVec 8))) (pc1 (_ BitVec 64))
           (regs2 (Array (_ BitVec 5) (_ BitVec 64))) (mem2 (Array (_ BitVec 64) (_ BitVec 8))) (pc2 (_ BitVec 64)))
    (=> (and
          ; addi a0, zero, 3
          (addi regs0 mem0 pc0 regs1 mem1 pc1 (_ bv3 12) reg_zero reg_a0)
          ; ret
          (jalr regs1 mem1 pc1 regs2 mem2 pc2 (_ bv0 12) reg_ra reg_zero)
        )
        (constant_folding_simple_SUCCESS2 regs0 mem0 pc0 regs2 mem2 pc2))))

; ======================================================================
; Observable-address predicate
; ======================================================================
;
; The initial stack frame [sp0 - 32, sp0) is private/dead memory.
; All addresses outside that interval are observable.

(declare-rel obs_addr ((_ BitVec 64) (_ BitVec 64)))

(rule
  (forall ((sp0 (_ BitVec 64)) (a (_ BitVec 64)))
    (=> (or (bvult a (bvsub sp0 (_ bv32 64)))
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
          (bvuge sp0 (_ bv32 64))
          (constant_folding_simple_SUCCESS1 regs0 mem0 pc0 regs1 mem1 pc1)
          (constant_folding_simple_SUCCESS2 regs0 mem0 pc0 regs2 mem2 pc2)
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
          (bvuge sp0 (_ bv32 64))
          (constant_folding_simple_SUCCESS1 regs0 mem0 pc0 regs1 mem1 pc1)
          (constant_folding_simple_SUCCESS2 regs0 mem0 pc0 regs2 mem2 pc2)
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
          (bvuge sp0 (_ bv32 64))
          (constant_folding_simple_SUCCESS1 regs0 mem0 pc0 regs1 mem1 pc1)
          (constant_folding_simple_SUCCESS2 regs0 mem0 pc0 regs2 mem2 pc2)
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
          (bvuge sp0 (_ bv32 64))
          (constant_folding_simple_SUCCESS1 regs0 mem0 pc0 regs1 mem1 pc1)
          (constant_folding_simple_SUCCESS2 regs0 mem0 pc0 regs2 mem2 pc2)
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
          (bvuge sp0 (_ bv32 64))
          (constant_folding_simple_SUCCESS1 regs0 mem0 pc0 regs1 mem1 pc1)
          (constant_folding_simple_SUCCESS2 regs0 mem0 pc0 regs2 mem2 pc2)
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
          (bvuge sp0 (_ bv32 64))
          (constant_folding_simple_SUCCESS1 regs0 mem0 pc0 regs1 mem1 pc1)
          (constant_folding_simple_SUCCESS2 regs0 mem0 pc0 regs2 mem2 pc2)
          (obs_addr sp0 a)
          (not (= (select mem1 a) (select mem2 a))))
        bad)))

(query bad)
