#include <stdio.h>

int main() {
    fizzBuzz();
    tripleLoopWithGoto();
    tripleLoopWithBreak();
    return 0;
}

// 課題2-1: for文とif、gotoだけでFizzBuzz
void fizzBuzz() {
    printf("2-1\n");
    int i;
    for (i = 1; i <= 100; i++) {
        if (i % 3 == 0) {
            printf("Fizz");
            if (i % 5 == 0) {
                printf("Buzz");
            }
            goto print_newline;
        }
        
        if (i % 5 == 0) {
            printf("Buzz");
            goto print_newline;
        }
        
        printf("%d", i);
        
    print_newline:
        printf("\n");
    }
    printf("\n");
}

// 課題2-2: 3重ループの脱出（gotoを使った場合）
void tripleLoopWithGoto() {
    printf("2-2(1)\n");
    int i, j, k;
    
    for (i = 0; i <= 10; i++) {
        for (j = 0; j <= 10; j++) {
            for (k = 0; k <= 10; k++) {
                if (i == 7 && j == 7 && k == 7) {
                    goto exit_loop;
                }
            }
        }
    }
    
exit_loop:
    printf("ループを脱出しました: i=%d, j=%d, k=%d\n", i, j, k);
}

// 課題2-2: 3重ループの脱出（breakを使った場合）
void tripleLoopWithBreak() {
    printf("2-2(2)\n");
    int i, j, k;
    int found = 0;
    
    for (i = 0; i <= 10; i++) {
        if (found) break;
        
        for (j = 0; j <= 10; j++) {
            if (found) break;
            
            for (k = 0; k <= 10; k++) {
                printf("i=%d, j=%d, k=%d\n", i, j, k);
                
                if (i == 7 && j == 7 && k == 7) {
                    found = 1;
                    break;
                }
            }
        }
    }
    
    printf("ループを脱出しました: i=%d, j=%d, k=%d\n", i, j, k);
}
