@ PLD leaves registers, flags and existing memory unchanged.
mov r0, #0x2000
mvn r1, #0
mov r2, #77
str r2, [r0]
msr cpsr_f, #0xb0000000
pld [r0]
pld [r1, #0x20]
pld [r0, -r1, lsl #2]
pld [pc, #4]
mrs r3, cpsr
mov r4, #0x1000
stmia r4, {r0-r3}
