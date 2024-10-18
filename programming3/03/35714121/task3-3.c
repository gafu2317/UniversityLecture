// 4人の2科目の点数を読み込んで、科目ごとの合計点と平均
// 点、学生毎の合計点と平均点を求めるプログラムを作成せ
// よ（必ず、配列を用いること）。

#include <stdio.h>

int main() {
    int scores[4][2];// 4人の2科目の点数
    int i, j;// カウンタ変数
    int sum[4] = {0, 0, 0, 0};// 学生ごとの合計点
    int sum_subject[2] = {0, 0};// 科目ごとの合計点

    for (i = 0; i < 4; i++) {// 4人の点数を読み込む
        for (j = 0; j < 2; j++) {
            printf("学生%dの%dつ目科目の点数を入力", i + 1, j + 1);
            printf("scores[%d][%d]: ", i, j);
            scanf("%d", &scores[i][j]);
            sum[i] += scores[i][j];
            sum_subject[j] += scores[i][j];
        }
    }

    printf("科目ごとの合計点\n");
    for (i = 0; i < 2; i++) {
        printf("科目%d: %d\n", i + 1, sum_subject[i]);
    }

    printf("学生ごとの合計点\n");
    for (i = 0; i < 4; i++) {
        printf("学生%d: %d\n", i + 1, sum[i]);
    }

    printf("科目ごとの平均点\n");
    for (i = 0; i < 2; i++) {
        printf("科目%d: %.1f\n", i + 1, (double)sum_subject[i] / 4);
    }

    printf("学生ごとの平均点\n");
    for (i = 0; i < 4; i++) {
        printf("学生%d: %.1f\n", i + 1, (double)sum[i] / 2);
    }


    
    return 0;
}