foo1:
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	addi s0, sp, 32
	addi a0, zero, 1
	sw a0, -20(s0)
	lw a0, -20(s0)
	addiw a0, a0, 2
	sw a0, -24(s0)
	lw a0, -24(s0)
	ld ra, 24(sp)
	ld s0, 16(sp)
	addi sp, sp, 32
	ret
