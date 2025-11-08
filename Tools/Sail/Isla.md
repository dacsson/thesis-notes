## General

The tool itself translates JibIR (Sail's IR) to it's own ir. For example see [[Data/riscv.sail]] => [[Data/riscv.ir]].

## isla-footprint

`isla-footprint` prints simplified instruction opcode summaries and dependency information, e.g.

```shell
$ target/release/isla-footprint -A aarch64.ir -C configs/aarch64.toml -i "add x0, x1, #3" -s
opcode: #x91000c20
Execution took: 80ms
(trace
  (declare-const v7 (_ BitVec 32))
  (assert (= (bvor #b0 ((_ extract 0 0) (bvlshr (bvor (bvand v7 #xfffffffe) #x00000001) #x00000000))) #b1))
  (branch-address #x0000000010300000)
  (declare-const v3370 (_ BitVec 64))
  (define-const v3371 v3370)
  (cycle)
  (read-reg |SEE| nil (_ bv-1 128))
  (write-reg |SEE| nil (_ bv1066 128))
  (write-reg |__unconditional| nil true)
  (read-reg |__v85_implemented| nil false)
  (read-reg |R1| nil v3371)
  (define-const v3457 (bvadd ((_ extract 63 0) ((_ zero_extend 64) v3371)) #x0000000000000003))
  (write-reg |R0| nil v3457))
```

Example SMT risc-v trace:
```
~/Uni/Thesis/isla  =>  target/debug/isla-footprint -A riscv64.ir -C configs/riscv64_ubuntu.toml -i "add x0, x1, 3" -s --verbose
[log]: Parsing took: 566ms
[log]: opcode: #x00308013
[log]: Execution took: 21ms
(trace
  (assume-reg |rv_enable_writable_misa| nil true)
  (assume-reg |rv_enable_rvc| nil true)
  (assume-reg |rv_enable_fdext| nil false)
  (assume-reg |rv_enable_zfinx| nil false)
  (assume-reg |rv_enable_next| nil false)
  (assume-reg |rv_enable_zcb| nil false)
  (assume-reg |rv_enable_writable_fiom| nil false)
  (assume-reg |rv_pmp_count| nil (_ bv0 64))
  (assume-reg |rv_pmp_grain| nil (_ bv0 64))
  (assume-reg |rv_enable_vext| nil false)
  (assume-reg |rv_enable_dirty_update| nil false)
  (assume-reg |rv_enable_misaligned_access| nil false)
  (assume-reg |rv_mtval_has_illegal_inst_bits| nil false)
  (assume-reg |rv_ram_base| nil #x0000000080000000)
  (assume-reg |rv_ram_size| nil #x0000000004000000)
  (assume-reg |rv_rom_base| nil #x0000000000001000)
  (assume-reg |rv_rom_size| nil #x0000000000000100)
  (assume-reg |rv_clint_base| nil #x0000000002000000)
  (assume-reg |rv_clint_size| nil #x00000000000c0000)
  (assume-reg |rv_htif_tohost| nil #x0000000080001000)
  (assume-reg |rv_insns_per_tick| nil (_ bv10 128))
  (assume-reg |tlb| nil (|None| (_ unit)))
  (define-enum |Privilege| 3 (|User| |Supervisor| |Machine|)) ; 0:0 - 0:0
  (define-enum |Architecture| 3 (|RV32| |RV64| |RV128|)) ; 0:0 - 0:0
  (define-enum |PmpAddrMatchType| 4 (|OFF| |TOR| |NA4| |NAPOT|)) ; 0:0 - 0:0
  (cycle)
  (declare-const v244 (_ BitVec 64)) ; model/main.sail 47:15 - 47:21
  (read-reg |PC| nil v244)
  (define-const v245 (bvadd v244 #x0000000000000004)) ; 0:0 - 0:0
  (write-reg |nextPC| nil v245)
  (define-enum |iop| 6 (|RISCV_ADDI| |RISCV_SLTI| |RISCV_SLTIU| |RISCV_XORI| |RISCV_ORI| |RISCV_ANDI|)) ; 0:0 - 0:0
  (declare-const v253 (_ BitVec 64)) ; model/riscv_regs.sail 56:11 - 56:13
  (read-reg |x1| nil v253)
  (define-enum |Retired| 2 (|RETIRE_SUCCESS| |RETIRE_FAIL|)) ; 0:0 - 0:0
  (read-reg |nextPC| nil v245)
  (write-reg |PC| nil v245))
```