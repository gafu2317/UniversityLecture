assign3:
ldr r2, L1+12
ldr r3, L1
ldr r3, [r3]
add r0, r2,r3,lsl #2
ldr r1, L1+4
str r0, [r1]
ldr r0, [r2,r3,lsl #2]
ldr r1, L1+8
str r0, [r1]
bx lr
L1:
.word i
.word va
.word v
.word a1
.size assign3, .-assign3
.global a1
.data
.type a1, %object
.size a1, 24
a1:
.long 1
.long 2
.long 3
.long 4
.long 5
.long 6
.bss
.comm i,4,4
.comm va,4,4
.comm v,4,4