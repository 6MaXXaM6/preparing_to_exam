include console.inc

.data
    N = 7
    S DB 'xjc xjc', 0
    ;S DB '                '

.code
start:
    cld

    mov esi, offset S
    mov edi, N
    shr edi, 1
    mov ecx, edi

    jnc @F; если нечётное то надо прибавить
        inc edi
    @@:

    add edi, esi
    mov esi, offset S


    repe cmpsb

    mov al, 1

    jz @F
        mov al, 0
    @@:

    outu al

    exit
end start