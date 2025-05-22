

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