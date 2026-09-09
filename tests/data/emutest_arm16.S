@ Doubleword post/pre-indexing, negative offsets and source capture.
mov r5, #0x1000
mov r4, #0x2000
ldr r0, =0x11223344
ldr r1, =0x55667788
stmia r4, {r0-r1}
msr cpsr_f, #0x30000000
ldrd r2, [r4], #8
str r2, [r5]
str r3, [r5, #4]
str r4, [r5, #8]

mov r2, #0x18
mov r3, #0x55
strd r2, [r4, r2]!
str r4, [r5, #12]

ldrd r2, [r4, #-0x20]
str r2, [r5, #16]
str r3, [r5, #20]

add r4, #0x10
mov r6, #0x10
strd r2, [r4], -r6
ldreqd r2, [r4, #8]!
streqd r2, [r4, #8]!
str r4, [r5, #24]
mrs r0, cpsr
str r0, [r5, #28]
b finish
.ltorg
finish:
