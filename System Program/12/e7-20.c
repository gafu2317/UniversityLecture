extern int n,r,i;
void sum7(void)
{
r=0;
i=n;
if (!(i>=1)) goto done;
loop:
r=r+i;
i--;
if (i>=1) goto loop;
done:
return;
}