//divide.c
#include <stdio.h>

float divide(int a, int b) {
    if (b != 0) {
        return (float)a / b;
    } else {
        printf("エラー: 0で割ることはできません。\n");
        return 0;
    }
}
