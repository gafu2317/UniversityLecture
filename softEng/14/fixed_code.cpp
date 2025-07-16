#include <stdio.h>
#include <stdlib.h>

int main() {
    int x = 10;
    if (x > 5) {
        printf("x is greater than 5\n");
        {
            int y = 20;
            printf("y = %d\n", y);
        }
    }
    
    for (int i = 0; i < 3; i++) {
        printf("i = %d\n", i);
    }
    
    int result = x * 2;
    printf("Result: %d\n", result);
    
    return 0;
}