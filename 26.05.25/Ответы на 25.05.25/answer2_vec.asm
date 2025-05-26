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
    z4 real4 ?
.code
; сколько первых чисел массива надо сложить по модулю для превышения (строго) sample_real4
; прикладывается эффективное решение считается что в массиве заведо достаточно чисел
Start:
    xorps xmm0, xmm0

    movss xmm2, sample_real4

    mov eax, 7FFFFFFFh

    push eax
    push eax
    push eax
    push eax

    movups xmm7, [esp]; маска для того чтобы числа делать по модулю

    add esp, 16

    mov ecx, 0; мы считаем что массив практически неограничен те проверку хвоста делать не будем (если такая задача будет то очевидно что такой постановки не будет)

    L:
        movaps xmm1, ar_real4[ecx*4]
        andps xmm1, xmm7; возьмём модуль
        @@:
            addss xmm0, xmm1;
            inc ecx
            comiss xmm0, xmm2
            ja outcycle; above как для беззнаковых cf=0, zf=0
            test ecx, 3; мы должны проверить что ecx - число что мы сложили кратно 4 для получения новых данных последние 3 цифры  = 0
            jz L
            shufps xmm1, xmm1, 00111001b; сдвинули вправо циклически
            jmp @B

    outcycle:
    outu ecx;14 
    newline
    
    ; решение выше рабочее если заведомо известно что чисел Хватит код выше скорее тренировка ниже код который херовый но работает безотказно
    N equ 20
    xorps xmm0, xmm0
    movss xmm2, sample_real4

    mov eax, 7FFFFFFFh
    push eax
    movss xmm7, [esp] 
    pop eax

    mov ecx, 0
    
    Ll:
        cmp ecx, N
        jb @F
            outstrln 'array end', 0
            exit 1; выход с ошибкой
        @@:
        movss xmm1, dword ptr ar_real4[ecx*4]
        andps xmm1, xmm7; andss нет
        addss xmm0, xmm1; модуль
        inc ecx
        comiss xmm0, xmm2
        ja outcycle2
        jmp Ll

    outcycle2:

    outu ecx;14
    exit
end Start