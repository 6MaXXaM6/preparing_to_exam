include console.inc
include helpful.inc

.686P
.XMM

xmm0 equ XMM0
mm0 equ MM0
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
    myr4n3 real4 -10.9
    myr4n4 real4 7.5
    myr4n5 real4 56.95
    myr4n6 real4 1024.0
    myr8n1 real8 1902.5
    myr8n2 real8 12.0625
    z4 real4 ?
    align 16
    b4 dd 4 dup(1)
    d2 dd 2 dup(?)
    z8 real8 ?
    align 16
    myar4 real4 9.2, 4.6, 1.9, 32.9

    ar_real4 real4 78.5, -32.67,  45.0,  -15.3,  91.2,  -5.5,  123.7,  -80.0,  3.14,  -2.718,  200.0,  -99.9,  67.4,  -42.1,  12.3,  -7.7,  33.9,  -22.8, 150.2,  -55.55

.code


Start:

    ; число real4 - в число - 32 битное 12.125-12 
    movss xmm0, myr4n2; 12.125
    cvtss2si eax, xmm0
    outi eax;12
    newline

    ; 12-12.0
    mov eax, 12
    cvtsi2ss xmm0, eax
    movss z4, xmm0; 12.0
    outf z4;12
    newline

    ;cvtsd2ss xmm0, xmm1 число лвойной точности из xmm1 конвертнёт и положит как число 1 точности в xmm0

    ;cvtps2pi - конвертнёт 2 числа 1 точности (правые 2) в целые числа положит в регистр mmx (64 битный) 32 бита на число
    movaps xmm2, myar4; 9.2, 4.6, 1.9, 32.9
    movaps xmm1, xmm2; а то можно было подумать что так нельзя)!!!!
    cvtps2pi mm0, xmm1 ; mmx для целочисленных 

    lea eax, d2
    movq [eax], mm0 ;инструкция пересылки 64 бит
    ;movaps b4, xmm0; и так тоже можно вообще в конспекте смотрите (кроме shufps)
    outi word ptr d2
    outchar ' ' 
    outi word ptr d2[4]
    newline
    

    ;cvtpd2ps xmm1, xmm2 конвертнёт 2 числа double точности в 2 числа single и положит в младшие разряды

    ; вопрос с звёздочкой:
    ; стандартное округление к ближайшему чётному
    movss xmm0, myr4n1; 8.5
    cvtss2si eax, xmm0
    outi eax; 8
    newline

    cvtss2si eax, myr4n4; операндом в скалярных инструкциях может быть тупо память
    outi eax; 8
    newline

    ; но cvttss2si усекает то есть часть после запятой просто не будет

    cvttss2si eax, myr4n5; 56.95
    outi eax; 56
    newline

    cvttss2si eax, myr4n3; -10.9
    outi eax; -10
    newline
    
    ; при переполнении поведение одинаково
    ; при переполнении когда невозможно округлить слишком большое число вернётся -0.0 максимальное отрицательное 80000000h 
    movss xmm0, myr4n6; 2^10
    movss xmm1, myr4n3; -10
    mulss xmm0, xmm0
    mulss xmm0, xmm0
    mulss xmm0, xmm0; 2^40

    mulss xmm1, xmm0

    cvtss2si eax, xmm0; положительное
    outhex eax; 80000000h 
    newline
    cvtss2si eax, xmm1; отрицательное
    outhex eax; 80000000h 
    newline



    
    ; РЕШЕНИЕ ЗАДАЧИ ПОСЧИТАТЬ ЦЕЛУЮ ЧАСТЬ:
    N equ 20
    xorps xmm0, xmm0

    mov ecx, 0
    mov edx, 0
    
    L:
        cvttss2si eax, dword ptr ar_real4[ecx*4]; нам только целые части нужны без округлений усечение подойдёт
        add edx, eax
        inc ecx
        cmp ecx, N
        jb L

    outcycle:

    outi edx


    exit
end Start