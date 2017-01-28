BITS 64
        extern printf
        extern scanf

        section .bss 
                num1: resq 1 ;the argument

        section .rodata
                prompt: db "Enter the number", 0
                inp: db"%d", 10, 0
                out: db "% 20ld", 10, 0


        section .text
                global main
main:
        Push rbx; 

        mov rdi, prompt
        call printf

        mov rsi, num1
        mov rdi, inp
        call scanf

        Mov ecx, QWORD[rsi]
        Xor rax, rax 
        Xor rbx, rbx  
        Inc rbx
print:

        Push rax
        Push rcx

        Mov rdi, out
        Mov rsi, rax
        Xor rax, rax 
        Call printf

        Pop rcx
        Pop rax 

        Mov rdx, rax
        Mov rax, rbx
        Add rbx, rdx
        Dec ecx
        Jnz print

        Pop rbx
        Ret

       