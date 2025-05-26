include console.inc; пояснение по работе shufps
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
    align 16
    ar_real4 real4 78.5, -32.67,  45.0,  -15.3,  91.2,  -5.5,  123.7,  -80.0,  3.14,  -2.718,  200.0,  -99.9,  67.4,  -42.1,  12.3,  -7.7,  33.9,  -22.8, 150.2,  -55.55
    sample_real4 real4 845.76
    z4 real4 ?
.code


Start:

    xorps xmm0, xmm0
    xorps xmm1, xmm1
    xorps xmm2, xmm2

    movaps xmm1, oword ptr ar_real4
    movaps xmm2, oword ptr ar_real4[4*4]

    movss z4, xmm1
    outf z4
    newline

    outstrln 'experiment', 0
    ; чтобы убидиться что А Н Сальников не прав или недопонят:
    ;ar_real4 real4 78.5, -32.67,  45.0,  -15.3...
    movaps xmm3, ar_real4
    shufps xmm3, xmm3, 00000000b
    movss z4, xmm3
    outf z4; 78.5
    newline

    movaps xmm3, ar_real4
    shufps xmm3, xmm3, 00000001b
    movss z4, xmm3
    outf z4; -32.67
    newline

    movaps xmm3, ar_real4
    shufps xmm3, xmm3, 00000010b
    movss z4, xmm3; 45
    outf z4
    newline

    movaps xmm3, ar_real4
    shufps xmm3, xmm3, 00000011b
    movss z4, xmm3;-15.3
    outf z4
    newline
    outstrln 'experiment end', 0

; Сальников:
;   00 11 10 01  <--- новые позиции элементов в векторном регистре. 
;   3   2  1  0  <---- номера элементов (изначальные позиции, не поменяные).

    shufps xmm1, xmm1, 00111001b; по логике должно выйти -15.3; факт -32.67
    movss z4, xmm1
    outf z4
    newline

; Мои глубоконаучные (шутка) исследования показали что 
; 00 11 10 01  <--- маска
; 3   2  1  0  <---- номера элементов (изначальные позиции, не поменяные).
; A   B  C  D  <---  значения в xmm по номерам изчально.
; D   A  B  С <--- читать так положить по номеру i из источника число с номером соответстующей маски те по позиции 0 (0-31 биты) поставить 01 (32-63 биты)



    movaps xmm1, oword ptr ar_real4

    shufps xmm1, xmm2, 00111001b; 
    ;shufps xmm1, xmm1, 00000011b; поиграемся и как можно узнать что правые(0-3 биты) 4 биты берутся из операнда назначения (1 операнд) (4-7) биты берутся из операнда источника

; 00 11 10 01  <--- маска
; 3  2  1  0  <---- номера элементов (изначальные позиции, не поменяные).
; A  B  C  D  <---  значения в xmm1 по номерам изчально.
; E  F  G  H  <---  значения в xmm2 по номерам изчально.
; H  E  B  С <--- в правой половине (00 01 первые 2 числа из xmm1) в левой половине из xmm2
; примечание shufps xmm1, xmm2, 00000000b сработает то есть повторения возможны:

; 00 00 00 00  <--- маска
; 3  2  1  0  <---- номера элементов (изначальные позиции, не поменяные).
; A  B  C  D  <---  значения в xmm1 по номерам изчально.
; E  F  G  H  <---  значения в xmm2 по номерам изчально.
; H  H  D  D <--- в правой половине (00 01 первые 2 числа из xmm1) в левой половине из xmm2

    movss z4, xmm1
    outf z4
    newline


    exit
end Start