extern int v0,v1,v2;
void max2(void)
{
v2=v1;
if (v0<=v1) goto L1;
v2=v0;
L1:
return;
}