.686P
.XMM
.model flat; соглашение не указываем чтобы лишний раз не думать что сделает masm 

.data
    z4 real4 6.8

.code
_average_ proc
    push ebp
    mov ebp, esp

    push esi
    push ebx
    
    mov esi, [ebp+8]; ссылка получили ссылку на массив

    mov ebx, [ebp+12]; число элементов INTEGER в FORTRAN 77 4 байта и всё по ссылке
    mov ebx, [ebx]

    mov ecx, 0; счётчик 
    mov eax, 0; сумма

    L:
        movzx edx, word ptr [esi+4*ecx]
        add eax, edx
        inc ecx
        cmp ecx, ebx
        jb L

    cvtsi2ss xmm0, eax
    cvtsi2ss xmm1, ebx
    divss xmm0, xmm1; числа одинарной точности


    movss z4, xmm0; ебой я плохой программист хороший бы выделил бы в стеке место и туда бы запушил
    fld z4

    pop ebx
    pop esi

    pop ebp
    ret 8
_average_ endp
end