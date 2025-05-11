#include <stdio.h>

// module1.c内でのみ有効なグローバル変数
static int counter = 100;

// module1.c内でのみ有効な関数
static void print_counter(void) {
    printf("module1.c: counter = %d\n", counter);
}

// 外部から呼び出し可能な関数
void module1_function(void) {
    // 自ファイル内の静的関数と変数を使用
    print_counter();
    counter += 10;
    print_counter();
}
