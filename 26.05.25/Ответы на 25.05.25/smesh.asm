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
    align 16
    vector1 real4 6.4, 1.7, 2.5
    align 16
    vector2 real4 6.4, 1.7, 2.5
    align 16
    vector3 real4 6.4, 1.7, 2.5
    nol real4 0.0
    z real4 1.0

.code
Start:

    ; mov ebp, esp; сохранили
    ; xorps xmm0, xmm0; обнулили
    ; and esp, 0FFFFFFF0h; выравнили
    xorps xmm4, xmm4
    xorps xmm0, xmm0

    movaps xmm1, vector1
    movaps xmm2, vector2
    movaps xmm3, vector3
    shufps xmm2, xmm2, 11001001b; наша задача тих так перемешать чтобы под v1[1] оказался v2[2] под v1[2] оказался v2[3]
    shufps xmm3, xmm3, 11010010b; биты в маске это на самом деле то какое число мы хотим потавить на эту позицию 1,2,3,4

    newline
    xorps xmm0, xmm0

    addps xmm4, xmm1
    mulps xmm4, xmm2
    mulps xmm4, xmm3

    addss xmm0, xmm4
    shufps xmm4, xmm4, 11001001b
    addss xmm0, xmm4
    shufps xmm4, xmm4, 11001001b
    addss xmm0, xmm4

    ; задача посчитать смешанное произведение опредедлитель тогда нужны следующие произведнеия: v1[1] v2[2] v3[3];  v1[2] v2[3] v3[1] ; v1[3] v2[1] v3[2] с плюсом
    ; c минусом  v1[1] v2[3] v3[2]   v1[2] v2[1] v3[3]  v1[3] v2[2] v3[1];

    ;вспоминная как работаtn  произведение переастановок
    shufps xmm2, xmm2, 11001001b
    shufps xmm3, xmm3, 11010010b

    xorps xmm4, xmm4

    addps xmm4, xmm1
    mulps xmm4, xmm2
    mulps xmm4, xmm3
    
    subss xmm0, xmm4
    shufps xmm4, xmm4, 11001001b
    subss xmm0, xmm4
    shufps xmm4, xmm4, 11001001b
    subss xmm0, xmm4

    movss z, xmm0
    outf z ; получаем ноль матрица то вырожденна - векторы в 1 плоскости
    newline

    mov esp, ebp
    exit
end Start