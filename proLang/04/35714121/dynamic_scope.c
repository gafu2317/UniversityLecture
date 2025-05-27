#include <stdio.h>

void processB(int *i) {
    (*i)++;  // ポインタを通じて値を変更
}

void processA(int *i) {
    printf("%d\n", *i);
    processB(i);  // 同じポインタを渡す
    printf("%d\n", *i);  // 変更された値が表示される
}

int main() {
    int value = 1000;
    processA(&value);  // valueのアドレスを渡す
    return 0;
}
