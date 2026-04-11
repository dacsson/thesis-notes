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

;; Read 4 bytes (word) from memory, sign-extended to 64 bits
(define-fun read_mem_word ((mem (Array (_ BitVec 64) (_ BitVec 8)))
                           (addr (_ BitVec 64))) (_ BitVec 64)
  ((_ sign_extend 32)
    (concat (select mem (bvadd addr (_ bv3 64)))
            (concat (select mem (bvadd addr (_ bv2 64)))
                    (concat (select mem (bvadd addr (_ bv1 64)))
                            (select mem addr))))))

;; Read 8 bytes (doubleword) from memory
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

;; --- Register index constants (ABI names) ---
(define-fun reg_zero () (_ BitVec 5) (_ bv0 5))
(define-fun reg_ra   () (_ BitVec 5) (_ bv1 5))
(define-fun reg_sp   () (_ BitVec 5) (_ bv2 5))
(define-fun reg_s0   () (_ BitVec 5) (_ bv8 5))
(define-fun reg_a0   () (_ BitVec 5) (_ bv10 5))
