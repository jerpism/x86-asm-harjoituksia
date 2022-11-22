global _start

section .data
    msg: db "Hello World!",0xa ; Viesti, joka tulostetaan
    len: equ $-msg             ; Lasketaan viestin pituus

section .text

_start:

    mov eax, 0x4      ; Write() syscall
    mov ebx, 1      ; Tiedosto johon kirjoitetaan (STDOUT)
    mov ecx, msg    ; Kirjoitettava viesti
    mov edx, len    ; viestin pituus

    int 0x80        ; käske kerneliä ajamaan write()

    mov al, 1       ; Exit() syscall
    mov ebx, 0      ; statuskoodi 
    int 0x80        ; käske kerenliä ajamaan exit()

