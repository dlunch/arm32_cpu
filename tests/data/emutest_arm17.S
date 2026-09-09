@ Doubleword base/source aliases, PC-relative operands and address wrap.
b start
inputs:
.word 0x11223344, 0x55667788, 0x9abcdef0, 0x12345678
start:
adr r10, inputs
ldmia r10, {r5-r6, r8-r9}
mov r11, #0x100000
msr cpsr_f, #0xb0000000
.irp base, r2, r3
mov r4, #0x80000
str r5, [r4]
str r6, [r4, #4]
mov r2, r4
mov r3, r4
ldrd r2, [\base]
mrs r0, cpsr
stmia r11!, {r2-r4}
str r0, [r11], #4
ldmia r4, {r0-r1}
stmia r11!, {r0-r1}
.endr

.irp addressing, 0, 1, 2, 3
mov r4, #0x80000
mov r10, r4
mov r2, r5
mov r3, r6
.if \addressing == 0
mov r2, r4
strd r2, [r2]
.elseif \addressing == 1
mov r3, r4
strd r2, [r3]
.elseif \addressing == 2
mov r2, #0x18
add r10, #0x18
strd r2, [r4, r2]!
.else
mov r3, #0x18
strd r2, [r4], r3
.endif
mrs r0, cpsr
stmia r11!, {r2-r4}
str r0, [r11], #4
ldmia r10, {r0-r1}
stmia r11!, {r0-r1}
.endr

.irp addressing, 0, 1
.irp operation, ldrd, strd
mov r4, #0x80000
mov r2, r8
mov r3, r9
adr r10, 2f
.if \addressing
mov r6, #(2f - 1f - 8)
1:
\operation r2, [pc, r6]
.else
1:
\operation r2, [pc, #(2f - 1b - 8)]
.endif
b 3f
.balign 8
2:
.word 0x11223344, 0x55667788
3:
mrs r0, cpsr
stmia r11!, {r2-r4}
str r0, [r11], #4
ldmia r10, {r0-r1}
stmia r11!, {r0-r1}
.endr
.endr

ldr r6, inputs + 4
.irp addressing, 0, 1, 2
.irp operation, ldrd, strd
mov r2, r8
mov r3, r9
mvn r4, #7
mov r10, r4
.if \addressing == 0
mov r10, #0
.elseif \addressing == 1
mov r4, #0
.endif
str r5, [r10]
str r6, [r10, #4]
.if \addressing == 0
\operation r2, [r4, #8]!
.elseif \addressing == 1
\operation r2, [r4, #-8]
.else
\operation r2, [r4], #8
.endif
mrs r0, cpsr
stmia r11!, {r2-r4}
str r0, [r11], #4
ldmia r10, {r0-r1}
stmia r11!, {r0-r1}
.endr
.endr
