#include <stdio.h>
#include <math.h>
#include "task15-1.h"

double calculate_sin_x2_over_x(double x) {
    if (x == 0) return 0; // 0での除算を避ける
    return sin(x * x) / x;
}

double calculate_one_over_x(double x) {
    if (x == 0) return 0; // 0での除算を避ける
    return 1 / x;
}

double calculate_minus_one_over_x(double x) {
    if (x == 0) return 0; // 0での除算を避ける
    return -1 / x;
}

void write_to_file(const char *filename, double *x_values, double *y_values, int num_points) {
    FILE *file = fopen(filename, "w");
    if (file == NULL) {
        printf("ファイルを開けませんでした。\n");
        return;
    }
    for (int i = 0; i < num_points; i++) {
        fprintf(file, "%.5f %.5f\n", x_values[i], y_values[i]);
    }
    fclose(file);
}
