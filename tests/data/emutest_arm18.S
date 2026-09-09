@ Byte, signed byte/halfword and halfword-store encodings stay distinct.
b start
input:
.word 0x1234ff80
start:
ldr r5, input
mov r11, #0x100000
msr cpsr_f, #0xb0000000
.irp operation, ldrb, ldrb_register, ldrh, ldrsb, ldrsh
mov r0, #0x80000
mov r1, #0
str r5, [r0]
.ifc \operation,ldrb_register
ldrb r2, [r0, r1, lsl #2]
.else
\operation r2, [r0]
.endif
mrs r4, cpsr
ldr r3, [r0]
str r0, [r11], #4
str r2, [r11], #4
str r4, [r11], #4
str r3, [r11], #4
.endr
mov r0, #0x80000
mov r3, #0
str r3, [r0]
mov r2, r5
strh r2, [r0, #2]!
mrs r4, cpsr
ldr r3, [r0, #-2]
str r0, [r11], #4
str r2, [r11], #4
str r4, [r11], #4
str r3, [r11], #4
