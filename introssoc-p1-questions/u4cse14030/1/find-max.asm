BITS 64

;%define STDIN 0
%define STDOUT 1
;%define STDERR 2
%define SYS_WRITE 1
%define SYS_EXIT 60

section .rodata
    inp: db "Same",10,0

section .text
    global _start

    _start:
    mov rax, QWORD [rsp]            ; argument count check
    cmp rax, 0x2
    jg .label1

  .label1:                         ;saves the count of numbers into few registers
      sub rax,1
      mov r13, rax              ;
      mov r14, r13
      mov r15, r13
      mov r11, [rsp+8]        ;intialised the first number to be large
      mov rbx, r11            ;pointer
      mov r10, rax            ; argument count check

    .label2:                        ;inner loop starts
        dec r13             
        cmp r13 ,0
        je .label6
        cmp r11,rbx
        jg .label3
        jl .label4
        je .label5

    .label3:
        add rbx, 8
        jmp .label2

    .label4:
        mov r11, rbx
        add rbx, 8
        jmp .label2

    .label5:
        add rbx, 8
        jmp .label2

    .label6:
        dec r14
        cmp r14, 0
        je .final
        jne .label7

    .label7:
        mov r13, r14
        jmp .label2


    .final:

        mov rax, SYS_WRITE
        mov rdi, STDOUT
        mov rsi, r11
        mov rdx, 1
        syscall


        xor rax, rax
        leave
        ret
