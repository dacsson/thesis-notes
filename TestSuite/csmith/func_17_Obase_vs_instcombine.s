# ==================================================
# Ricover Format File
# ==================================================
# Source file: /tmp/ricover_csmith_simple/prog_359.c
# Function: func_17
# Comparison: Obase vs instcombine
# Instructions in src (Obase): 18
# Instructions in tgt (instcombine): 9
# ==================================================

# Function: src (Obase version)
.globl src
src:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp)
    addi s0, sp, 64
    sb a0, 47(sp)
    sd a1, 32(sp)
    sd a2, 24(sp)
    sb a3, 23(sp)
    sd a4, 8(sp)
    lui a1, 10
    li a0, 95
    addi a1, a1, 1631
    sh a1, 6(sp)
    sw a1, 0(sp)
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
    li a0, 95
    ld ra, 8(sp)
    ld s0, 0(sp)
    addi sp, sp, 16
    ret
