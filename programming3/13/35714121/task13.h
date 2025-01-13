#ifndef TASK13_H
#define TASK13_H

typedef struct {
    int max; // 最大要素数
    int ptr; // 現在の要素数
    int *stk; // スタックへのポインタ
} Stack;

int StackAlloc(Stack *s, int max);
void StackFree(Stack *s);
int StackPush(Stack *s, int x);
int StackPop(Stack *s, int *x);
int StackPeek(const Stack *s, int *x);
int StackSize(const Stack *s);
int StackNo(const Stack *s);
int StackIsEmpty(const Stack *s);
int StackIsFull(const Stack *s);
void StackClear(Stack *s);

#endif // TASK13_H
