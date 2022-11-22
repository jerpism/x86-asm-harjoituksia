global _start

section .data
    msg: db 0x16    ; puskuri luettavalle viestille

section .text

_start:
    ; Luetaan viesti
    mov eax, 0x03   ; read() syscall
    mov ebx, 1      ; luetaan STDIN
    mov ecx, msg    ; luettava puskuri
    mov edx, 0x16   ; luetaan 16 tavua

    int 0x80

    ; Tulostetaan luettu viesti
    mov eax, 0x04   ; write() syscall
    mov ebx, 1      ; tulostetaan STDOUT
    mov ecx, msg    ; luettu puskuri
    mov edx, 0x16   ; viestin pituus

    int 0x80


; exit syscall
    mov al, 0x01
    mov ebx, 0
    int 0x80
