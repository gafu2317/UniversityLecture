#include <stdio.h>
extern int i,*va,v,a1;
void assign3(void);
int main(void)
{
char c;
printf("Enter a digit.\n");
c=getchar();
i=c-'0';
if (i<0 || i>9) return 1;
printf("i=%d\n",i);
assign3();
printf("a1[%d]: addr=%8p val=%d \n",i,va,v);
return 0;
}