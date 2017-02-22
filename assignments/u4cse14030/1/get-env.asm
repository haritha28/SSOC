BITS 64

%define STDOUT 1
%define SYS_WRITE 1
%define SYS_EXIT 60

section .rodata
	msg: db 0xa
	len: equ 1	

section .text 
	global _start

	_start:
		push rbp
		mov rbp, rsp

		mov r15, rsp
		add r15, 32

		.label1:
			mov rsi, QWORD[r15]
			mov rdi, rsi 
			call strlen
			mov r10, rax

			mov rax, SYS_WRITE
			mov rdi, STDOUT
			mov rdx, r10
			syscall 

			mov rax, SYS_WRITE
			mov rdi, STDOUT
			mov rsi, msg
			mov rdx, len
			syscall
		
			add r15, 8
			cmp QWORD[r15], 0
			je .label3
			jmp .label1

		.label3:
				mov rax, SYS_EXIT
				xor rdi, rdi
				syscall

		strlen:
	        push rbp
	        mov rbp, rsp

	        xor rax, rax

	        .cmploop:
	            cmp BYTE[rsi + rax], 0     ; check if current byte is null
	            je .cmpdone                 ; if yes, done
	            inc rax                     ; else increment length counter
	            jmp .cmploop                ; and continue

	        .cmpdone:
	            leave
	            ret




		

	   


		

			
		