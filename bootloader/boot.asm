BITS 16
ORG 0x7C00

BOOT_DISK equ 0x800

global entry
entry:
    mov sp, 0x4000
    mov bp, 0x4000

    mov [BOOT_DISK], dl

    mov ah, 0x2
    mov al, 1
    mov ch, 0
    mov dh, 0
    mov cl, 2
    mov bx, 0x7e00
    mov dl, [BOOT_DISK]
    int 0x13

    jmp 0x7e00

times 510-($-$$) db 0
dw 0xAA55
