@ LDRD/STRD: every mode-3 address, both signs, writeback and failed EQ.
b start
inputs:
.word 0x12345678, 0x9abcdef0, 0x11223344, 0x55667788
start:
adr r10, inputs
ldmia r10, {r5, r7-r9}
mov r6, #0x18
mov r11, #0x100000
.irp addressing, 0, 1, 2, 3, 4, 5
.irp up, 0, 1
.irp operation, ldreqd, streqd
.irp passed, 0, 1
mov r2, r8
mov r3, r9
mov r4, #0x80000
mov r10, r4
.if \addressing < 4
.if \up
add r10, #0x18
.else
sub r10, #0x18
.endif
.endif
str r5, [r10]
str r7, [r10, #4]
mov r12, #(0xb0000000 | (\passed << 30))
msr cpsr_f, r12
.if \addressing == 0
.if \up
\operation r2, [r4, #0x18]
.else
\operation r2, [r4, #-0x18]
.endif
.elseif \addressing == 1
.if \up
\operation r2, [r4, r6]
.else
\operation r2, [r4, -r6]
.endif
.elseif \addressing == 2
.if \up
\operation r2, [r4, #0x18]!
.else
\operation r2, [r4, #-0x18]!
.endif
.elseif \addressing == 3
.if \up
\operation r2, [r4, r6]!
.else
\operation r2, [r4, -r6]!
.endif
.elseif \addressing == 4
.if \up
\operation r2, [r4], #0x18
.else
\operation r2, [r4], #-0x18
.endif
.else
.if \up
\operation r2, [r4], r6
.else
\operation r2, [r4], -r6
.endif
.endif
mrs r0, cpsr
stmia r11!, {r2-r4}
str r0, [r11], #4
ldmia r10, {r0-r1}
stmia r11!, {r0-r1}
.endr
.endr
.endr
.endr
