@ LDRD captures an aliased base; PC-relative and wrapping addresses work.
mov r5, #0x1000
mov r4, #0x2000
ldr r0, =0x11223344
ldr r1, =0x55667788
stmia r4, {r0-r1}
mov r2, r4
ldrd r2, [r2]
str r2, [r5]
str r3, [r5, #4]

ldrd r2, [pc, #(data - . - 8)]
str r2, [r5, #8]
str r3, [r5, #12]

mvn r4, #7
mov r0, #0x77
mov r1, #0x88
stmia r4, {r0-r1}
ldrd r2, [r4], #8
str r2, [r5, #16]
str r3, [r5, #20]
str r4, [r5, #24]

mov r2, #0x99
mov r3, #0xaa
strd r2, [r4, #-8]
mvn r4, #7
strd r2, [r4, #8]!
str r4, [r5, #28]
b finish
.balign 8
data:
.word 0x89abcdef, 0x01234567
.ltorg
finish:
