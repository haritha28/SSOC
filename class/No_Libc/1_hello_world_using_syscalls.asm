        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                              ;
; Author    :   Arvind                                                         ;
; Date      :   20/12/2016                                                     ;
; Program   :   print "Hello World" using system calls                         ;
; Note      :   This program was tested on Ubuntu 14.04 64 bit using           ;
;               nasm 2.10.09 and gcc 4.8.4.                                    ;
;                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BITS 64

%define STDOUT 1
%define SYS_WRITE 1
%define SYS_EXIT 60

section .rodata
    msg:    db "Hello World", 10, 0     ; msg to print
    len:    equ $-msg                   ; len of msg equ equivalent to the assignment operator and  $-msg gives the length 

section .text
    global _start                       ; entry point

    _start:
        ;write(1, "Hello World\n", len)
        mov rax, SYS_WRITE              ; Set write system call number
        mov rdi, STDOUT                 ; 1st argument of SYS_WRITE: file ID
        mov rsi, msg                    ; 2nd argument of SYS_WRITE: buffer
        mov rdx, len                    ; 3rd argument of SYS_WRITE: length of buffer
        syscall                         ; Invoke system call interface of kernel

        ;exit(0)
        mov rax, SYS_EXIT               ; Set exit system call number
        xor rdi, rdi                    ; 1st argument of SYS_EXIT: exit code
        syscall                         ; the system call invokes the exit(0)
