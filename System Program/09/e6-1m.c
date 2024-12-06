#include <stdio.h>
#include <stdlib.h>
extern int d, v;
void dial1(void);
int main(int argc, char *argv[])
{
if (argc!=2){
printf("ERR: enter %s d\n",argv[0]);
return 1;}
d=atoi(argv[1]);
dial1();
printf("yokohama[%d]=%d\n", d,v);
return(0);
}