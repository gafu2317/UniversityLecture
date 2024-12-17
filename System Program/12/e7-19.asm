
e7-19.o:     ファイル形式 elf64-x86-64


セクション .text の逆アセンブル:

0000000000000000 <sum6>:
   0:	f3 0f 1e fa          	endbr64 
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
   8:	c7 05 00 00 00 00 00 	movl   $0x0,0x0(%rip)        # 12 <sum6+0x12>
   f:	00 00 00 
  12:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 18 <sum6+0x18>
  18:	89 05 00 00 00 00    	mov    %eax,0x0(%rip)        # 1e <sum6+0x1e>
  1e:	eb 23                	jmp    43 <sum6+0x43>
  20:	8b 15 00 00 00 00    	mov    0x0(%rip),%edx        # 26 <sum6+0x26>
  26:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 2c <sum6+0x2c>
  2c:	01 d0                	add    %edx,%eax
  2e:	89 05 00 00 00 00    	mov    %eax,0x0(%rip)        # 34 <sum6+0x34>
  34:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 3a <sum6+0x3a>
  3a:	83 e8 01             	sub    $0x1,%eax
  3d:	89 05 00 00 00 00    	mov    %eax,0x0(%rip)        # 43 <sum6+0x43>
  43:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 49 <sum6+0x49>
  49:	85 c0                	test   %eax,%eax
  4b:	7f d3                	jg     20 <sum6+0x20>
  4d:	90                   	nop
  4e:	5d                   	pop    %rbp
  4f:	c3                   	ret    
