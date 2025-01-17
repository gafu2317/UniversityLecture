#include <stdio.h>
#include <stdlib.h>
#include "task14.h"

int main() {
    int n;
    printf("数字を入力してください: ");
    scanf("%d", &n);

    if (n <= 0) {
        printf("正の整数を入力してください。\n");
        return 1;
    }

    int *array = create_array(n);
    if (array == NULL) {
        printf("メモリの確保に失敗しました。\n");
        return 1;
    }

    fill_array(array, n);
    print_array(array, n);

    free(array);
    return 0;
}
