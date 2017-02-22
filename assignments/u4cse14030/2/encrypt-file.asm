BITS 64

%define BUF_SIZE 27
%define ELEM_SIZE 1
%define O_RDONLY 0

; Macros for file descriptors
%define STDIN 0
%define STDOUT 1
%define STDERR 2

; Macros for syscalls
%define SYS_READ 0
%define SYS_WRITE 1
%define SYS_OPEN 2
%define SYS_CLOSE 3
%define SYS_EXIT 60

section .rodata
    open_error : db "Cannot open file! Exiting!", 10, 0
    open_error_len : equ $ - open_error
    usage : db "Please specify a FILENAME as argument", 10, 0
    usage_len : equ $ - usage

section .bss
    buffer : resb BUF_SIZE
    fh: resq 1
    filename: resq 1

section .text
    global _start

    _start:
        mov rax, QWORD [rsp]            ; argument count check
        cmp rax, 0x3
        jne .nofilename

        mov rax, QWORD [rsp + 16]       ; retrieve address of filename from stack
        mov [filename], rax

        mov r13, QWORD[rsp +24]			;store the key in r13

        mov rax, SYS_OPEN               ; open file in read only mode
        mov rdi, [filename]
        xor rsi, rsi
        mov rdx, O_RDONLY
        syscall
        cmp rax, 0                      ; test if read failed
        jl .openfailed
        mov [fh], rax

        mov rax, SYS_READ               ; read BUF_SIZE bytes from file into buffer
        mov rdi, [fh]
        mov rsi, buffer
        mov rdx, BUF_SIZE
        syscalls

        mov rdi, buffer					;move the buffer to rdi
        call .strlen
        mov r10, rax					

        mov rdi, r13
        call strlen
        mov r11, rax
        										 					
        mov rcx, r10
        mov rdx, buffer
        xor rax, rax


    	;.keylooop:

	        mov bl, BYTE[r13]

		        .encryptloop:
		        	xor BYTE[rdx+rax],bl
		        	inc rax
		        	dec rcx
		        	jne .encryptloop

		    
		    ;jn


        mov rax, SYS_WRITE              ; write buffer to stdout
        mov rdi, STDOUT
        mov rsi, buffer
        mov rdx, BUF_SIZE
        syscall

        mov rax, SYS_CLOSE              ; close file
        mov rdi, [fh]
        syscall

        xor rdi, rdi                    ; exit(0)
        jmp .final

        .openfailed:                    ; display file open failed error message
            mov rax, SYS_WRITE
            mov rdi, STDERR
            mov rsi, open_error
            mov rdx, open_error_len
            syscall
            mov rdi, 1
            jmp .final

        .nofilename:                    ; display usage message
            mov rax, SYS_WRITE
            mov rdi, STDERR
            mov rsi, usage
            mov rdx, usage_len
            syscall
            mov rdi, 1                  ; exit(1)
            jmp .final

        .final:                         ; exit syscall
            mov rax, SYS_EXIT
            syscall

        .strlen:
        	push rbp
        	mov rbp, rsp

        	xor rax, rax

        	.cmploop:
		        cmp BYTE[rdi + rax], 0     ; check if current byte is null
		        je .cmpdone                 ; if yes, done
		        inc rax                     ; else increment length counter
		        jmp .cmploop                ; and continue

		    .cmpdone:
		        leave
		        ret
