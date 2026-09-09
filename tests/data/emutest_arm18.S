@ Byte, signed byte/halfword and halfword-store encodings stay distinct.
mov r4, #0x2000
mov r5, #0x1000
ldr r0, =0x1234ff80
str r0, [r4]
msr cpsr_f, #0x30000000
ldrb r1, [r4]
str r1, [r5]
ldrh r1, [r4]
str r1, [r5, #4]
ldrsb r1, [r4]
str r1, [r5, #8]
ldrsh r1, [r4]
str r1, [r5, #12]
mov r2, #1
ldrb r1, [r4, r2, lsl #1]
str r1, [r5, #16]
strh r0, [r4, #2]!
str r4, [r5, #20]
mrs r1, cpsr
str r1, [r5, #24]
b finish
.ltorg
finish:
