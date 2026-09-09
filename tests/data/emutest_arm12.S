@ Unsigned/signed long products, an aliased source and accumulator wrap.
mov r5, #0x1000
mvn r0, #0
mvn r1, #0
msr cpsr_f, #0x30000000
umulls r2, r3, r0, r1
mrs r4, cpsr
stmia r5!, {r2-r4}

mov r1, #2
smulls r2, r1, r0, r1
mrs r4, cpsr
str r2, [r5], #4
str r1, [r5], #4
str r4, [r5], #4

mov r0, #1
mov r1, #1
mvn r2, #0
mvn r3, #0
umlals r2, r3, r0, r1
mrs r4, cpsr
stmia r5!, {r2-r4}

@ S is clear even though the accumulated result is negative.
mvn r0, #0
mov r1, #2
mov r2, #1
mov r3, #0
smlal r2, r3, r0, r1
mrs r4, cpsr
stmia r5!, {r2-r4}
