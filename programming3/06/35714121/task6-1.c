//学生を表す構造体（メンバを初期化）

#include <stdio.h>

#define NAME_LEN 64 // 名前の文字数

// 学生を表す構造体
typedef struct {
    char name[NAME_LEN]; // 名前
    int height; // 身長
    double weight; // 体重
} student;

//メンバのアドレスを表示する機能を追加
int main(void) {
    student Takao = {"Takao", 180, 70.0};
    // 学生の情報を表示
    printf("氏名: %s\n", Takao.name);
    printf("身長: %d\n", Takao.height);
    printf("体重: %.1f\n", Takao.weight);
    
    // 各メンバのアドレスを表示
    printf("\nメンバのアドレス:\n");
    printf("名前のアドレス: %p\n", &Takao.name);
    printf("身長のアドレス: %p\n", &Takao.height);
    printf("体重のアドレス: %p\n", &Takao.weight);
    return 0;
}