#include <stdio.h>

// 人を表す構造体 (pからPersonへ)
struct Person {
    char* name;    // 名前（nからnameへ）
    int age;       // 年齢（aからageへ）
};

// 人の名前を設定する関数（fからset_nameへ）
void set_name(struct Person* person, char* new_name) {
    person->name = new_name;
}

// 人の年齢を設定する関数（gからset_ageへ）
void set_age(struct Person* person, int new_age) {
    person->age = new_age;
}

// 人の名前を表示する関数（uからprint_nameへ）
void print_name(struct Person* person) {
    printf("%s\n", person->name);
}

// 人の年齢を表示する関数（vからprint_ageへ）
void print_age(struct Person* person) {
    printf("%d\n", person->age);
}

int main(void) {
    // 2人分の人データを格納する配列
    struct Person people[2];
    
    // 1人目の情報を設定
    set_name(&people[0], "Taro");
    set_age(&people[0], 21);
    
    // 2人目の情報を設定
    set_name(&people[1], "Hanako");
    set_age(&people[1], 20);
    
    // 全員の情報を表示
    for (int i = 0; i < 2; i++) {
        print_name(&people[i]);
        print_age(&people[i]);
    }
    
    return 0;
}
