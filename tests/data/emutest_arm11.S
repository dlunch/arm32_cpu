@ MUL/MLA preserve CV, capture aliases, and leave flags alone without S.
mov r5, #0x1000
mov r0, #0
mov r1, #1
msr cpsr_f, #0x30000000
muls r0, r1, r0
mrs r2, cpsr
str r0, [r5]
str r2, [r5, #4]

mov r0, #0x80000000
mov r1, #1
msr cpsr_f, #0x70000000
muls r1, r0, r1
mrs r2, cpsr
str r1, [r5, #8]
str r2, [r5, #12]

mov r0, #3
mov r1, #7
msr cpsr_f, #0xf0000000
mul r1, r0, r1
mrs r2, cpsr
str r1, [r5, #16]
str r2, [r5, #20]

mvn r0, #0
mov r1, #2
mov r2, #2
msr cpsr_f, #0x30000000
mlas r2, r0, r1, r2
mrs r3, cpsr
str r2, [r5, #24]
str r3, [r5, #28]

mov r0, #3
mov r1, #7
mov r2, #11
msr cpsr_f, #0xf0000000
mla r2, r0, r1, r2
mrs r3, cpsr
str r2, [r5, #32]
str r3, [r5, #36]

msr cpsr_f, #0xb0000000
muleqs r1, r0, r1
mlaeqs r2, r0, r1, r2
mrs r3, cpsr
str r1, [r5, #40]
str r2, [r5, #44]
str r3, [r5, #48]
