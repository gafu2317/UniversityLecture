#ifndef STACK_HPP
#define STACK_HPP

class Stack
{
private:
    int array[50];
    int pos;

public:
    Stack();
    void push(int x);
    int pop();
    int size();
};

#endif