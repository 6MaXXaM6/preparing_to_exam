.686P
.XMM
.model flat; соглашение не указываем чтобы лишний раз не думать что сделает masm 

.data
    z4 real4 6.8

.code
; в паскале хранится 16 битныъ целых числах поэтому при складывании до 101 элемента переполнений заведомо не будет в 32 битном регистре
; // среднее арифметическое stdcall
; function srartrstdcall(var x: ar; N:word):real; stdcall; external name '_srartrstdcall@8';
; // среднее арифметическое cdecl
; function srartrcdecl(var x: ar; N:word):real; cdecl; external name '_srartrcdecl';
; // среднее арифметическое pascal
; function srartrpascal(var x: ar; N:word):real; pascal; external name 'SRATRPASCAL';
; // среднее арифметическое register
; function srartrregister(var x: ar; N:word):real; register; external name 'srartrregister';
_srartrstdcall@8 proc
    push ebp
    mov ebp, esp

    push esi
    push ebx
    
    mov esi, [ebp+8]; ссылка получили ссылку на массив
    mov esi, [esi]; разыменовали ссылку так как в ebp+8 фактически хранилась ссылка на массив а открытый массив в pascal это ссылка на массив потому так

    movzx ebx, word ptr [ebp+12]; число элементов

    mov ecx, 0; счётчик 
    mov eax, 0; сумма

    L:
        movzx edx, word ptr [esi+2*ecx]
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
_srartrstdcall@8 endp

; название поменяли не чистим стек
_srartrcdecl proc
    push ebp
    mov ebp, esp

    push esi
    push ebx
    
    mov esi, [ebp+8]; ссылка получили ссылку на массив
    mov esi, [esi]; разыменовали ссылку так как в ebp+8 фактически хранилась ссылка на массив а открытый массив в pascal это ссылка на массив потому так

    movzx ebx, word ptr [ebp+12]; число элементов

    mov ecx, 0; счётчик 
    mov eax, 0; сумма

    L:
        movzx edx, word ptr [esi+2*ecx]
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
    ret 
_srartrcdecl endp

; параметры были переданы слева направо 
SRATRPASCAL proc
    push ebp
    mov ebp, esp

    push esi
    push ebx
    
    mov esi, [ebp+12]; ссылка получили ссылку на массив
    mov esi, [esi]; разыменовали ссылку так как в ebp+8 фактически хранилась ссылка на массив а открытый массив в pascal это ссылка на массив потому так

    movzx ebx, word ptr [ebp+8]; число элементов

    mov ecx, 0; счётчик 
    mov eax, 0; сумма

    L:
        movzx edx, word ptr [esi+2*ecx]
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
    ret 8; стек чистим мы
SRATRPASCAL endp

; параметры слева направо а не параметры чисто на регистрах вспоминаем eax, edx, ecx вот значит их и смотрим
srartrregister proc 
    push ebp
    mov ebp, esp

    push esi
    push ebx
    
    mov esi, [eax]; ссылка получили ссылку на массив
; разыменовали ссылку так как в ebp+8 фактически хранилась ссылка на массив а открытый массив в pascal это ссылка на массив потому так

    movzx ebx, dx; число элементов

    mov ecx, 0; счётчик 
    mov eax, 0; сумма

    L:
        movzx edx, word ptr [esi+2*ecx]
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
    ret; стек чистит еблан любящий переименовавать cdecl
srartrregister endp
end