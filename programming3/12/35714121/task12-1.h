// task12-1.h
#ifndef TASK12_1_H
#define TASK12_1_H

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

// 関数のプロトタイプ
void attack(Character *attacker, Character *defender);
void monsterAttack(Character *attacker, Character *defender);
void levelUp(Character *player);
void save(Character player);
Character load(void);
bool loadfile(void);
void battle(Character *player, Character monsters[]);
void attackCheck(int number, Character *attacker, Character *defender); 
#endif // TASK12_1_H
