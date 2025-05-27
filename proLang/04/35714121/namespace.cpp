#include <stdio.h>
namespace cse
{
void get(){printf("cse\n");}
}
void get(){ printf("global\n");}
int main()
{
get();
cse::get();
return 0;
}