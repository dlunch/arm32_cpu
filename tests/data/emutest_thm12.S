@ ARM setup/capture leaves Thumb MUL as the only flag-changing operation.
.thumb
bx pc
nop
.arm
b start
inputs:
.word 0, 1
.word 3, 7
.word 0xffffffff, 2
.word 0x80000000, 2
.word 3, 7
start:
adr r10, inputs
mov r5, #0x100000
.irp source, r1, r1, r1, r1, r0
ldmia r10!, {r8-r9}
.irp flags, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
mov r0, r8
mov r1, r9
mov r12, #(\flags << 28)
msr cpsr_f, r12
adr r6, 1f + 1
adr r7, 2f
bx r6
1:
.thumb
mul r0, \source
str r0, [r5]
str r1, [r5, #4]
bx r7
.balign 4
2:
.arm
mrs r2, cpsr
str r2, [r5, #8]
add r5, #12
.endr
.endr
@ The unchanged Thumb rule appends its own terminating halfword.
adr r0, 3f + 1
bx r0
.thumb
3:
