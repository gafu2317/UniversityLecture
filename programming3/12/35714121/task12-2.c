#include <stdio.h>
#include <stdlib.h>

int main() {
    int n;
    int *array;

    printf("配列のサイズを入力してください: ");
    scanf("%d", &n);

    array = (int *)malloc(n * sizeof(int)); // メモリ確保
    if (array == NULL) return 1; // エラーチェック

    for (int i = 0; i < n; i++) {
        array[i] = i + 1; // 値を代入
    }

    for (int i = 0; i < n; i++) {
        printf("%d ", array[i]); // 出力
    }
    printf("\n");

    free(array); // メモリ解放
    return 0;
}
