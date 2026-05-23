# ==================================================
# Ricover Format File
# ==================================================
# Source file: /tmp/ricover_csmith_simple/prog_325.c
# Function: func_46
# Comparison: Obase vs instcombine
# Instructions in src (Obase): 27
# Instructions in tgt (instcombine): 10
# ==================================================

# Function: src (Obase version)
.globl src
src:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp)
    addi s0, sp, 64
    sd a0, 40(sp)
    sw a1, 36(sp)
    lui a0, 1
    li a1, 6
    sw a1, 24(sp)
    li a1, -1
    sh a1, 14(sp)
    sw a1, 8(sp)
    lui a1, 450306
    addi a0, a0, -149
    sw a0, 32(sp)
    lui a0, 305896
    addi a1, a1, -1001
    sw a1, 28(sp)
    lui a1, 1048568
    addi a2, a0, 1577
    addi a0, a1, 1577
    sw a2, 20(sp)
    sw zero, 16(sp)
    ld ra, 56(sp)
    ld s0, 48(sp)
    addi sp, sp, 64
    ret


# Function: tgt (instcombine version)
.globl tgt
tgt:
    addi sp, sp, -16
    sd ra, 8(sp)
    sd s0, 0(sp)
    addi s0, sp, 16
    lui a0, 1048568
    addi a0, a0, 1577
    ld ra, 8(sp)
    ld s0, 0(sp)
    addi sp, sp, 16
    ret
