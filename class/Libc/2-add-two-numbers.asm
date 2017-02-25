;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                              ;
; Author    :   Arvind                                                         ;
; Date      :   15/12/2016                                                     ;
; Program   :   Input 2 numbers using scanf and print sum using printf         ;
; Note      :   This program was tested on Ubuntu 14.04 64 bit using           ;
;               nasm 2.10.09 and gcc 4.8.4.                                    ;
;                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BITS 64

extern printf
extern scanf

section .rodata
    inp   :    db "%d"                  ; input format for scanf
    out   :    db "Sum is %d", 10, 0    ; output format for printf
    prompt:    db "Enter number: ", 0   ; prompt to enter input

section .bss
    num1: resq 1                        ; number 1
    num2: resq 1                        ; number 2

section .text
    global main

    main:
        push rbp                    ; setup stack frame
        mov rbp, rsp

        mov rdi, prompt             ; display prompt
        call printf

        mov rsi, num1               ; 2nd arg of scanf: address of num1
        mov rdi, inp                ; 1st arg of scanf: input format
        call scanf                  ; call scanf

        mov rdi, prompt             ; display prompt
        call printf

        mov rsi, num2               ; 2nd arg of scanf: address of num2
        mov rdi, inp                ; 1st arg of scanf: input format
        call scanf                  ; call scanf

        mov rsi, QWORD [num1]       ; Copy num1's value to rsi
        add rsi, QWORD [num2]       ; Add num2's value to rsi
        mov rdi, out                ; 1st arg of printf: output format to display sum
        call printf                 ; call printf

        xor rax, rax                ; same as "mov rax, 0"
        leave                       ; same as "mov rsp, rbp; pop rbp"
        ret
