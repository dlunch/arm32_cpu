@ Follow a forward and then a backward B.W to reach the store.
.syntax unified
.arch armv7-a
.thumb
b.w forward
backward:
movs r0, #42
str r0, [sp]
b finish
forward:
b.w backward
finish:
