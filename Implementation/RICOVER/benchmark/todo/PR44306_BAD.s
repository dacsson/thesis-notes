# 1. Bug PR: https://llvm.org/PR44306
#            https://github.com/llvm/llvm-project/issues/41543
# 2. LLVM-IR source: https://godbolt.org/z/b6K1YWxzh
#
#    define void @src(i32* %pz, i32* %px, i32* %py) {
#    %t2 = load i32, i32* %py
#    %t3 = load i32, i32* %px
#    %cmp = icmp slt i32 %t2, %t3
#    %select = select i1 %cmp, i32* %px, i32* %py
#    %bc = bitcast i32* %select to i64*
#    %r = load i64, i64* %bc
#    %t1 = bitcast i32* %pz to i64*
#    store i64 %r, i64* %t1
#    ret void
#    }
#
#    define void @src(i32* %pz, i32* %px, i32* %py) {
#    %t2 = load i32, i32* %py
#    %t3 = load i32, i32* %px
#    %cmp = icmp slt i32 %t2, %t3
#    %select = select i1 %cmp, i32* %px, i32* %py
#    %bc = bitcast i32* %select to i64*
#    %r = load i64, i64* %bc
#    %t1 = bitcast i32* %pz to i64*
#    store i64 %r, i64* %t1
#    ret void
#    }
#
# 3. Alive2 output: TODO


src:                                    # @src
        lw      a3, 0(a2)
        lw      a4, 0(a1)
        blt     a3, a4, .LBB0_2
        mv      a1, a2
.LBB0_2:
        ld      a1, 0(a1)
        sd      a1, 0(a0)
        ret

tgt:                                    # @tgt
        lw      a2, 0(a2)
        lw      a1, 0(a1)
        blt     a2, a1, .LBB0_2
        mv      a1, a2
.LBB0_2:
        sw      a1, 0(a0)
        ret
