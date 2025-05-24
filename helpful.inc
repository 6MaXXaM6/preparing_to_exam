; Процедура вывода байта в бинарном виде
.data
    byte_sample db '00000000 ', 0
    byte_hex_sample db '00', 0
.code
    L_fmt_str_macros_for_float db "%f", 0
    L_fmt_str_macros_for_tenbyte_float db "%lf", 0
    numbers db '0123456789ABCDEF'

outfloat equ OUTFLOAT
outf equ OUTFLOAT
OUTFLOAT macro numb_to_print

    if type numb_to_print EQ 4
        pushad
        pushfd

        mov eax, numb_to_print
        sub esp, 8
        mov [esp], eax
        fld dword ptr [esp] ; load to FPU with conversion to 80-bit float
        fstp qword ptr [esp] ; get from fpu with conversion to 64-bit
        push offset L_fmt_str_macros_for_float
        call crt_printf
        add esp, 4+8

        popfd
        popad
    endif
    if type numb_to_print EQ 8 ; support only memory argument

        pushad
        pushfd

        lea eax, numb_to_print
        invoke crt_printf, offset L_fmt_str_macros_for_float, dword ptr [eax], dw

        popfd
        popad
    endif
    if type numb_to_print EQ 10 ; support only memory argument

        pushad
        pushfd

        lea eax, numb_to_print
        sub esp, 10
        mov ecx, [eax]
        mov [esp], ecx
        mov edx, [eax+4]
        mov [esp+4], edx
        mov bx, [eax+8]
        mov [esp+8], bx
        push offset L_fmt_str_macros_for_float
        call crt_printf
        add esp, 4+10

        popfd
        popad
    endif
endm

;al ждёт
OUTBIN_byte MACRO
    LOCAL loop_start, skip_bit  ; Уникальные метки для всего макроса
    mov esi, offset byte_sample ; Адрес буфера
    mov ecx, 8                  ; 8 бит для обработки

    loop_start:
        mov dl, '0'             ; По умолчанию '0'
        rcl al, 1              ; Сдвигаем бит в CF
        jnc skip_bit            ; Если CF=0, пропускаем установку '1'
        mov dl, '1'
    skip_bit:
        mov [esi], dl           ; Записываем символ в буфер
        inc esi                 ; Следующая позиция
        loop loop_start         ; Повторяем 8 раз

    outstr offset byte_sample  ; Вывод
ENDM

; al ждёт
OUTHEX_byte macro
    mov edx, 0

    mov dl, al
    and dl, 00001111b
    lea esi, numbers
    add esi, edx
    mov dl, [esi]
    mov [byte_hex_sample+1], dl

    mov dl, al
    shr dl, 4
    lea esi, numbers
    add esi, edx
    mov dl, [esi]
    mov [byte_hex_sample], dl

    outstr offset byte_hex_sample
    
endm

;; вывод регистра
outhex equ OUTHEX
outh equ OUTHEX

OUTHEX macro numb_to_print:req
    local size_to_print, otstup
    size_to_print = type numb_to_print
    otstup = 0

    push eax
    push esi
    push edx
    pushfd

    if (((opattr numb_to_print) and 00010000y) eq 00010000y)
            if type numb_to_print eq 4
                ifdifi <numb_to_print>, <eax>
                    mov eax,numb_to_print
                endif 
            else
                ifdifi <numb_to_print>, <ax>
                    ifdifi <numb_to_print>, <al>
                        movzx eax, numb_to_print
                    endif
                endif 
            endif
            if type numb_to_print ne 1
                rol eax, (5-type numb_to_print )*8
            endif
            repeat type numb_to_print
                OUTHEX_byte
                rol eax, 8
            endm
    endif

    if (((opattr numb_to_print) and 00000010y) eq 00000010y)
        while size_to_print ne 0
            size_to_print = size_to_print-1
            mov esi, size_to_print
            add esi, offset numb_to_print
            mov al, [esi]
            OUTHEX_byte
        endm
    endif


;;    .err <'invalid type &numb_to_print'>
    popfd
    pop edx
    pop esi
    pop eax
endm

outbin equ OUTBIN
outb equ OUTBIN
OUTBIN macro numb_to_print:req
    local size_to_print, otstup
    size_to_print = type numb_to_print
    otstup = 0

    push eax
    push esi
    push edx
    push ecx
    pushfd

    if (((opattr numb_to_print) and 00010000y) eq 00010000y)
            if type numb_to_print eq 4
                ifdifi <numb_to_print>, <eax>
                    mov eax,numb_to_print
                endif 
            else
                ifdifi <numb_to_print>, <ax>
                    ifdifi <numb_to_print>, <al>
                        movzx eax, numb_to_print
                    endif
                endif 
            endif
            if type numb_to_print ne 1
                rol eax, (5 - type numb_to_print)*8
            endif
            repeat type numb_to_print
                OUTBIN_byte
                rol eax, 8
            endm
    endif

    if (((opattr numb_to_print) and 00000010y) eq 00000010y)
        while size_to_print ne 0
            size_to_print = size_to_print-1
            mov esi, size_to_print
            add esi, offset numb_to_print
            mov al, [esi]
            OUTBIN_byte
        endm
    endif


;;    .err <'invalid type &numb_to_print'>
    popfd
    pop ecx
    pop edx
    pop esi
    pop eax
endm

outflags macro
    local zsf, zzf, zof, zcf

    push eax
    push ebx
    pushfd

    outstr 'SF = ', 0
    mov bl, '0'
    jns zsf
        mov bl, '1'
    zsf:
    outchar bl
    newline

    outstr 'ZF = ', 0
    mov bl, '0'
    jnz zzf
        mov bl, '1'
    zzf:
    outchar bl
    newline

    outstr 'OF = ', 0
    mov bl, '0'
    jno zof
        mov bl, '1'
    zof:
    outchar bl
    newline

    outstr 'CF = ', 0
    mov bl, '0'
    jnc zcf
        mov bl, '1'
    zcf:
    outchar bl
    newline

    popfd
    pop ebx
    pop eax
endm