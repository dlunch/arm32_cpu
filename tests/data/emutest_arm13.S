@ Unrotated immediates preserve C; rotated immediates replace it, not V.
b start
input:
.word 0x12345678
start:
ldr r8, input
mov r11, #0x100000
.irp operation, ands, eors, tst, teq, orrs, movs, bics, mvns
.irp immediate, 2, 0x80000000, 0x20000000
.irp carry, 0, 1
mov r0, r8
mov r2, #0x55
mov r12, #(0x10000000 | (\carry << 29))
msr cpsr_f, r12
.ifc \operation,tst
tst r0, #\immediate
.else
.ifc \operation,teq
teq r0, #\immediate
.else
.ifc \operation,movs
movs r2, #\immediate
.else
.ifc \operation,mvns
mvns r2, #\immediate
.else
\operation r2, r0, #\immediate
.endif
.endif
.endif
.endif
mrs r3, cpsr
str r0, [r11], #4
str r2, [r11], #4
str r3, [r11], #4
.endr
.endr
.endr
