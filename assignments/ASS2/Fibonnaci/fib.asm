BITS 64

extern printf
extern scanf

section .rodata
    prompt: db "Enter the number:",
    out: db "%d", 10, 0
    inp: db"%d"

section .bss 
    num: resq 1 ; the fib number 

section .text
    global main

    main:
        push rbp       ;stack frame setup
        mov rbp, rsp

        mov rdi,prompt ;call the prompt
        call printf

        mov rsi, num    ;call the scanf
        mov rdi, inp
        call scanf

        mov rcx, QWORD[rsi] ; setting counter till the number

        xor rax, rax    ; store the first number = 0
        xor rbx, rbx    ; store the second number = 0
        inc rbx         ; but second number is 1 so increment

        .label1:

            push rax
            push rcx

            mov rdi, out    ;print the values 
            mov rsi, rax
            call printf

            pop rax
            pop rcx

            mov rdx, rax 
            mov rax, rbx
            add rbx, rdx
            dec rcx
            jnz .label1

            pop rbx ; restoring rbx old value
            ret






