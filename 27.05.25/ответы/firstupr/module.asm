.686
.model flat; соглашение не указываем чтобы лишний раз не думать что сделает masm 

.code

_howmanyotr@4 proc
    push ebp
    mov ebp, esp
    
    push ebx

    mov eax, 0; возвращется word 16 бит но можно и в eax считать
    mov edx, [ebp+8]; взяли адрес
    mov ecx, 0

    L:
        mov bx, [edx+ecx*2]
        test bx, 10000000b
        jz @F
            inc eax
        @@:
        inc ecx
        cmp ecx, 10
        jb L

    pop ebx
    pop ebp
    ret 4
_howmanyotr@4 endp
end