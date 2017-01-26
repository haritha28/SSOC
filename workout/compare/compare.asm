BITS 64

extern printf
extern scanf

section .rodata
	
	inp: db "%d",0
	out: db "%d", 10, 0
	same: db "Same",10,0
	prompt: db "Enter the number:", 10, 0

section .bss
	num1: resq 1
	num2: resq 2

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

			mov rax, QWORD[num1]
			cmp rax, QWORD[num2]
			jg .label1
			jl .label2
			je .label3

			.label1:
				mov rsi, QWORD[num1]
				jmp .label4

			.label2:
				mov rsi, QWORD[num2]
				jmp .label4

			.label3:
				mov rdi, same
				call printf
				jmp .label5

			.label4:
				mov rdi, out
				call printf

			.label5:
				mov rax, 0
				mov rsp, rbp
				pop rbp
				ret 0

			





