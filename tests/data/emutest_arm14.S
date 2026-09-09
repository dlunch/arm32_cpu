@ Each destination records operands, pipeline PC, CPSR and the LR delta.
b start
values:
.word 0x12345678, 0x98765432
start:
ldr r5, values
ldr r8, values + 4
mov r11, #0x100000
mov r7, #0x6000
mov r12, #0x5000
add r12, #4
msr cpsr_f, #0xb0000000

.irp link, 0, 1
.irp operand, r0, lr
.irp target, 0x4000, 0x5001, 0x5003
.irp wrapped, 0, 1
mov r0, #(\target & ~0xff)
orr r0, #(\target & 0xff)
mov r1, #0x11
mov r2, #0x5000
add r2, #6
mov r3, #0x33
mov lr, #0x7000
.ifc \operand,lr
mov lr, r0
.endif
adr r6, 1f
mov r9, lr
.if \link
.if \wrapped
mov r9, #0
.else
mov r9, r6
.endif
.endif
.if \wrapped
mvn r10, #3
ldr r4, 2f
str r4, [r10]
bx r10
2:
.ifc \operand,lr
.word 0xe12fff1e | (\link << 5)
.else
.word 0xe12fff10 | (\link << 5)
.endif
.else
.if \link
blx \operand
.else
bx \operand
.endif
.endif
1:
.endr
.endr
.endr
.endr

@ Offset, pre/post-indexed, shifted-register and PC-relative LDR PC.
.irp addressing, 0, 1, 2, 3, 4, 5
.irp target, 0x4000, 0x5001, 0x5003
mov r0, #0x80000
mov r1, #2
mov r2, #0x5000
add r2, #6
mov r3, #0x33
mov r4, #(\target & ~0xff)
orr r4, #(\target & 0xff)
mov lr, #0x7000
mov r9, lr
adr r6, 1f
.if \addressing == 0
str r4, [r0, #8]
ldr pc, [r0, #8]
.elseif \addressing == 1
str r4, [r0, #-8]
ldr pc, [r0, #-8]!
.elseif \addressing == 2
str r4, [r0]
ldr pc, [r0], #8
.elseif \addressing == 3
str r4, [r0]
ldr pc, [r0], r1, lsl #2
.elseif \addressing == 4
str r4, [r0, #8]
ldr pc, [r0, r1, lsl #2]
.else
ldr pc, 2f
2:
.word \target
.endif
1:
.endr
.endr

@ IA/IB/DA/DB, with and without writeback, loading discontiguous registers.
.irp addressing, ia, ib, da, db
.irp writeback, 0, 1
.irp target, 0x4000, 0x5001, 0x5003
mov r0, #0x80000
mov r10, r0
.ifc \addressing,ib
add r10, #4
.endif
.ifc \addressing,da
sub r10, #8
.endif
.ifc \addressing,db
sub r10, #12
.endif
str r5, [r10]
str r8, [r10, #4]
mov r4, #(\target & ~0xff)
orr r4, #(\target & 0xff)
str r4, [r10, #8]
mov r2, #0x5000
add r2, #6
mov lr, #0x7000
mov r9, lr
adr r6, 1f
.if \writeback
ldm\addressing r0!, {r1, r3, pc}
.else
ldm\addressing r0, {r1, r3, pc}
.endif
1:
.endr
.endr
.endr

@ Loading the base register must not change the address of the PC load.
mov r0, #0x80000
ldr r4, =0xdeadbeef
str r4, [r0]
mov r4, #0x5000
add r4, #3
str r4, [r0, #4]
mov r1, #0x11
mov r2, #0x5000
add r2, #6
mov r3, #0x33
mov lr, #0x7000
mov r9, lr
adr r6, 1f
ldmia r0, {r0, pc}
1:

@ Failed BX/BLX, PC loads and even BLX PC preserve state and fall through.
.irp instruction, 0x012fff1e, 0x012fff3e, 0x0530f008, 0x0690f101, 0x08b0800a, 0x012fff3f
mov r0, #0x80000
mov r1, #2
mov r2, #0x22
mov r3, #0x33
mov lr, #0x7000
.inst \instruction
mrs r4, cpsr
stmia r11!, {r0-r4, lr}
.endr

mov r0, #41
bx pc
add r0, #1
mrs r1, cpsr
stmia r11!, {r0-r1}
b finish
.ltorg

.org 0x4000
mov r2, pc
mrs r4, cpsr
sub lr, lr, r9
stmia r11!, {r0-r4, lr}
bx r6

.org 0x5000
.thumb
@ Entry at 0x5002 skips the marker write, proving bit 1 was preserved.
mov r2, r12
bx r7

.org 0x6000
.arm
mrs r4, cpsr
sub lr, lr, r9
stmia r11!, {r0-r4, lr}
bx r6
finish:
