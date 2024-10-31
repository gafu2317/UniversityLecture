// 整数を２つ入力してgobai関数（自作）内で5倍した結果を
// main関数内で出力（表示）するプログラムを作成せよ。た
// だし、ポインタにて引数を受け渡すこと。
//  関数：gobai(int *a, int *b);

#include <stdio.h>

void gobai(int *a, int *b){
    *a *= 5;
    *b *= 5;
}

int main(void){
    int a, b;
    printf("Input two integers: ");
    scanf("%d %d", &a, &b);
    gobai(&a, &b);
    printf("最初の数の五倍: %d\n", a);
    printf("次の数の五倍: %d\n", b);
    return 0;
}