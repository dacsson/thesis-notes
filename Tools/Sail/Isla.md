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