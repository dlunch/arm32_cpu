@ MUL/MLA: all NZCV inputs, S variants, destination aliases and overflow.
b start
inputs:
.word 0, 1, 0, 0xdeadbeef
.word 3, 7, 11, 0xdeadbeef
.word 0x80000000, 1, 1, 0xdeadbeef
.word 0xffffffff, 2, 2, 0xdeadbeef
.word 0x80000000, 2, 9, 0xdeadbeef
start:
adr r10, inputs
mov r11, #0x100000
.rept 5
ldmia r10!, {r5-r8}
.irp destination, r0, r1, r2, r3
.irp accumulate, 0, 1
.irp set_flags, 0, 1
.irp flags, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
mov r0, r5
mov r1, r6
mov r2, r7
mov r3, r8
mov r12, #(\flags << 28)
msr cpsr_f, r12
.if \accumulate
.if \set_flags
mlas \destination, r0, r1, r2
.else
mla \destination, r0, r1, r2
.endif
.else
.if \set_flags
muls \destination, r0, r1
.else
mul \destination, r0, r1
.endif
.endif
mrs r4, cpsr
stmia r11!, {r0-r4}
.endr
.endr
.endr
.endr
.endr

@ Failed EQ conditions must preserve all operands and flags.
.irp operation, mul, mla, umull, umlal, smull, smlal
mov r0, #3
mov r1, #7
mov r2, #11
mov r3, #13
msr cpsr_f, #0xb0000000
.ifc \operation,mul
muleqs r0, r0, r1
.else
.ifc \operation,mla
mlaeqs r0, r0, r1, r2
.else
\operation\()eqs r2, r3, r0, r1
.endif
.endif
mrs r4, cpsr
stmia r11!, {r0-r4}
.endr
