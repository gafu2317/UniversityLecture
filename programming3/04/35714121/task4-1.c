// ３つの実数値を読み込んで、その最大値と最小値を表示す
// るプログラムを作成せよ。ただし、if文を用いること。

#include <stdio.h>

int main() {
    double a, b, c;
    printf("３つの実数値を入力してください: ");
    scanf("%lf %lf %lf", &a, &b, &c);

    if (a > b) {
        if (a > c) {
            printf("最大値: %f\n", a);
        } else {
            printf("最大値: %f\n", c);
        }
    } else {
        if (b > c) {
            printf("最大値: %f\n", b);
        } else {
            printf("最大値: %f\n", c);
        }
    }

    if (a < b) {
        if (a < c) {
            printf("最小値: %f\n", a);
        } else {
            printf("最小値: %f\n", c);
        }
    } else {
        if (b < c) {
            printf("最小値: %f\n", b);
        } else {
            printf("最小値: %f\n", c);
        }
    }

    return 0;
}