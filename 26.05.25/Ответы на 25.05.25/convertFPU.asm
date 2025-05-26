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
    z4 real4 ?
    z8 real8 ?
    z10 dt ?
.code


Start:
    fld z4
    fstp z8
    fstp z10
    exit
end Start