﻿segment .data

fmt_in: db "%lld",0
fmt_out: db "%lld ",0
fmt_nl: db "",10,0

cnt: dq 0

segment .bss
arry: resq 100

segment .text
global main
extern scanf,printf,gets

main:
	push RBP
	mov RSI,0
	mov RAX,arry
	mov RCX, 0

	in:
		cmp RCX, 5
		JGE end_in
		push RAX
		push RCX
		mov RDI, fmt_in
		mov RSI,RAX
		mov RAX,0
		call scanf
		pop RCX
		pop RAX
		add RAX,8
		inc RCX
		JMP in
	
	end_in:
		mov RCX, 0

	l_out:
		cmp RCX, 5
		JGE end_l_out
		mov [cnt], RCX
		mov RAX, [arry+RCX*8]

	l_in:
		inc RCX
		cmp RCX, 5
		JGE end_l_in
		cmp RAX, [arry+RCX*8]
		JLE l_in
		XCHG RAX, [arry+RCX*8]
		JMP l_in

	end_l_in:
		mov RCX, 0

	print:
		cmp RCX, 5
		JGE exit
		push RCX
		mov RAX,[arry+RCX*8]
		mov RDI, fmt_out
		mov RSI,RAX
		mov RAX,0
		call printf
		pop RCX
		inc RCX
		JMP print

	exit:
		mov RDI,fmt_nl
		mov RAX,0
		call printf

		pop RBP
		ret	