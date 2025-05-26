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
    ar_real4 real4 78.5, -32.67,  45.0,  -15.3,  91.2,  -5.5,  123.7,  -80.0,  3.14,  -2.718,  200.0,  -99.9,  67.4,  -42.1,  12.3,  -7.7,  33.9,  -22.8, 150.2,  -55.55
    sample_real4 real4 845.76
.code
; сколько первых чисел массива надо сложить по модулю для превышения (строго) sample_real4 чисел гарантированно хватит считать массив бесконечен
Start:

    exit
end Start