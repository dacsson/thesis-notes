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

;; Found 2 instruction variant(s) in execute function

;; --- ADDI instruction (from Isla IR [3..29]) ---
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

;; --- LOAD instruction (from Isla IR [30..62]) ---
(declare-rel load
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
    (=> (and (= regs1 (set_reg regs0 p2 (mem_read_8 mem0 (bvadd (get_reg regs0 p1) ((_ sign_extend 52) p0)))))
             (= mem1 mem0)
             (= pc1 (bvadd pc0 (_ bv4 64))))
        (load regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))

;; --- IR dump for reference ---
;; [0] decl $0 : Unit
;; [1] jump merge#var is ITYPE goto 29
;; [2] jump @neq(RISCV_ADDI, merge#var as ITYPE.tuple#%bv12_%bv5_%bv5_%enum ziop3) goto 29
;; [3] decl $1 : Bits(12)
;; [4] $1 = merge#var as ITYPE.tuple#%bv12_%bv5_%bv5_%enum ziop0
;; [5] decl $2 : Bits(5)
;; [6] $2 = merge#var as ITYPE.tuple#%bv12_%bv5_%bv5_%enum ziop1
;; [7] decl $3 : Bits(5)
;; [8] $3 = merge#var as ITYPE.tuple#%bv12_%bv5_%bv5_%enum ziop2
;; [9] decl $4 : Bits(64)
;; [10] $4 = rX($2)
;; [11] decl $5 : Bits(64)
;; [12] decl $6 : I128
;; [13] $6 = %i64->%i(64)
;; [14] decl $7 : AnyBits
;; [15] $7 = $1
;; [16] decl $8 : AnyBits
;; [17] $8 = EXTS($6, $7)
;; [18] $5 = $8
;; [19] decl $9 : Bits(64)
;; [20] decl $10 : AnyBits
;; [21] $10 = $4
;; [22] decl $11 : AnyBits
;; [23] $11 = $5
;; [24] decl $12 : AnyBits
;; [25] $12 = add_bits($10, $11)
;; [26] $9 = $12
;; [27] $0 = wX($3, $9)
;; [28] goto 63
;; [29] jump merge#var is LOAD goto 62
;; [30] decl $13 : Bits(12)
;; [31] $13 = merge#var as LOAD.tuple#%bv12_%bv5_%bv50
;; [32] decl $14 : Bits(5)
;; [33] $14 = merge#var as LOAD.tuple#%bv12_%bv5_%bv51
;; [34] decl $15 : Bits(5)
;; [35] $15 = merge#var as LOAD.tuple#%bv12_%bv5_%bv52
;; [36] decl $16 : Bits(64)
;; [37] decl $17 : Bits(64)
;; [38] $17 = rX($14)
;; [39] decl $18 : Bits(64)
;; [40] decl $19 : I128
;; [41] $19 = %i64->%i(64)
;; [42] decl $20 : AnyBits
;; [43] $20 = $13
;; [44] decl $21 : AnyBits
;; [45] $21 = EXTS($19, $20)
;; [46] $18 = $21
;; [47] decl $22 : AnyBits
;; [48] $22 = $17
;; [49] decl $23 : AnyBits
;; [50] $23 = $18
;; [51] decl $24 : AnyBits
;; [52] $24 = add_bits($22, $23)
;; [53] $16 = $24
;; [54] decl $25 : Bits(64)
;; [55] decl $26 : I128
;; [56] $26 = %i64->%i(8)
;; [57] decl $27 : AnyBits
;; [58] $27 = read_mem($16, $26)
;; [59] $25 = $27
;; [60] $0 = wX($15, $25)
;; [61] goto 63
;; [62] $0 = ()
;; [63] eturn = $0
;; [64] end
; ======================================================================
; Hand-written fallback instruction rules
; ======================================================================

;; Hand-written fallback rules for opcodes not yet in the IR:
;; {"lw", "sw", "ret", "addiw", "sd"}

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

; ======================================================================
; Programs
; ======================================================================

(declare-rel foo1
  ((Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64)) (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)))

(rule
  (forall ...
    (=> (and
          ; addi a0, zero, 1
          (addi regs4 mem4 pc4 regs5 mem5 pc5 (_ bv1 12) reg_zero reg_a0)
          ...
          ; ret
          (ret regs13 mem13 pc13 regs14 mem14 pc14)
        )
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
          ; ret
          (ret regs1 mem1 pc1 regs2 mem2 pc2)
        )
        (foo2 regs0 mem0 pc0 regs2 mem2 pc2))))

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
          ; Guard against wraparound of the private frame interval
          (bvuge sp0 (_ bv32 64))
          (foo1 regs0 mem0 pc0 regs1 mem1 pc1)
          (foo2 regs0 mem0 pc0 regs2 mem2 pc2)
          ; ABI-visible register equality
          (= pc1 pc2)
          (= (get_reg regs1 reg_a0) (get_reg regs2 reg_a0))
          (= (get_reg regs1 reg_ra) (get_reg regs2 reg_ra))
          (= (get_reg regs1 reg_sp) (get_reg regs2 reg_sp))
          (= (get_reg regs1 reg_s0) (get_reg regs2 reg_s0))
          ; Observable memory differs at some address
          (obs_addr sp0 a)
          (not (= (select mem1 a) (select mem2 a))))
        bad)))

(query bad)
