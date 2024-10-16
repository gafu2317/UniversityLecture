stack:
mov eax, DWORD PTR v1
mov edx, DWORD PTR v2
mov DWORD PTR p1, esp
push eax
mov DWORD PTR p2, esp
push edx
mov DWORD PTR p3, esp
pop eax
mov DWORD PTR p4, esp
pop edx
mov DWORD PTR p5, esp
mov DWORD PTR v3, eax
mov DWORD PTR v4, edx
ret