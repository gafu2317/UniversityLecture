// int型、long型、double型の値をキーボードから読み込んで
// その値をメンバとしてもつxyz構造体の値を返却する関数を
// 作成せよ。
//  struct xyz scan_xyz(){ /* … */ }

#include <stdio.h>

typedef struct {
    int Int; 
    long Long; 
    double Double; 
} xyz;

xyz scan_xyz() {
    xyz xyz1;
    printf("int型の値を入力してください: ");
    scanf("%d", &xyz1.Int);
    printf("long型の値を入力してください: ");
    scanf("%ld", &xyz1.Long);
    printf("double型の値を入力してください: ");
    scanf("%lf", &xyz1.Double);
    return xyz1;
}

int main() {
    xyz xyz1 = scan_xyz();
    printf("int型の値: %d\n", xyz1.Int);
    printf("long型の値: %ld\n", xyz1.Long);
    printf("double型の値: %f\n", xyz1.Double);
    return 0;
}
