include console.inc

.data
    X DB 'dwadwa%53fa', 0

.code
start:
    outstrln offset X
    cld
    mov ecx, lengthof X

    mov edi, offset X
    mov al, '%'

    repne scasb

    mov esi, edi
    mov al, 0
    rep stosb

    outstrln offset X
    exit
end start