#include <stdio.h>
#include <stdlib.h>
int v1,v2,v3,v4;
int *p1,*p2,*p3,*p4,*p5;
void stack(void);
int main(int argc, char *argv[])
{
if (argc!=3){
printf("ERR: enter %s v1 v2¥n",argv[0]);
return 1;}
v1=atoi(argv[1]);
v2=atoi(argv[2]);
stack();
printf("v1=%d v2=%d v3=%d v4=%d ¥n",
v1,v2,v3,v4);
printf("p1=%p p2=%p p3=%p p4=%p p5=%p¥n",
p1,p2,p3,p4,p5);
return 0;
}