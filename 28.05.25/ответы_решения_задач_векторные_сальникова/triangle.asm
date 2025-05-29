include console.inc
include helpful.inc

.686P
.XMM

xmm0 equ XMM0
xmm1 equ XMM1
xmm2 equ XMM2
xmm3 equ XMM3
xmm4 equ XMM4
xmm5 equ XMM5
xmm6 equ XMM6
xmm7 equ XMM7


.data
    pos1 real4 1.3, 5.2, 5.3
    pos2 real4 -1.3, 5.2, 1.3
    pos3 real4 1.3, 3.5, 5.3
    z4 real4 ?
    align 16
    ar_result real4 4 dup(?)

.code

; макрос засунуть 3 координаты 4 число 0 заранее должны установить
mov3ups macro vec, reg
    mov edx, [vec]
    mov [esp], eax
    mov edx, [vec+4]
    mov [esp+4], edx
    mov edx, [vec+8]
    mov [esp+8], edx
    movups reg, [esp]
endm

; сложить в reg1 3 первых числа reg3
sum3ups macro reg1, reg2
    movss reg1, reg2
    repeat 2
        shufps reg2, reg2, 00111001b
        addss reg1, reg2
    endm
endm

; посчитать норму |reg1-reg2| положить в regoutput для счёта использовать reg3tmp
findR macro reg1, reg2, reg3tmp, regoutput
    movaps reg3tmp, reg1
    subps reg3tmp, reg2
    mulps reg3tmp, reg3tmp
    sum3ups regoutput, reg3tmp
    sqrtss regoutput, regoutput
endm

findmin proc; vec1, vec2, vec3
    push ebp
    mov ebp, esp


    sub esp, 16
    ; занулим на всякий в принцип можно не делать главное убедиться что movups сработает
    mov dword ptr [esp+12], 0

    ; загружаем наши точки
    mov eax, [ebp+8] 
    mov3ups eax, xmm1
    mov eax, [ebp+12] 
    mov3ups eax, xmm2
    mov eax, [ebp+16] 
    mov3ups eax, xmm3


    add esp, 16
    ; ищем все расстояния
    findR xmm1, xmm2, xmm0, xmm4
    findR xmm1, xmm3, xmm0, xmm5
    findR xmm2, xmm3, xmm0, xmm6

    ; проходимся и ищем рекорд - минимум
    movss xmm0, xmm4

    comiss xmm0, xmm5
    jb @F
        movss xmm0, xmm5
    @@:

    comiss xmm0, xmm6
    jb @F
        movss xmm0, xmm6
    @@:


    sub esp, 4
    movss [esp], xmm0

    ; mov eax, [esp]
    ; outf eax ; распечатка
    
    fld dword ptr [esp]

    add esp, 4

    pop ebp
    ret 12
findmin endp

Start: ; очень рекомендую приноровиться использовать макросы внутри кода, (for repeat forc не обязательно вызывая макропроцедуру)
    push offset pos3
    push offset pos2
    push offset pos1

    call findmin

    fstp z4
    outf z4

    exit
end Start