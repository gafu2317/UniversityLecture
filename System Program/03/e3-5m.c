#include <stdio.h>
extern int v0,v1;
void count(void);
void main(void)
{
count();
printf("1: v0=%d, v1=%d\n",v0,v1);
count();
printf("2: v0=%d, v1=%d\n",v0,v1);
count();
printf("3: v0=%d, v1=%d\n",v0,v1);
}