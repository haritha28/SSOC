extern fclose
extern fopen
extern fread
extern memset
extern printf

section .rodata
    var1 : db "Cannot open file! Exiting!", 10, 0
    var2 : db "r", 0
    var3 : db "%s", 0
    var4 : db "Usage: %s FILENAME", 10, 0

section .bss
    var5 : resb 20 + 1
    var6 : resq 1
    var7 : resq 1

section .text
    global main

    main:
        push rbp
        mov rbp, rsp

        mov r10, rdi
        mov r11, rsi

        cmp r10, 2
        jne .label1

        mov rax, [r11 + 8]
        mov QWORD [var6], rax

        mov rsi, var2
        mov rdi, QWORD [var6]
        call fopen
        test rax, rax
        jz .label2

        mov [var7], rax

        mov rdx, 20
        xor rsi, rsi
        mov rdi, var5
        call memset

        mov rcx, QWORD [var7]
        mov rdx, 20
        mov rsi, 1
        mov rdi, var5
        call fread
        mov BYTE [var5 + 20], 0

        mov rsi, var5
        mov rdi, var3
        call printf

        mov rdi, QWORD [var7]
        call fclose
        mov rax, 0
        jmp .label3

        .label1:
            mov rsi, r11
            mov rsi, QWORD [rsi]
            mov rdi, var4
            call printf
            mov rax, 1
            jmp .label3

        .label2:
            mov rdi, var1
            call printf
            mov rax, 1
            jmp .label3

        .label3:
            leave
            ret
