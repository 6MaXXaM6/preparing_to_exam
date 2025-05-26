include console.inc
TIME STRUC ; время какого–то момента суток
    H DB ? ; час (от 0 до 23)
    M DB ? ; минута (от 0 до 59)
    S DB ? ; секунда (от 0 до 59)
TIME ENDS

.data?
    T1 TIME <0,0,0>

.code
start:
    ; решение пункта а 17250
    mov T1.H, 17
    mov T1.M, 25
    mov T1.S, 0

    ; вывод
    outstrln 'Time: '/home/maksimkh/opt/prac_examples/easy_masm_32/preparingexam/7.2.asm, 0
    outu T1.H
    outchar ':'  
    outu T1.M
    outchar ':'  
    outu T1.S
    newline

    exit
end start