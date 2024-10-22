.file "e4-1a-x64.s"
.intel_syntax noprefix
.text
.globl assign1
.type assign1, @function
assign1:
  mov DWORD PTR v1[rip], 10
  mov DWORD PTR v2[rip], 0x12345678
  mov DWORD PTR v3[rip], 0b1011
  mov BYTE PTR v4[rip], 'A'
  lea rax, v1[rip]
  mov QWORD PTR v5[rip], rax
  ret
  .size assign1, .-assign1
  .bss
  .comm v1,4,4
  .comm v2,4,4
  .comm v3,4,4
  .comm v4,1,1
  .comm v5,8,8
