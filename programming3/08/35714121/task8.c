#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <string.h>
#include <stdbool.h>

typedef struct {
    char name[20];
    int level;
    int health;
    int maxHealth;
    int normal;
    int normalAccuracy;
    int skill1;
    int skill1Accuracy;
    int skill2;
    int skill2Accuracy;
    int ultimate;
    int ultimateAccuracy;
    int exp;
} Character;

// attackCheckのプロトタイプ宣言
void attackCheck(int number, Character *attacker, Character *defender);

//プレイヤーの攻撃処理
void attack(Character *attacker, Character *defender) {
    int number;
    printf("攻撃方法を選んでください\n");
    printf("1: 通常攻撃 (ダメージ: %d) (命中: %d)\n", attacker->normal, attacker->normalAccuracy);
    printf("2: スキル1 (ダメージ: %d) (命中: %d)\n", attacker->skill1, attacker->skill1Accuracy);
    printf("3: スキル2 (ダメージ: %d) (命中: %d)\n", attacker->skill2, attacker->skill2Accuracy);
    printf("4: 必殺技 (ダメージ: %d) (命中: %d)\n", attacker->ultimate, attacker->ultimateAccuracy);
    //選択した攻撃方法をnumberに代入
    scanf("%d", &number); 
    //攻撃方法が1~4以外の場合、再度攻撃方法を選択
    while (number < 1 || number > 4) {
        printf("1~4の攻撃方法を選んでください\n");
        scanf("%d", &number);
    }
    //攻撃方法が1~4の場合、attackCheck関数を呼び出し、攻撃を行う
    attackCheck(number, attacker, defender);
    printf("\n");
}

//モンスターの攻撃処理
void monsterAttack(Character *attacker, Character *defender) {
    //1~4の乱数を生成
    int number = rand() % 4 + 1;
    attackCheck(number, attacker, defender);
}

//攻撃方法によって、ダメージを与えるかどうかを判定
void attackCheck(int number, Character *attacker, Character *defender) {
    if (number == 1) {
        if(rand() % 100 < attacker->normalAccuracy) {
            defender->health -= attacker->normal;
            printf("%sは%dのダメージを受けた！\n", defender->name, attacker->normal);
        } else {
            printf("%sの攻撃は外れた！\n", attacker->name);
        }
    } else if (number == 2) {
        if(rand() % 100 < attacker->skill1Accuracy) {
            defender->health -= attacker->skill1;
            printf("%sは%dのダメージを受けた！\n", defender->name, attacker->skill1);
        } else {
            printf("%sの攻撃は外れた！\n", attacker->name);
        }
    } else if (number == 3) {
        if(rand() % 100 < attacker->skill2Accuracy) {
            defender->health -= attacker->skill2;
            printf("%sは%dのダメージを受けた！\n", defender->name, attacker->skill2);
        } else {
            printf("%sの攻撃は外れた！\n", attacker->name);
        }
    } else if (number == 4) {
        if(rand() % 100 < attacker->ultimateAccuracy) {
            defender->health -= attacker->ultimate;
            printf("%sは%dのダメージを受けた！\n", defender->name, attacker->ultimate);
        } else {
            printf("%sの攻撃は外れた！\n", attacker->name);
        }
    }
    sleep(1);
}

//レベルアップ処理
void levelUp(Character *player) {
    sleep(1);
    player->level++;
    player->exp -= 100;
    player->health = player->maxHealth;
    player->maxHealth += 10;
    player->normal += 2;
    player->skill1 += 4;
    player->skill2 += 4;
    player->ultimate += 5;
    printf("レベルアップ！\n");
    printf("レベルが%dになった！\n", player->level);
    printf("HPが全回復した！\n");
    printf("HPが%dになった！\n", player->maxHealth);
    printf("通常攻撃の威力が%dになった！\n", player->normal);
    printf("スキル1の威力が%dになった！\n", player->skill1);
    printf("スキル2の威力が%dになった！\n", player->skill2);
    printf("必殺技の威力が%dになった！\n", player->ultimate);
    sleep(2);
}

void save(Character player) {
    FILE *file;
    file = fopen("task8.dat", "w");  // テキスト形式で保存
    if (file == NULL) {
        printf("ファイルを開けませんでした\n");
        return;
    }
    // 各フィールドをテキスト形式で保存
    fprintf(file, "%s\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n",
        player.name,
        player.level,
        player.health,
        player.maxHealth,
        player.normal,
        player.normalAccuracy,
        player.skill1,
        player.skill1Accuracy,
        player.skill2,
        player.skill2Accuracy,
        player.ultimate,
        player.ultimateAccuracy,
        player.exp);
    fclose(file);
    printf("セーブしました\n");
}

Character load() {
    Character player;
    FILE *file;
    file = fopen("task8.dat", "r");  // テキスト形式で読み込み
    if (file == NULL) {
        printf("ファイルを開けませんでした\n");
        return player; // 初期化された構造体を返す
    }
    fscanf(file, "%s\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n",
        player.name,
        &player.level,
        &player.health,
        &player.maxHealth,
        &player.normal,
        &player.normalAccuracy,
        &player.skill1,
        &player.skill1Accuracy,
        &player.skill2,
        &player.skill2Accuracy,
        &player.ultimate,
        &player.ultimateAccuracy,
        &player.exp);
    fclose(file);
    printf("ロードしました\n");
    return player;
}

bool loadfile() {
    FILE *file;
    file = fopen("task8.dat", "r");  // テキスト形式で読み込み
    if (file == NULL) {
        printf("ファイルを開けませんでした\n");
        return false; // ファイルが開けなかった場合
    }

    // 1行目を読み込んで空白かどうかをチェック
    char firstLine[256]; // 適切なサイズのバッファを用意
    if (fgets(firstLine, sizeof(firstLine), file) == NULL || firstLine[0] == '\n') {
        printf("セーブデータがありません\n");
        fclose(file);
        return false; // 空白の場合
    }

    fclose(file);
    return true; // 成功した場合
}

//バトル処理
void battle(Character *player, Character monsters[]) {
    int turn = 1;

    printf("あなたは%sレベル%dです。\n", player->name, player->level);
    
    for( int i = 0; i < 3; i++) {
        printf("%sレベル%dが現れた！\n", monsters[i].name, monsters[i].level);
        
        while (player->health > 0 && monsters[i].health > 0) {
          printf("\n********** %dターン目 **********\n", turn); 
            turn++;
            printf("\nあなたのHP: %d\n", player->health);
            printf("%sのHP: %d\n",monsters[i].name, monsters[i].health);
            printf("\n");
            
            attack(player, &monsters[i]);
            if (monsters[i].health <= 0) {
                printf("%sを倒しました！\n", monsters[i].name);
                player->exp += monsters[i].exp;
                if(player->exp >= 100) {
                    levelUp(player); 
                }
                break;
            }
    
            printf("%sの攻撃！\n", monsters[i].name);
            monsterAttack(&monsters[i], player);
            if (player->health <= 0) {
                printf("あなたは倒れました...ゲームオーバー\n");
                break;
            }
        }
    }
}

int main() {
    srand(time(NULL));

    // ファイルを開いてデータがあるか確認
    FILE *file = fopen("task8.dat", "r");
    Character player;
    int loadFlag;
    if (loadfile()) {
        printf("セーブデータをロードしますか？(1: はい, 2: いいえ)\n");
        scanf("%d", &loadFlag);
        if (loadFlag == 1) {
            player = load();
        }
    } else {
        strcpy(player.name, "勇者");
        player.level = 100;
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
    {
        "スライム", // name
        1, // level
        50, // health
        50, // maxHealth
        5, // normal
        80, // normalAccuracy
        10, // skill1
        60, // skill1Accuracy
        15, // skill2
        40, // skill2Accuracy
        20, // ultimate
        50, // ultimateAccuracy
        50 // exp
    },
    {
        "ゴブリン", // name
        1, // level
        70, // health
        70, // maxHealth
        10, // normal
        80, // normalAccuracy
        15, // skill1
        60, // skill1Accuracy
        20, // skill2
        40, // skill2Accuracy
        25, // ultimate
        50, // ultimateAccuracy
        70 // exp
    },
    {
        "ドラゴン", // name
        1, // level
        100, // health
        100, // maxHealth
        15, // normal
        80, // normalAccuracy
        20, // skill1
        60, // skill1Accuracy
        25, // skill2
        40, // skill2Accuracy
        30, // ultimate
        50, // ultimateAccuracy
        100 // exp
    } 
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
