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
    r4qNaN dd 01111111110000000000000000000000b
    r4sNaN dd 01111111101000000000000000000000b
    r4pInf dd 01111111100000000000000000000000b
    r4mInf dd 11111111100000000000000000000000b
    r4p0 dd 00000000h
    r4m0 dd 80000000h
    myr4n1 real4 8.5
    myr4n2 real4 12.125
    myr4n3 real4 -10.0
    myr8n1 real8 1902.5
    myr8n2 real8 12.0625
    z4 real4 ?
    z8 real8 ?
.code


Start:
    outfloat r4m0
    newline
    outfloat r4p0
    newline
    outfloat r4pInf
    newline
    outfloat r4mInf
    newline
    outfloat r4qNaN
    newline
    ; outbin r4sNaN ; sNaN
    ; newline
    ; fld r4sNaN
    ; fstp r4sNaN
    ; outbin r4sNaN ; как видно при перемещении в FPU sNaN -> qNaN
    ; newline
    outfloat r4sNaN; вывод будет qNaN

    newline
    ;будем использовать скалярные инструкции s-scalar s-single
    ;сложение
    newline
    movss xmm0, myr4n1
    movss xmm1, myr4n2

    addss xmm0, xmm1
    movss z4, xmm0
    outfloat z4
    
    ;вычитание
    newline
    movss xmm0, myr4n1
    movss xmm1, myr4n2

    subss xmm0, xmm1
    movss z4, xmm0
    outfloat z4

    ;умножение
    newline
    movss xmm0, myr4n1
    movss xmm1, myr4n2

    mulss xmm0, xmm1
    movss z4, xmm0
    outfloat z4

    ;деление
    newline
    movss xmm0, myr4n1
    movss xmm1, myr4n2

    divss xmm0, xmm1
    movss z4, xmm0
    outfloat z4
    

    ; не работает ни в какую
    ; d-double

    ;сложение
    ; newline
    ; MOVSD xmm0, myr8n1
    ; MOVSD xmm1, myr8n2

    ; ADDSD xmm0, xmm1
    ; MOVSD z8, xmm1

    ; outfloat z8
    
    ; ;вычитание
    ; newline
    ; movsd xmm0, myr8n1
    ; movsd xmm1, myr8n2

    ; subsd xmm0, xmm1
    ; movsd z8, xmm0
    ; outfloat z8

    ; ;умножение
    ; newline
    ; movsd xmm0, myr8n1
    ; movsd xmm1, myr8n2

    ; mulsd xmm0, xmm1
    ; movsd z8, xmm0
    ; outfloat z8

    ; ;деление
    ; newline
    ; movsd xmm0, myr8n1
    ; movsd xmm1, myr8n2

    ; divsd xmm0, xmm1
    ; movsd z8, xmm0
    ; outfloat z8



    ; сложение с qNaN
    newline
    movss xmm0, r4qNaN
    movss xmm1, myr4n2

    addss xmm0, xmm1
    movss z4, xmm0
    outfloat z4
    newline

    ; получение sNaN
    movss xmm0, myr4n3
    sqrtss xmm0, xmm0; вот блять щас точно тут sNaN иначе как он блять возникает
    movss xmm1, myr4n2
    addss xmm0, xmm1    
    movss z4, xmm0

    outfloat z4; всё ещё qNaN но по идее компьютер обработал прерывание

    newline
    newline

    ; получение всякой хуйни
    movss xmm0, myr4n3
    movss xmm1, r4m0
    divss xmm0, xmm1; отриц число делить на -0

    movss z4, xmm0

    outfloat z4; +inf
    newline

    movss xmm0, myr4n3
    movss xmm1, r4p0
    divss xmm0, xmm1; отриц число делить на 0

    movss z4, xmm0

    outfloat z4; -inf

    ;NaN уже получали 

    ; c нулём понятно допустим взять +0*-1

    exit
end Start