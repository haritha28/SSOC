extern printf
extern atoi
section .rodata
	var1 : db"%ld",10,0
section .bss
	var2 : resq 1
	i : resq 1
	a : resq 1
	b : resq 1
	c : resq 1
	d : resq 1
		
section .text
	global main

	main:
		push rbp
		mov rbp,rsp
		mov QWORD[c], rdi
		mov r14,rsi

	loop:
		mov QWORD[a], 0
		mov QWORD[b], 1
		mov r12, 2
		

		cmp QWORD[c],1
		je .exit

		dec QWORD[c]
		
		add r14, 8
	
		mov rdi,[r14]
		;push r8
			
		call atoi
		mov r15, rax
		
		cmp r15,0
		jg .one 
		mov r11,-1
		jmp .label1
		
		.one:	
		     cmp r15,1
		     jne .two
		     mov r11,0
		     jmp .label1
		.two:
		     cmp r15,2
		     jne .other
		     mov r11,1
		     jmp .label1
		
		.other:
		      cmp r15,r12
		      je .label1
		      mov r8,QWORD[b]
		      mov r13,QWORD[a]
		      add QWORD[b],r13
		      mov QWORD[a],r8
		      mov r11,QWORD[b]
		      inc r12
		      jmp .other
		
		.label1 :
			mov rsi, r11
			mov rdi, var1	
			call printf
			;pop r8
			jmp loop
	.exit:
		xor rax, rax
		leave 
		ret


			
