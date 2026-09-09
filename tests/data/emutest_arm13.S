@ Unrotated immediates preserve C; rotated immediates replace C, not V.
mov r5, #0x1000
msr cpsr_f, #0x30000000
movs r0, #2
mrs r1, cpsr
stmia r5!, {r0-r1}

ands r0, r0, #1
mrs r1, cpsr
stmia r5!, {r0-r1}

msr cpsr_f, #0x10000000
movs r0, #0x80000000
mrs r1, cpsr
stmia r5!, {r0-r1}

movs r0, #0x20000000
mrs r1, cpsr
stmia r5!, {r0-r1}

mov r0, #2
tst r0, #2
mrs r1, cpsr
stmia r5!, {r0-r1}
