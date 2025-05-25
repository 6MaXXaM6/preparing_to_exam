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
    ; решение пункта а


    ; вывод
    outstrln 'Time: ', 0
    outu T1.H
    outchar ':'  
    outu T1.M
    outchar ':'  
    outu T1.S
    newline

    exit
end start