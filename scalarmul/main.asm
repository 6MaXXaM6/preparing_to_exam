include console.inc

xmm0 equ XMM0
xmm1 equ XMM1
xmm2 equ XMM2
xmm3 equ XMM3
xmm4 equ XMM4
xmm5 equ XMM5
xmm6 equ XMM6
xmm7 equ XMM7

extern scalar_mul@0: proc

.code
        L_fmt_str_macros_for_float db "%f", 0
        L_fmt_str_macros_for_tenbyte_float db "%lf", 0

outfloat equ OUTFLOAT
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


.data
    align 16
    arr_a real4 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.11

    align 16
    arr_b real4 0.1, 0.2, 0.3, 0.4, 0.5, -0.6, -0.7, -0.8, -0.9, 0.11
    
    my_r real4 0.748



.code
start:
    push 10
    push offset arr_b
    push offset arr_a
    call scalar_mul@0

    sub esp, 4
    fstp dword ptr [esp]
    mov edx, [esp]
    ;OUTWORDLN edx

    OUTFLOAT edx

    add esp, 4

    newline

    mov edx, my_r   
    OUTFLOAT edx

    newline
 
    EXIT 0

end start

