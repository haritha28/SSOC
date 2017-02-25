;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                              ;
; Author    :   Arvind                                                         ;
; Date      :   22/12/2016                                                     ;
; Program   :   strlen by scanning for null byte using rep and scas            ;
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
        call strlen                     ; compute length
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

        xor rax, rax                    ; al = byte to compare
        xor rcx, rcx                    ; initialize counter
        dec rcx                         ; to -1
        cld                             ; clear direction flag
        repne scasb                     ; scan bytes pointed to by rdi till equal to
                                        ; al while incrementing rcx
        mov rax, rcx                    ; 2's complement of rcx = length
        not rax
        dec rax

        leave
        ret


    print_number:                       ; print number after converting to string
        push rbp
        mov rbp, rsp

        mov rax, rdi
        xor rcx, rcx
        mov rbx, 10

        .divloop:
            cdq
            div rbx
            add rdx, 48
            dec rsp
            mov BYTE [rsp], dl
            inc rcx
            cmp rax, 0
            je .done
            xor rdx, rdx
            jmp .divloop

        .done:
            mov rax, SYS_WRITE
            mov rdi, STDOUT
            mov rsi, rsp
            mov rdx, rcx
            syscall

            leave
            ret
