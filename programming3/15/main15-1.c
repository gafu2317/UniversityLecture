#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "task15-1.h"

int main() {
    int num_points;
    printf("データ点数を入力してください: ");
    scanf("%d", &num_points);

    double *x_values = (double *)malloc(num_points * sizeof(double));
    double *y_values1 = (double *)malloc(num_points * sizeof(double));
    double *y_values2 = (double *)malloc(num_points * sizeof(double));
    double *y_values3 = (double *)malloc(num_points * sizeof(double));

    if (x_values == NULL || y_values1 == NULL || y_values2 == NULL || y_values3 == NULL) {
        printf("メモリ確保に失敗しました。\n");
        return 1;
    }

    // xの値を計算
    for (int i = 0; i < num_points-1; i++) {
        x_values[i] = (2 * M_PI / (num_points - 1)) * i; // 0から2πまでの等間隔の値
        y_values1[i] = calculate_sin_x2_over_x(x_values[i]);
        y_values2[i] = calculate_one_over_x(x_values[i]);
        y_values3[i] = calculate_minus_one_over_x(x_values[i]);
    }

    // ファイルに出力
    write_to_file("35714121-1.dat", x_values, y_values1, num_points);
    write_to_file("35714121-2.dat", x_values, y_values2, num_points);
    write_to_file("35714121-3.dat", x_values, y_values3, num_points);

    free(x_values);
    free(y_values1);
    free(y_values2);
    free(y_values3);

    return 0;
}
