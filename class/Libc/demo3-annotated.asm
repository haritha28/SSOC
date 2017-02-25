;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                              ;
; Author    :   Arvind                                                         ;
; Program   :   Display numbers from 1 to 10                                   ;
; Note      :   This program was tested on Ubuntu 14.04 64 bit using           ;
;               nasm 2.10.09 and gcc 4.8.4.                                    ;
;                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BITS 64

extern printf
extern scanf

section .data
    i   :    dq 1                       ; Counter

section .rodata
    out :    db "%d", 10, 0             ; Output format

section .text
    global main

    main:
        push rbp
        mov rbp, rsp

        .loop:
            mov rsi, QWORD [i]          ; Set counter as 2nd argument
            mov rdi, out                ; Set output format for printf
            call printf
            inc QWORD [i]               ; Increment counter
            cmp QWORD [i], 10           ; Compare with 10
            jg .final                   ; Exit if greater
            jmp .loop                   ; else continue

        .final:
            xor rax, rax
            leave
            ret
