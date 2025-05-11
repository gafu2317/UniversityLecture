#include <stdio.h>

// 他のファイルの関数を呼び出すための宣言
void module1_function(void);
void module2_function(void);

// main.c内でのみ有効なグローバル変数
static int counter = 100;

// main.c内でのみ有効な関数
static void print_counter(void) {
    printf("main.c: counter = %d\n", counter);
}

int main(void) {
    // 自ファイル内の静的関数を呼び出し
    print_counter();
    
    // 他のファイルの関数を呼び出し
    module1_function();
    module2_function();
    
    return 0;
}
