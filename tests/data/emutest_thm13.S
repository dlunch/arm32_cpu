@ Thumb BL and BLX pairs return to the next Thumb instruction.
.thumb
bx pc
nop
.arm
mov r5, #0x1000
msr cpsr_f, #0x30000000
mov r6, #0x100
add r6, #1
bx r6

.org 0x100
.thumb
bl thumb_callee
blx arm_callee
mov r0, #33
str r0, [r5, #20]
b finish

.org 0x200
thumb_callee:
mov r0, #11
str r0, [r5]
mov r1, lr
str r1, [r5, #4]
bx lr

.org 0x300
.arm
arm_callee:
mov r0, #22
str r0, [r5, #8]
str lr, [r5, #12]
mrs r1, cpsr
str r1, [r5, #16]
bx lr
.thumb
finish:
