#include <stdio.h>

int main() {
    int height;
    printf("身長を入力せよ: ");
    scanf("%d", &height);

    double StandardWeight = (height - 100) * 0.9;

    printf("標準体重は%.1fです。\n", StandardWeight);
    
    return 0;
}