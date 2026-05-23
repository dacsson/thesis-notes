# ==================================================
# Ricover Format File
# ==================================================
# Source file: /tmp/ricover_csmith_simple/prog_379.c
# Function: func_38
# Comparison: Obase vs instcombine
# Instructions in src (Obase): 11
# Instructions in tgt (instcombine): 9
# ==================================================

# Function: src (Obase version)
.globl src
src:
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    addi s0, sp, 32
    sh a0, 14(sp)
    sb a1, 13(sp)
    mv a0, a1
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
    mv a0, a1
    ld ra, 8(sp)
    ld s0, 0(sp)
    addi sp, sp, 16
    ret
