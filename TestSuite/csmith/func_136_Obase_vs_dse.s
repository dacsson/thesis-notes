# ==================================================
# Ricover Format File
# ==================================================
# Source file: /tmp/ricover_csmith_relaxed_20260522_222831/prog_000/program.c
# Function: func_136
# Comparison: Obase vs dse
# Instructions in src (Obase): 33
# Instructions in tgt (dse): 10
# ==================================================

# Function: src (Obase version)
.globl src
src:
    addi sp, sp, -64
    sd ra, 56(sp)
    sd s0, 48(sp)
    addi s0, sp, 64
    sh a1, 46(sp)
    sb a0, 45(sp)
    sd a2, 32(sp)
    sb a3, 31(sp)
    lui a0, 3
    lui a3, 536622
    lui a4, 12
    sh a1, 26(sp)
    sh a1, 24(sp)
    addi a0, a0, -1100
    sh a0, 28(sp)
    lb a0, 0(a2)
    lbu a1, 4(a2)
    addi a3, a3, -260
    addi a4, a4, -1698
    sw a3, 20(sp)
    slli a3, a4, 32
    add a3, a3, a4
    sd a3, 8(sp)
    sh a4, 16(sp)
    lui a3, 1048572
    andi a1, a1, 3
    or a1, a1, a0
    addi a0, a3, -1698
    sb a1, 0(a2)
    ld ra, 56(sp)
    ld s0, 48(sp)
    addi sp, sp, 64
    ret


# Function: tgt (dse version)
.globl tgt
tgt:
    addi sp, sp, -16
    sd ra, 8(sp)
    sd s0, 0(sp)
    addi s0, sp, 16
    lui a0, 1048572
    addi a0, a0, -1698
    ld ra, 8(sp)
    ld s0, 0(sp)
    addi sp, sp, 16
    ret
