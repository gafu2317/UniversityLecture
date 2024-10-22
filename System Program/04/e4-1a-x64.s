.file "e4-1a-x64.s"
.intel_syntax noprefix
.text
.globl main
.type main, @function

# 変数の宣言
.bss
  .comm v1, 4
  .comm v2, 4
  .comm v3, 4
  .comm v4, 1
  .comm v5, 8

# assign1 関数
.type assign1, @function
assign1:
  mov dword ptr [v1], 10               # v1 = 10
  mov dword ptr [v2], 0x12345678       # v2 = 0x12345678
  mov dword ptr [v3], 0b1011            # v3 = 0b1011
  mov byte ptr [v4], 'A'                # v4 = 'A'
  lea rax, [v1]                         # v5 = &v1
  mov qword ptr [v5], rax
  ret

# main 関数
main:
  call assign1                          # assign1() を呼び出す

  # printf("v1: %d, v2: %d, v3: %d, v4: %c\n", v1, v2, v3, v4);
  mov rdi, format_str                   # フォーマット文字列のアドレスを rdi にセット
  mov rsi, [v1]                         # v1 の値を rsi にセット
  mov rdx, [v2]                         # v2 の値を rdx にセット
  mov rcx, [v3]                         # v3 の値を rcx にセット
  mov r8, byte ptr [v4]                 # v4 の値を r8 にセット
  call printf                           # printf を呼び出す

  xor rax, rax                          # 戻り値を0にする
  ret

.section .data
format_str:
  .asciz "v1: %d, v2: %d, v3: %d, v4: %c\n"
