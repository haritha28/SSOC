;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                              ;
; Author    :   Arvind                                                         ;
; Date      :   22/12/2016                                                     ;
; Program   :   strlen by scanning in a loop for null byte                     ;
; Note      :   This program was tested on Ubuntu 14.04 64 bit using           ;
;               nasm 2.10.09 and gcc 4.8.4.                                    ;
;                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%define STDOUT 1
%define SYS_WRITE 1
%define SYS_EXIT 60

section .rodata
    usage_str : db "Please specify a string as argument", 10, 0
    usage_len : equ $ - usage_str

section .text
    global _start

    _start:
        mov rax, [rsp]                  ; argument count check
        cmp rax, 2
        jne .usage

        mov rdi, [rsp + 16]             ; retrieve address of string from stack
        call strlen                     ; compute length of string
        mov rdi, rax
        call print_number               ; and print it
        jmp .exit

        .usage:                         ; print usage message
            mov rax, SYS_WRITE
            mov rdi, STDOUT
            mov rsi, usage_str
            mov rdx, usage_len
            syscall

        .exit:                          ; exit syscall
            xor rdi, rdi
            mov rax, SYS_EXIT
            syscall


    strlen:
        push rbp
        mov rbp, rsp

        xor rax, rax

        .cmploop:
            cmp BYTE [rdi + rax], 0     ; check if current byte is null
            je .cmpdone                 ; if yes, done
            inc rax                     ; else increment length counter
            jmp .cmploop                ; and continue

        .cmpdone:
            leave
            ret


    print_number:
        push rbp
        mov rbp, rsp

        mov rax, rdi                    ; number to print
        xor rcx, rcx                    ; length counter
        mov rbx, 10

        .divloop:
            cdq
            div rbx                     ; divide by 10
            add rdx, 48                 ; convert remainder to ASCII digit
            dec rsp
            mov BYTE [rsp], dl          ; and store it on the stack
            inc rcx
            cmp rax, 0                  ; if quotient is 0
            je .done                    ; no more digits
            xor rdx, rdx                ; else continue
            jmp .divloop

        .done:                          ; write digit string to stdout
            mov rax, SYS_WRITE
            mov rdi, STDOUT
            mov rsi, rsp
            mov rdx, rcx
            syscall

            leave
            ret
