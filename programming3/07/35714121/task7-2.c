#include <stdio.h>
#include <math.h>

int main(void) {
    FILE *fp;
    double x, y;
    int i;

    fp = fopen("sin.dat", "w");

    if (fp == NULL) {
        printf("sin.datファイルが存在しません。\n");
    }else{
        for (i = 0; i <= 100; i++) {
            x = i / 100.0;
            y = sin(2 * M_PI * x);
            fprintf(fp, "%lf " " %lf\n", x, y);
        }
    }

    fclose(fp);

    return 0;
}