
e7-20.o:     ファイル形式 elf64-x86-64


セクション .text の逆アセンブル:

0000000000000000 <sum7>:
   0:	f3 0f 1e fa          	endbr64 
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
   8:	c7 05 00 00 00 00 00 	movl   $0x0,0x0(%rip)        # 12 <sum7+0x12>
   f:	00 00 00 
  12:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 18 <sum7+0x18>
  18:	89 05 00 00 00 00    	mov    %eax,0x0(%rip)        # 1e <sum7+0x1e>
  1e:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 24 <sum7+0x24>
  24:	85 c0                	test   %eax,%eax
  26:	7e 30                	jle    58 <sum7+0x58>
  28:	90                   	nop
  29:	8b 15 00 00 00 00    	mov    0x0(%rip),%edx        # 2f <sum7+0x2f>
  2f:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 35 <sum7+0x35>
  35:	01 d0                	add    %edx,%eax
  37:	89 05 00 00 00 00    	mov    %eax,0x0(%rip)        # 3d <sum7+0x3d>
  3d:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 43 <sum7+0x43>
  43:	83 e8 01             	sub    $0x1,%eax
  46:	89 05 00 00 00 00    	mov    %eax,0x0(%rip)        # 4c <sum7+0x4c>
  4c:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 52 <sum7+0x52>
  52:	85 c0                	test   %eax,%eax
  54:	7e 05                	jle    5b <sum7+0x5b>
  56:	eb d1                	jmp    29 <sum7+0x29>
  58:	90                   	nop
  59:	eb 01                	jmp    5c <sum7+0x5c>
  5b:	90                   	nop
  5c:	90                   	nop
  5d:	5d                   	pop    %rbp
  5e:	c3                   	ret    
