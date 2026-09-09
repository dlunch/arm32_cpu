@ Signed/unsigned long products and accumulators, including 64-bit wrap.
b start
inputs:
.word 0, 1, 0, 0
.word 0xffffffff, 0xffffffff, 0, 0
.word 0xffffffff, 2, 0, 0
.word 0x80000000, 0x80000000, 0, 0
.word 1, 1, 0xffffffff, 0xffffffff
.word 1, 1, 0xffffffff, 0x7fffffff
.word 0xffffffff, 2, 2, 0
.word 0xffffffff, 2, 1, 0
start:
adr r10, inputs
mov r11, #0x100000
.irp operation, umull, umull, smull, smull, umlal, umlal, smlal, smlal
ldmia r10!, {r5-r8}
.irp set_flags, 0, 1
.irp flags, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
mov r0, r5
mov r1, r6
mov r2, r7
mov r3, r8
mov r12, #(\flags << 28)
msr cpsr_f, r12
.if \set_flags
\operation\()s r2, r3, r0, r1
.else
\operation r2, r3, r0, r1
.endif
mrs r4, cpsr
stmia r11!, {r0-r4}
.endr
.endr
.endr

@ Both destination words alias the multiplicands.
.irp operation, umulls, umlals, smulls, smlals
mov r0, #3
mov r1, #7
msr cpsr_f, #0xf0000000
\operation r0, r1, r0, r1
mrs r2, cpsr
stmia r11!, {r0-r2}
.endr
