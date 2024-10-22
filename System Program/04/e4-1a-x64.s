.file "e4-1a-x64.s"
.intel_syntax noprefix
.text
.globl assign1
.type assign1, @function

assign1:
  mov dword ptr [v1], 10
  mov dword ptr [v2], 0x12345678
  mov dword ptr [v3], 0b1011
  mov byte ptr [v4], 'A'
  lea rax, [v1]
  mov qword ptr [v5], rax
  ret

.size assign1, .-assign1

.bss
  .comm v1, 4
  .comm v2, 4
  .comm v3, 4
  .comm v4, 1
  .comm v5, 8
