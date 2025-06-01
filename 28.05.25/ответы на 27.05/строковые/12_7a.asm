include console.inc

.data
    N = 10
    X DD 7,9,2,6,8,1,10,7,2,3

.code
start:
    cld
    mov ecx, N
    mov edi, offset X
    mov eax, 5
    repne scasd
    mov bl, 1
    je @F
        mov bl, 0
    @@:

    outu bl
    exit
end start