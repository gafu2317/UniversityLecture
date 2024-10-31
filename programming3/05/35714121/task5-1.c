//配列の受け渡し

#include <stdio.h>

// 配列Vの先頭n個の要素にvalを代入
void ary_set(int V[], int n, int val) {
    for (int i = 0; i < n; i++) {
        V[i] = val;
    }
}

int main(void) {
    int i;
    int a[5] = {1, 2, 3, 4, 5};

    ary_set(&a[2], 2, 99);

    for (i = 0; i < 5; i++) {
        printf("a[%d] = %d\n", i, a[i]);
    }

    return 0;
}