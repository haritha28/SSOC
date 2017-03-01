BITS 64

%define STDIN 0
%define STDOUT 1
%define STDERR 2

;%define SYS_READ 0
%define SYS_WRITE 1
;%define SYS_OPEN 2
;%define SYS_CLOSE 3
%define SYS_EXIT 60

section .rodata
        msgone: db "!",0,0
      ;msgex: 0x215b3a3a2d315d
      msgdef: db "Hello world!",10,0
      lendef:    equ $-msgdef
      msg: db "Hello ", 0,0
      len: equ $-msg

section .text
    global _start

    _start:
        mov rax, QWORD [rsp]            ; argument count check
        cmp rax, 0x2
        jne .label1
        je  .label2

        .label1:
             mov rax, SYS_WRITE
             mov rdi, STDOUT
             mov rsi, msgdef
             mov rdx, lendef
             syscall
             jmp .final

        .label2:
             mov rdi , [rsp+16]
             mov rbx, rdi
             call .strlen
             mov r10 ,rax

             mov rax, SYS_WRITE              ; Set write system call number
             mov rdi, STDOUT                 ; 1st argument of SYS_WRITE: file ID
             mov rsi, msg                    ; 2nd argument of SYS_WRITE: buffer
             mov rdx, len                    ; 3rd argument of SYS_WRITE: length of buffer
             syscall

             mov rax, SYS_WRITE
             mov rdi, STDOUT
             mov rsi, rbx
             mov rdx, r10
             syscall

             mov rax, SYS_WRITE
             mov rdi, STDOUT
             mov rsi, msgone
             mov rdx, 1
             syscall

             jmp .final

     .final:
             mov rax, SYS_EXIT               ; Set exit system call number
             xor rdi, rdi                    ; 1st argument of SYS_EXIT: exit code
             syscall                         ; the system call invokes the exit(0)


     .strlen:
             push rbp
             mov rbp, rsp

             xor rax, rax

             .cmploop:
                 cmp BYTE [rdi + rax], 0     ; check if current byte is null
                 je .cmpdone                 ; if yes, done
                 inc rax                     ; else increment length counter
                 jmp .cmploop                ; and continue

             .cmpdone:
                 leave
                 ret
