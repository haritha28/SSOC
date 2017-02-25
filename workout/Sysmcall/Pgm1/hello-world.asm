BITS 64

%define STDOUT 1
%define SYS_WRITE 1
%define SYS_EXIT 60

section .rodata
	msg: db "HELLO WORLD",10, 0
	len: equ $-msg

section .text
	global _start

	_start:
		push rbp
		mov rbp, rsp

		mov  rax, SYS_WRITE
		mov rdi, STDOUT 
		mov rsi, msg
		mov rdx, len 
		syscall

		mov rax, SYS_EXIT
		xor rdi, rdi
		syscall
		


