section .data
    inputBuf db 0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A
    hex db '0123456789ABCDEF' ; Hextable

section .bss
    outputBuf resb 80

section .text
    global _start

_start:
    mov esi, inputBuf  
    mov edi, outputBuf     
    mov ecx, 8 ; # of bytes

convert:
    cmp ecx, 0 ; Exits loop when no bytes
    je print ; Jump to print if done

    mov al, [esi] ; Reads in byte from input
    dec ecx ; Decreases byte count

    shr al, 4  ; Gets the first number
    mov al, [hex+eax] ; Translates into the hex value by moving up the hextable by al places
    mov [edi], al ; Stores hex value into output
    inc edi ; Moves to next byte

    mov al, [esi] ; Resets al for second number
    and al, 0Fh ; Gets second number
    mov al, [hex+eax] ; Translates into the hex value by moving up the hextable by al places
    mov [edi], al ; stores hex value into output
    inc edi ; moves output to next byte

    inc esi ; moves input to next byte
    mov byte [edi], ' ' ; adds space between values
    inc edi ; moves after space
    jmp convert ; loops

print:
    mov ebx, 1 ; stdout
    mov eax, 4 ; sys_write
    mov ecx, outputBuf ; brings the output to print
    mov edx, edi ; grabs the length of the output
    sub edx, outputBuf ; computes the the total length of the output to print
    int 0x80

    mov eax, 1
    int 0x80
