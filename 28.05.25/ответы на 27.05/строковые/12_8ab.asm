include console.inc

.data
    N = 16
    S DB '  help please   '
    ;S DB '                '

.code
start:
; a)
    cld
    mov ecx, N
    mov edi, offset S
    mov al, ' '
    repe scasb

    mov ebx, N
    sub ebx, ecx;  каждое сравнение -1, сравнений на 1 больше
    test ecx, ecx
    jz @F
        dec ebx
    @@:
    outu ebx
; exit
    newline
; б)
    std
    mov ecx, N
    lea edi, [S+N-1]
    mov al, ' '
    repe scasb

    mov ebx, N
    sub ebx, ecx;  каждое сравнение -1, сравнений на 1 больше
    test ecx, ecx
    jz @F
        dec ebx
    @@:
    outu ebx
    exit
end start