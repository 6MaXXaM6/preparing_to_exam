include console.inc
include helpful.inc

.686P
.XMM
.listmacro

xmm0 equ XMM0
xmm1 equ XMM1
xmm2 equ XMM2
xmm3 equ XMM3
xmm4 equ XMM4
xmm5 equ XMM5
xmm6 equ XMM6
xmm7 equ XMM7


.data
    align 16 ; работает)
    A4n4 real4 2.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 2.0; матрица строка за строкой записана
    B4n4 real4 2.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 2.0; матрица строка за строкой записана
    Z4n4 real4 16 dup(?); результат
.code

printMatric proc; fastcall в ecx @printMatric@4
    push ebp
    mov ebp, esp
    mov edx, 0
    prL:
        outf dword ptr [ecx+edx*4]
        outchar ' '
        inc edx
        test edx, 3
        jnz @F
            newline
        @@:
        cmp edx, 16
        jne prL

    pop ebp
    ret
printMatric endp

; вот решение:
AB proc ; stdcall A, B, Z название _AB@12
    push ebp
    mov ebp, esp
    push esi
    push edi

    xorps xmm7, xmm7
    ; Z=AB строка Z считаем нативно
    mov edx, [ebp+8]
    mov esi, [ebp+12]
    mov edi, [ebp+16]

    mov ecx, 0
    ; загрузили строки
    movups xmm1, [edx]
    movups xmm2, [edx+16]
    movups xmm3, [edx+32]
    movups xmm4, [edx+48]

    ; берём столбец
    L:
        mov eax, [esi+ecx*4+48]
        push eax
        mov eax, [esi+ecx*4+32]
        push eax
        mov eax, [esi+ecx*4+16]
        push eax
        mov eax, [esi+ecx*4]
        push eax
        movups xmm5, [esp]
        add esp, 16

        for i, <1, 2, 3, 4>;; обработка каждого столбца i - номер строки в ecx+1 - номер столбца
            movups xmm0, xmm&i ;;чтобы не портить xmm с строкой скопируем их
            mulps xmm0, xmm5 ;; умножим строку i на стобец ecx+1
            ;; счёт суммы в xmm7
            movss xmm7, xmm0
            repeat 3;; 3 раза ещё сдвинуть
                shufps xmm0, xmm0, 00111001b
                addss xmm7, xmm0
            endm
            movss [edi+ecx*4+i*16-16], xmm7; положим в матрицу Z в в i строку (i*16-16) - смещение по строкам в ecx+1 столбец смещение по ecx*4
        endm
        inc ecx
        cmp ecx, 4; до 4 смещение в 4*4 уже следующая строка
        jne L

    pop edi
    pop esi
    pop ebp
    ret 12
AB endp

Start:

    lea ecx, A4n4
    call printMatric

    newline

    lea ecx, B4n4
    call printMatric


    push offset Z4n4
    push offset B4n4
    push offset A4n4
    call AB

    newline

    lea ecx, Z4n4
    call printMatric

    exit
end Start