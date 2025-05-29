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
    x real4 0.5
    z4 real4 ?; результат
.code; разложить экспоненту до 3 e^x = 1+x/1+x^2/2+o(x^2) в окрестностии нуля x - вещественное (закомментировано для Z)
; вот решение:
exp3 proc; stdcall правильно назвать _exp@4
    push ebp
    mov ebp, esp

    movss xmm2, [ebp+8]
    
    ; если x - целочисленный
    ; cvtsi2ss xmm2, [ebp+8]

    ; следующий код вызван тем что мы в процедуре и не хотим использовать data (ред флаг) поэтому вычислим 

    mov eax, 1
    cvtsi2ss xmm0, eax; положили 1.0
    movss xmm1, xmm0
    addss xmm1, xmm0 ; в xmm1 2.0


    addss xmm0, xmm2
    mulss xmm2, xmm2
    divss xmm2, xmm1
    addss xmm0, xmm2

    movss [esp], xmm0
    fld dword ptr [esp]

    pop ebp
    ret 4
exp3 endp
Start: ; разложить экспоненту до 3 e^x = 1+x/1+x^2/2+o(x^2) в окрестностии нуля


    push x
    call exp3

    fstp z4; это не процедура можно и в .data писать
    outf z4; правдеподобно

    exit
end Start