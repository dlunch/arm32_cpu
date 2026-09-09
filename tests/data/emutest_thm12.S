@ Thumb MUL preserves CV for zero, negative and self-aliased results.
.thumb
bx pc
nop
.arm
mov r5, #0x1000
msr cpsr_f, #0x30000000
mov r0, #0
mov r1, #1
adr r2, zero + 1
bx r2
.thumb
zero:
mul r0, r1
str r0, [r5]
bx pc
nop
.arm
mrs r3, cpsr
str r3, [r5, #4]

msr cpsr_f, #0x70000000
mov r0, #0x80000000
mov r1, #1
adr r2, negative + 1
bx r2
.thumb
negative:
mul r0, r1
str r0, [r5, #8]
bx pc
nop
.arm
mrs r3, cpsr
str r3, [r5, #12]

msr cpsr_f, #0x30000000
mov r0, #3
adr r2, square + 1
bx r2
.thumb
square:
mul r0, r0
str r0, [r5, #16]
bx pc
nop
.arm
mrs r3, cpsr
str r3, [r5, #20]
adr r0, finish + 1
bx r0
.thumb
finish:
