global _start

section .data
    welcomemsg: db "Tervetuloa, valintasi ovat",0xa  
    welcomelen: equ $-welcomemsg                            ; Viestin pituus

    ; Mahdolliset valinnat
    choice1: db "1. Yhteenlasku",0xa
    choice1len: equ $-choice1

    choice2: db "2. Vähennyslasku",0xa
    choice2len: equ $-choice2

    additionmsg1: db "Anna a (a+b)",0xa 
    addmsg1len: equ $-additionmsg1

    additionmsg2: db "Anna b (a+b)",0xa
    addmsg2len: equ $-additionmsg2


section .bss
    userinput: resb 16
    result:    resb 32

section .text

_start:

    call _welcome 
    call _choices
    call _readinput

    mov edx, [userinput] ; siirretään käyttäjän syöttö rekisteriin
    cmp edx, 0xa31 ; verrataan, 0xa31 = 1\n
    je addition 

    cmp edx, 0xa32 ; verrataan, 0xa32 = 2\n
    je subtraction

    jnz _exit ; Joku muu valinta, poistutaan

    afteroperation:
    call _printresult



    jmp _exit


_exit:
    mov al, 0x1 ; exit()    
    mov bl, 0   ; virhekoodi
    int 0x80


_welcome:
    mov al, 0x04 ; write()
    mov bl, 0x01 ; STDOUT
    mov ecx, welcomemsg
    mov edx, welcomelen
    int 0x80
    ret


_choices:
    mov al, 0x04 ; write()
    mov bl, 0x01 ; STDOUT

    mov ecx, choice1
    mov edx, choice1len
    int 0x80

    mov al, 0x04 ; write()
    mov bl, 0x01 ; STDOUT

    mov ecx, choice2
    mov edx, choice2len
    int 0x80
    ret


_readinput:
    mov al, 0x03 ; read()
    mov bl, 0x01 ; STDIN
    mov ecx, userinput
    mov edx, 16

    int 0x80

    ret


_printresult:
    mov al, 0x04 ; write()
    mov bl, 0x01 ; STDOUT
    mov ecx, result
    mov edx, 32

    int 0x80

    ret


addition:
    mov al, 0x04 ; write()
    mov bl, 0x01 ; STDOUT
    mov ecx, additionmsg1
    mov edx, addmsg1len
    int 0x80

    ; a numeron lukeminen (a+b)
    call _readinput
    mov edx, [userinput]
    sub edx, 0xa30 ; muunna ASCII-numero desimaaliksi
    push edx       ; puske pinoon

    mov al, 0x04 ; write()
    mov bl, 0x01 ; STDOUT
    mov ecx, additionmsg2
    mov edx, addmsg2len
    int 0x80

    ; b numeron lukeminen (a+b)
    call _readinput
    mov ebx, [userinput]
    sub ebx, 0xa30 ; muunna ASCII-numero desimaaliksi

    pop edx        ; edx pinosta
    add edx, ebx   ; summaa numerot

    add edx, 0xa30 ; muunna takaisin ASCII numeroksi
    mov [result], edx


    jmp afteroperation

subtraction:

    jmp afteroperation

    

