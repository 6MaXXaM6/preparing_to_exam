include console.inc
STUD STRUC ; по хорошему структуру вы описали сами)
    AGE db ?
    MARKS db ?,?,?,? ; для ручной постановки
    FAM db 20 dup('a'), 0 ; нуль терминатор для вывода
STUD ENDS

xmm0 equ XMM0
xmm1 equ XMM1
xmm2 equ XMM2

.const
    N db 50

.data
    P STUD <>
    GR STUD 5 dup ( <19,<4,3,5,4>>, <20,<3,4,2,5>>, <22,<5,5,4,5>>, <21,<4,4,4,4>>, <23,<5,5,5,5>>, <18,<3,3,4,2>>, <24,<4,5,4,3>>, <19,<2,5,5,4>>, <20,<5,4,5,5>>, <22,<4,3,4,4>>)
    sample real4 4.6

.code
start:
    ; на экзамене скучно умножите 4.6*4 = 18.4 и будете брать с 19
    mov eax, 4
    cvtsi2ss xmm2, eax
    movss xmm1, sample
    ; решение пункта д++ число людей с балом выше 4.6 (рекомендую оформить в виде процедуры)
    
    mov eax, 0
    mov edx, 49* size STUD
    L:
        mov ecx, 4
        mov ebx, 0
        @@:
            add bl, GR[edx][ecx]
        loop @B ; анонимные метки в вопроснике) @B назад back
        cvtsi2ss xmm0, ebx
        divss xmm0, xmm2
        comiss xmm0, xmm1

        jna @F; впереёд Future
            inc eax
        @@: 

        cmp edx, 0
        je skip
        sub edx, size STUD
        jmp L
    skip:
    ; вывод ответа (любой другой регистр)
    outu eax; 15 всё верно 3*5
    exit
end start