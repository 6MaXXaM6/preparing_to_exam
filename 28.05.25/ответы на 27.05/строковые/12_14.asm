include console.inc

.data
    N = 10
    Ar DD 0,1,2,3,4,5,6,7,8,9
    Br DD N dup(?)
.code


COPY proc
    push ebp
    mov ebp, esp
    push esi
    push edi

    mov esi, [ebp+8]
    mov edi, [ebp+12]
    mov ecx, [ebp+16]

    cld
    rep movsd

    pop edi
    pop esi
    pop ebp
    ret 12
COPY endp

start:

    push N
    push offset Br
    push offset Ar

    call COPY

    mov ecx, N
    mov esi, offset Ar

    L:
        outu [esi]
        lea esi, [esi+4]
        loop L
        
    exit
end start