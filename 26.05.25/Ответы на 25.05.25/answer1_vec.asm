;comiss comisd ucomiss ucomisd - в чём отличие приведите код и примеры данных на которых можно увидеть различие comiss и ucomiss - какие флаги они выставляют 
;последняя буква s d  означает число одинорной точности или двойной
;все 4 инструкции созданы для сравнения вещественных чисел
; ZF, SF, PF - выставятся после сравнениния остальные будут 0, в случае ошибки будет PF = 1 обычное поведение PF = 0
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

; попытка в обработку
; ExceptionHandler PROC pExcept:DWORD, pFrame:DWORD, pContext:DWORD, pDispatch:DWORD; .stdcall сам всё слелает
;     outstrln 'исключение ', 0 
;     mov eax, ExceptionContinueExecution  ; Продолжить выполнение
;     ret
; ExceptionHandler ENDP


Start:
    outfloat r4m0
    newline
    outfloat r4p0
    newline
    outhex r4pInf
    newline
    outfloat r4pInf
    newline
    outfloat r4mInf
    newline
    outfloat r4qNaN
    newline

    ; демонстрация работы comiss и  ucomiss для нас одинаковы ответ на различие в конце
    movss xmm0, myr4n1 ; 8.5
    movss xmm1, myr4n2 ; 12.125

    comiss xmm1, xmm0

    outflags; xmm1>xmm0 поэтому по аналогии с cmp флаг cf = 0 

    newline

    movss xmm0, myr4n1 ; 8.5
    movss xmm1, myr4n2 ; 12.125

    comiss xmm0, xmm1

    outflags; xmm0<xmm1 поэтому по аналогии с cmp флаг cf = 1

    newline

    movss xmm0, myr4n3 ; -10
    movss xmm1, myr4n2 ; 12.125

    comiss xmm0, xmm1

    outflags; xmm0<xmm1 поэтому по аналогии с cmp флаг cf = 1

    newline

    movss xmm0, myr4n3 ; -10
    comiss xmm0, xmm0

    outflags; xmm0=xmm0 zf = 1 cf = 0
    newline

    movss xmm0, r4qNaN ; NaN
    movss xmm1, myr4n2 ; 12.125

    comiss xmm0, xmm1

    outflags; xmm0 - NaN ошибка - PF ZF=CF=PF=1

    newline

; различия между comiss ucomiss можно увидеть при работе с sNaN:  qNaN никогда не вызывает исключений в то же время сравнение с sNaN - вызовет сключение #IA
; ucomiss никогда не вызовет исключений, а ведь обработка исключения может быть затратна код не приведён оставим этот должок за курсом Операционных систем я не разобрался

    movss xmm0, myr4n3 ; sNaN
    sqrtss xmm0, xmm0
    movss xmm1, myr4n2 ; 12.125

    ucomiss xmm0, xmm1 ; формально при различных командах разные вещи происходят для наглядности перепишем обработку исключений windows

    outflags; xmm0 - NaN ошибка - PF ZF=CF=PF=1

    newline

    ; Провоцируем исключение через COMISS
    movss xmm0, myr4n3 ; sNaN
    sqrtss xmm0, xmm0
    movss xmm2, r4sNaN
    movss xmm1, myr4n2 ; 12.125

    comiss xmm0, xmm0

    outflags

    exit
end Start