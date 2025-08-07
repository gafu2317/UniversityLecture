#include "stack.hpp"
#include <stdio.h>

int main()
{
    Stack s;
    s.push(1);
    s.push(2);
    s.push(3);
    
    printf("Stack size: %d\n", s.size());
    
    printf("%d\n", s.pop());
    printf("%d\n", s.pop());
    printf("%d\n", s.pop());
    
    printf("Stack size after pop: %d\n", s.size());
    
    return 0;
}