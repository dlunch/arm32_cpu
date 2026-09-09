@ PLD remains an unconditional hint for every NZCV input and address form.
mov r11, #0x100000
.irp flags, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
mov r12, #(\flags << 28)
msr cpsr_f, r12
mvn r0, #7
mvn r1, #0
.irp instruction, 0xf5d0f013, 0xf550ffff, 0xf5dff004, 0xf7d0f101, 0xf750f021, 0xf7d0f041, 0xf750f061
.inst \instruction
mrs r2, cpsr
stmia r11!, {r0-r2}
.endr
.endr
