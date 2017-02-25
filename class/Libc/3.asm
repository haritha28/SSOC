BITS 64

extern printf
extern scanf

section .data		
    var1 :    dq 1      ; pointer and value of var1 is 1

section .rodata		;stores read only data this is a string.
    var2 :    db "%d", 10, 0  

section .text	;contains code - executable part 
    global main

    main:
        push rbp
        mov rbp, rsp

        .label1:
            mov rsi, QWORD [var1]
            mov rdi, var2
            call printf
            inc QWORD [var1]
            cmp QWORD [var1], 10
            jg .label2
            jmp .label1

        .label2:
            xor rax, rax
            leave
            ret
