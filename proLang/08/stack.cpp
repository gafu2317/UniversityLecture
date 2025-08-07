#include "stack.hpp"

Stack::Stack()
{
    pos = 0;
}

void Stack::push(int x)
{
    array[pos] = x;
    pos++;
}

int Stack::pop()
{
    pos--;
    return array[pos];
}

int Stack::size()
{
    return pos;
}