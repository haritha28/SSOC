BITS 64

extern printf
extern scanf

section .rodata 
	inp: db "%d"
	out: db "Sum is %d", 10, 0
	prompt: db "Enter the number", 0

section .bss
	num1: resq 1 
	num2: resq 1 

section .text
	global main

	main:

		push rbp
		mov rbp, rsp

		mov rdi, prompt
		call printf

		mov rdi, inp
		mov rsi, num1
		call scanf

		mov rdi, prompt
		call printf

		mov rdi, inp
		mov rsi, num2
		call scanf

		mov rsi, QWORD [num1]
		add rsi, QWORD [num2]
		mov rdi, out
		call printf

		mov rax,0
		mov rsp, rbp
		pop rbp
		ret





