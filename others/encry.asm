;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                              ;
; Author    :   Arvind                                                         ;
; Date      :   21/12/2016                                                     ;
; Program   :   print first 20 bytes of a file using system calls              ;
; Note      :   This program was tested on Ubuntu 14.04 64 bit using           ;
;               nasm 2.10.09 and gcc 4.8.4.                                    ;
;                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BITS 64

%define BUF_SIZE 1
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
%define SYS_LSEEK 8

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
        

        mov rax, QWORD [rsp + 16]       ; retrieve address of filename from stack
        mov r14, rax
        mov r13,  [rsp + 24]

        mov rax, SYS_OPEN               ; open file in read only mode
        mov rdi, r14
        xor rsi, rsi
        mov rdx, O_RDONLY
        syscall
        
        mov [fh], rax
        mov r15,0                       ;r15 stores the size

        .loop:				;loop to calculate size


        

         mov rax, SYS_READ               ; read BUF_SIZE bytes from file into buffer
        mov rdi, [fh]
        mov rsi, r14
        mov rdx, BUF_SIZE
        syscall
        

    cmp byte[r14],10
     je .endit
        
        inc r15

        mov rax, SYS_LSEEK               ; move pntr to next char
        mov rdi, [fh]
        mov rsi, r15
        mov rdx, 0
        syscall

        

        
       jmp .loop

       
       
        .endit:

        mov rax, SYS_LSEEK               ; go to file start
        mov rdi, [fh]
        mov rsi, 0
        mov rdx, 0
        syscall
        

         mov rax, SYS_READ               ; read r15 size bytes from file into buffer
        mov rdi, [fh]
        mov rsi, r14
        mov rdx,  r15
        syscall
        
        
        xor [r14], r13
        
         mov rax, SYS_WRITE              ; write buffer to stdout
        mov rdi, STDOUT
        mov rsi, r14
        mov rdx, r15
        syscall
       

        mov rax, SYS_CLOSE              ; close file
        mov rdi, [fh]
        syscall
        jmp .final

        xor rdi, rdi                    ; exit(0)
        jmp .final

        

        .final:                         ; exit syscall
            mov rax, SYS_EXIT
            syscall
