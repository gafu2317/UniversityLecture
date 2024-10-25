#include <stdio.h> 

int v1, v2, v3;
char v4;
int *v5;

void assign1(void) {
  v1 = 10;
  v2 = 0x12345678;
  v3 = 0b1011;
  v4 = 'A';
  v5 = &v1;
}

int main(void) {
  assign1();
  printf("v1:%d, v2:%d, v3:%d, v4:%c\n", v1, v2, v3, v4);
  printf("v5 points to value:%d\n", *v5);
  return 0;
}
