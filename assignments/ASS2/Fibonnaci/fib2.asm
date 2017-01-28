BITS 64

extern fib2

section .rodata
    out: db "%d", 10, 0

section .text
    global main

        main:
                push rbp
                mov rbp, rsp

                mov rdi, [rsi + 8]
                mov r8, rdi

                mov rcx, r8
                xor rax, rax
                xor rbx, rbx
                inc rbx
        print:

                push rax
                push rcx

                mov rdi, out
                mov rsi, rax
                xor rax, rax
                call fib2

                pop rcx
                pop rax 

                mov rdx, rax
                mov rax, rbx
                add rbx, rdx
                dec rcx
                jnz print

                pop rbx
                ret
