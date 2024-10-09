//main.c
#include <stdio.h>

int add(int a, int b);
int subtract(int a, int b);
int multiply(int a, int b);
float divide(int a, int b);

int main() {
    int num1, num2;
    printf("2つの数を入力してください: ");
    scanf("%d %d", &num1, &num2);

    printf("加算: %d\n", add(num1, num2));
    printf("減算: %d\n", subtract(num1, num2));
    printf("乗算: %d\n", multiply(num1, num2));
    printf("除算: %.2f\n", divide(num1, num2));

    return 0;
}
