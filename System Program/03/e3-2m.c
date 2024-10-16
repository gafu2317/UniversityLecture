#include <stdio.h>
extern char v1; extern short v2; extern short int v3;
extern int v4; extern long v5; extern long int v6;
extern long long v7; extern long long int v8;
int main(void) {
printf("char v1 addr=%p size=%d short v2 addr=%p size=%d¥n"
,&v1,(int) sizeof(v1),&v2,(int) sizeof(v2));
printf("short int v3 addr=%p size=%d int v4 addr=%p size=%d¥n"
,&v3,(int) sizeof(v3),&v4,(int) sizeof(v4));
printf("long v5 addr=%p size=%d long int v6 addr=%p size=%d¥n"
,&v5,(int) sizeof(v5),&v6,(int) sizeof(v6));
printf("long long v7 addr=%p size=%d long long int v8 addr=%p size=%d¥n"
,&v7,(int) sizeof(v7),&v8,(int) sizeof(v8));
return(0);
}