BITS 64

extern printf
extern atoi

section .rodata
    out: db "%ld", 10, 0
    inp: db"%d",10,0

section .text
    global main

        main:
                push rbp
                mov rbp, rsp

            


                mov r13, -1

                mov rdi,QWORD[rsi+8]
                call atoi

                mov r12, rax 
                cmp r12, 0
                jl .label1  ; if zero then we go to print -1
                jg .label2

                .label1:
                            mov rdi, inp
                            mov rsi, r13
                            call printf
                            xor rax, rax
                            leave 
                            ret


                .label2:
                        
                            mov rcx, r12
                            xor rax, rax
                            xor rbx, rbx
                            inc rbx

                            print:
                                    push rax
                                    push rcx

                                    mov rdi, out
                                    mov rsi, rax
                                    xor rax, rax

                                    pop rcx
                                    pop rax 

                                    mov rdx, rax
                                    mov rax, rbx
                                    add rbx, rdx
                                    dec rcx
                                    jnz print
                                    jz .label3

                

                .label3:
                        call printf
                        jmp .label4

                .label4:           
                        pop rbx
                        xor rax, rax
                        leave
                        ret