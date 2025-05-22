.686P
.XMM
.model flat, stdcall
option casemap:none

xmm0 equ XMM0
xmm1 equ XMM1
xmm2 equ XMM2
xmm3 equ XMM3
xmm4 equ XMM4
xmm5 equ XMM5
xmm6 equ XMM6
xmm7 equ XMM7


public scalar_mul

.code
;
; соглашение stdcall
;
; Скалярное произверение:
; первый аргумент указатель на массив a
;  [ebp + 8]
;
; второй аргумент указатель на массив b
;  [ebp + 12]
;
; третий аргумент размер массива
;  [ebp + 16]
;
scalar_mul proc
        push ebp
        mov ebp, esp
        
        push edi
        push esi
        push ebx
    
        mov edi, [ebp + 8]
        mov esi, [ebp + 12]
    
        mov eax, [ebp + 16]
        mov ebx, 4
        mov edx, 0
        div ebx   ; в eax - размер массива делённый на 4
                  ; в edx - остаток от деления на 4.
    
        xorps xmm0, xmm0

        ;
        ; цикл по элементам векторов в прямом порядке.
        ;
        mov ecx, 0
    loop_vector_scalar_mul:
        cmp ecx, eax
        jae after_loop_vector_scalar_mul
        
    
        ;    xxxx:xxxx:xxxx:xxxx|xxxx:xxxx:xxxx:xxxx|
        ;
        ;
        ; ecx*4*4 + edi - смещение для достура к началу
        ;                 очередной четвёрки элементов 
        ;                 массива a
        ;
        mov ebx, ecx
        shl ebx, 4 ; ebx := ebx * 16
        movaps xmm1, [edi + ebx]
        movaps xmm2, [esi + ebx]
        
        ; если части регистров xmm1 и xmm2 считать элементами
        ; массива, то для операции векторного умножения получим: 
        ; xmm1[0] := xmm1[0] * xmm2[0];
        ; xmm1[1] := xmm1[1] * xmm2[1];
        ; ....
        ; xmm1[3] := xmm1[3] * xmm2[3];
        ;
        ; затем для сложения будет так же.
        ;
        mulps xmm1, xmm2
        addps xmm0, xmm1
        
        inc ecx
        jmp loop_vector_scalar_mul
    after_loop_vector_scalar_mul:
        
         ;xorps  xmm2, xmm2  ; занулили xmm2

;       SSE3 не поддерживается masm 6.14  приходится закоментировать.
;       следующие инструкции
;
;        haddps xmm2, xmm0
;        haddps xmm0, xmm2
        
         movss xmm2, xmm0
    
         ;shufps xmm1, xmm0, число  8 - битное   ааbbccdd
         ; Здесь aa - 2 бита новая позиция старшего упакованного в регистр
         ; числа одинарной точности.
         ; bb -- следующая часть,
         ; .... и так далее.
         ;
         ; нам необходимо организовать циклический сдвиг элементов (плавающая точка одинарной точности).
         ; это можно сделать так:
         ;   00 11 10 01  <--- новые позиции элементов в векторном регистре. 
         ;   3   2  1  0  <---- номера элементов (изначальные позиции, не поменяные).
         ;
    
         shufps xmm0, xmm0,  00111001b
         addss  xmm2, xmm0
    
         shufps xmm0, xmm0,  00111001b
         addss  xmm2, xmm0
        
         shufps xmm0, xmm0,  00111001b
         addss  xmm2, xmm0

         movss xmm0, xmm2
        
        ;
        ; дообрабатываем оставшуюся часть массива,
        ; где элементов недостаточно для формирования векторной инструкции.
        ; их количество остаток от деления на 4.
        ;

        ; устанавливаем  значение ecx, так,
        ; так, чтобы он указыват на номер элемента 
        ; сразу после всех четвёрок.
        shl eax, 2
        mov ecx, eax
        mov ebx, [ebp + 16]  ; размер массива
    loop_process_array_tail:
        cmp ecx, ebx
        jae after_loop_process_array_tail
        
        movss xmm2, [edi+ecx*4]
        movss xmm3, [esi+ecx*4]
        mulss xmm2, xmm3
        addss xmm0, xmm2
    
        inc ecx
        jmp loop_process_array_tail
    after_loop_process_array_tail:
    
        sub esp, 4
        movss [esp], xmm0
        fld dword ptr [esp]
        add esp, 4
    
        pop ebx
        pop esi
        pop edi
    
        pop ebp
        ret
scalar_mul endp

end
