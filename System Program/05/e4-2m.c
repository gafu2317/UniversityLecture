#include <stdio.h>
#include <stdlib.h>
int v1,v2,v3,v4,v5,v6;
void assign2(void);
int main(int argc, char *argv[])
{
if (argc!=3){
printf("ERR: enter %s v1 v2\n",argv[0]);
return 1;}
v1=atoi(argv[1]);
v2=atoi(argv[2]);
printf("v1=%d v2=%d\n",v1,v2);
assign2();
printf("(+)=%d (-)=%d (&)=%d (v1<<2)=%d\n",v3,v4,v5,v6);
return 0;
}
