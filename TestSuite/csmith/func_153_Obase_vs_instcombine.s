# ==================================================
# Ricover Format File
# ==================================================
# Source file: /tmp/ricover_csmith_simple/prog_395.c
# Function: func_153
# Comparison: Obase vs instcombine
# Instructions in src (Obase): 28
# Instructions in tgt (instcombine): 11
# ==================================================

# Function: src (Obase version)
.globl src
src:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp)
    addi s0, sp, 64
    sd a0, 40(sp)
    li a0, -8
    li a1, 21
    sb a0, 39(sp)
    li a0, 4
    sw a1, 32(sp)
    lui a1, 315631
    sb a0, 27(sp)
    li a0, 1
    sw zero, 28(sp)
    addi a1, a1, 475
    sw a1, 20(sp)
    lui a1, 523170
    sw a0, 12(sp)
    sw a0, 16(sp)
    slli a0, a0, 32
    addi a1, a1, -189
    addi a0, a0, -2
    sw a0, 4(sp)
    sw a1, 8(sp)
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
    li a0, 1
    slli a0, a0, 32
    addi a0, a0, -2
    ld ra, 8(sp)
    ld s0, 0(sp)
    addi sp, sp, 16
    ret
