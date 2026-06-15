# ==================================================
# Ricover Format File
# ==================================================
# Source file: /tmp/ricover_csmith_simple/prog_399.c
# Function: func_39
# Comparison: Obase vs instcombine
# Instructions in src (Obase): 15
# Instructions in tgt (instcombine): 9
# ==================================================

# Function: src (Obase version)
.globl src
src:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    addi s0, sp, 32
    sw a0, 12(sp)
    sw a1, 8(sp)
    sw a2, 4(sp)
    sb a3, 3(sp)
    li a1, 109
    li a0, 109
    sb a1, 2(sp)
    ld ra, 24(sp)
    ld s0, 16(sp)
    addi sp, sp, 32
    ret


# Function: tgt (instcombine version)
.globl tgt
tgt:
    addi sp, sp, -16
    sd ra, 8(sp)
    sd s0, 0(sp)
    addi s0, sp, 16
    li a0, 109
    ld ra, 8(sp)
    ld s0, 0(sp)
    addi sp, sp, 16
    ret
