
; Adds two numbers provided as arguments and prints sum

BITS 64

extern atoi
extern printf

section .rodata
    out: db "%d", 10, 0


section .text
    global main

    main:
        push rbp
        mov rbp, rsp

        xor rax, rax
        dec rax
        cmp rdi, 3
        jne .exit

        mov rbx, rdx
        mov rsi, QWORD [rbx + 8]
        call atoi
        mov r12, rax

        mov rdi, QWORD [rbx + 8]
        call atoi
        add r12, rax

        mov rsi, r12
        mov rdi, out
        call printf
        xor rax, rax

        .exit:
            leave
            ret
