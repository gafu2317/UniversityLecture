.file "e3-1a-ia32.s"
.intel_syntax noprefix
.text
.globl stack
.type stack, @function

stack:
    mov eax, v1          # v1の値をeaxに移動
    mov edx, v2          # v2の値をedxに移動
    mov p1, esp          # espの値をp1に移動
    push eax             # eaxをスタックにプッシュ
    mov p2, esp          # espの値をp2に移動
    push edx             # edxをスタックにプッシュ
    mov p3, esp          # espの値をp3に移動
    pop edx              # スタックからedxをポップ（最初にpopした値をedxに格納）
    pop eax              # スタックからeaxをポップ（次にpopした値をeaxに格納）
    mov p4, esp          # espの値をp4に移動
    mov p5, esp          # espの値をp5に移動
    mov v3, eax          # eaxの値をv3に移動
    mov v4, edx          # edxの値をv4に移動
    ret