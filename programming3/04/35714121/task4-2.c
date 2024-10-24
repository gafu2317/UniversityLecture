// ３つの実数値を読み込んで、その最大値と最小値を表示す
// るプログラムを作成せよ。ただし、switch文を用いること。

#include <stdio.h>

int main() {
    double a, b, c;
    printf("３つの実数値を入力してください: ");
    scanf("%lf %lf %lf", &a, &b, &c);


//　１は真、０は偽
    switch (a > b) {
        case 1:
            switch (a > c) {
                case 1:
                    printf("最大値: %f\n", a);
                    break;
                case 0:
                    printf("最大値: %f\n", c);
                    break;
            }
            break;
        case 0:
            switch (b > c) {
                case 1:
                    printf("最大値: %f\n", b);
                    break;
                case 0:
                    printf("最大値: %f\n", c);
                    break;
            }
            break;
    }

    switch (a < b) {
        case 1:
            switch (a < c) {
                case 1:
                    printf("最小値: %f\n", a);
                    break;
                case 0:
                    printf("最小値: %f\n", c);
                    break;
            }
            break;
        case 0:
            switch (b < c) {
                case 1:
                    printf("最小値: %f\n", b);
                    break;
                case 0:
                    printf("最小値: %f\n", c);
                    break;
            }
            break;
    }

    return 0;
}