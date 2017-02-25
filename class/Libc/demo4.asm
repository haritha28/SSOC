extern printf
extern scanf

section .rodata
    var1 :    db "%d", 0
    var2 :    db "%d", 10, 0
    var3 :    db "Same", 10, 0
    var4 :    db "Enter number: ", 0

section .bss
    var6 : resq 1
    var7 : resq 1

section .text
    global main

    main:
        push rbp
        mov rbp, rsp

        mov rdi, var4
        call printf

        mov rsi, var6
        mov rdi, var1
        call scanf

        mov rdi, var4
        call printf

        mov rsi, var7
        mov rdi, var1
        call scanf

        mov rax, QWORD [var6]
        cmp rax, QWORD [var7]
        jg .label1
        jl .label2
        jmp .label3

        .label1:
            mov rsi, QWORD [var6]
            jmp .label4

        .label2:
            mov rsi, QWORD [var7]
            jmp .label4

        .label3:
            mov rdi, var3
            call printf
            jmp .label5

        .label4:
            mov rdi, var2
            call printf

        .label5:
            xor rax, rax
            leave
            ret
