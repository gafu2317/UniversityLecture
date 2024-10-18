// 4行3列の行列と3行4列の行列の積を求めるプログラムを作
// 成せよ。行列の各構成要素の値はキーボードから読み込む
// こと。
#include <stdio.h>

int main() {
    int a[4][3], b[3][4], c[4][4];
    int i, j, k;

    printf("4行3列の行列を入力してください\n");
    for (i = 0; i < 4; i++) {
        for (j = 0; j < 3; j++) {
            printf("a[%d][%d]: ", i, j);
            scanf("%d", &a[i][j]);
        }
    }
    
    printf("3行4列の行列を入力してください\n");
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 4; j++) {
            printf("b[%d][%d]: ", i, j);
            scanf("%d", &b[i][j]);
        }
    }

    for (i = 0; i < 4; i++) {
        for (j = 0; j < 4; j++) {
            c[i][j] = 0;
            for (k = 0; k < 3; k++) {
                c[i][j] += a[i][k] * b[k][j];
            }
        }
    }

    printf("積行列\n");
    for (i = 0; i < 4; i++) {
        for (j = 0; j < 4; j++) {
            printf("%d ", c[i][j]);
        }
        printf("\n");
    }
    return 0;
}