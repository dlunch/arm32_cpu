@ BLX LR, BX PC and PC loads interwork and preserve their writeback.
mov r5, #0x1000
msr cpsr_f, #0x30000000
adr lr, thumb_call + 1
blx lr
str r0, [r5]
mrs r1, cpsr
str r1, [r5, #4]

adr lr, arm_call
blx lr
str r0, [r5, #8]
bx pc
add r0, #1
str r0, [r5, #12]

mov r4, #0x2000
adr r2, thumb_load + 1
str r2, [r4]
adr lr, loaded_thumb
ldr pc, [r4], #4
loaded_thumb:
str r4, [r5, #16]
str r0, [r5, #20]

adr r2, arm_call
str r2, [r4]
adr lr, loaded_arm
ldr pc, [r4]
loaded_arm:
str r0, [r5, #24]

mov r4, #0x2000
mov r2, #55
str r2, [r4]
adr r2, thumb_multiple + 1
str r2, [r4, #4]
adr lr, loaded_multiple_thumb
ldmia r4!, {r1, pc}
loaded_multiple_thumb:
str r1, [r5, #28]
str r4, [r5, #32]
str r0, [r5, #36]
mrs r2, cpsr
str r2, [r5, #40]

mov r4, #0x2000
mov r2, #66
str r2, [r4]
adr r2, arm_call
str r2, [r4, #4]
adr lr, loaded_multiple_arm
ldmia r4, {r1, pc}
loaded_multiple_arm:
str r1, [r5, #44]
str r4, [r5, #48]
str r0, [r5, #52]
b finish

arm_call:
mov r0, #22
bx lr

.thumb
thumb_call:
mov r0, #11
bx lr
thumb_load:
mov r0, #33
bx lr
thumb_multiple:
mov r0, #44
bx lr

.balign 4
.arm
finish:
