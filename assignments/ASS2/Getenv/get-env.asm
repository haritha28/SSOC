BITS 64

extern printf
extern getenv

section .rodata
	out: db "Not found", 10, 0
	inp: db "%s", 10, 0
	
section .text 
	global main

	main:
		push rbp
		mov rbp, rsp

		mov r15, rdx


		.label1:

			mov rdi, QWORD[rsi+8]
			call getenv

			cmp rax, 0
			je .label4
			jne  .label5

		.label5:

			mov rdi, inp
			mov rsi, rax	
			call printf
			jmp .label3

		.label2:
			mov rsi, [r15]
			add r15, 8
			mov rdi, inp
			call printf
			cmp QWORD[r15], 0
			je .label3
			jmp .label2

		.label4:
			mov rdi, out
			call printf
			jmp .label3


		.label3:
				xor rax, rax
				leave 
				ret

