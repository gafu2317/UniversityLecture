// main12.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "task12-1.h"

int main(void) {
    srand(time(NULL));

    Character player;
    int loadFlag;

    // ファイルを開いてデータがあるか確認
    if (loadfile()) {
        printf("セーブデータをロードしますか？(1: はい, 2: いいえ)\n");
        scanf("%d", &loadFlag);
        if (loadFlag == 1) {
            player = load();
        }
    } else {
        // 新しいキャラクターの初期化
        strcpy(player.name, "勇者");
        player.level = 1;
        player.health = 100;
        player.maxHealth = 100;
        player.normal = 10;
        player.normalAccuracy = 100;
        player.skill1 = 20;
        player.skill1Accuracy = 60;
        player.skill2 = 30;
        player.skill2Accuracy = 40;
        player.ultimate = 50;
        player.ultimateAccuracy = 50;
        player.exp = 0;
    }

    // モンスターの配列を定義
    Character monsters[3] = {
        {"スライム", 1, 50, 50, 5, 80, 10, 60, 15, 40, 20, 50, 50},
        {"ゴブリン", 1, 70, 70, 10, 80, 15, 60, 20, 40, 25, 50, 70},
        {"ドラゴン", 1, 100, 100, 15, 80, 20, 60, 25, 40, 30, 50, 100}
    };

    battle(&player, monsters);  

    printf("セーブしますか？(1: はい, 2: いいえ)\n");
    int saveFlag;
    scanf("%d", &saveFlag);
    if (saveFlag == 1) {
        save(player);
    }

    return 0;
}
