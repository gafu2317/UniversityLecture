.arch armv6
.file "e4-1a-arm.s"
.text
.align 2
.global assign1
.type assign1, %function
assign1:
  ldr r0, =10
  ldr r1, L1
  str r0, [r1]
  ldr r0, =0x12345678
  ldr r1, L1+4
  str r0, [r1]
  ldr r0, =0b1011
  ldr r1, L1+8
  str r0, [r1]
  ldr r0, ='A'
  ldr r1, L1+12
  str r0, [r1]
  ldr r0, L1
  ldr r1, L1+16
  str r0, [r1]
  bx lr 
L1:
  .word v1
  .word v2
  .word v3
  .word v4
  .word v5
  .size assign1, .-assign1
  .bss
  .comm v1,4,4
  .comm v2,4,4
  .comm v3,4,4
  .comm v4,1,1
  .comm v5,4,4
