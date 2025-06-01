include console.inc

.data
    N = 16
    S DB '  help please   '
    X DB 5 dup(?)

    forc i, <0123456789>
        b&i db i
        w&i dw i*2
        d&i dd i*10
    endm

.code

ONES macro v:req
    local L
    mov al, 0
    mov ecx, 8*type v
    L:
        rol v, 1
        adc al, 0
        loop L
endm 

ZEROS macro v:req
    local L
    mov bl, 0
    mov ecx, 8*type v
    L:
        rol v, 1
        sbb bl, -1
        loop L
endm

SUM macro Xo:req
    local L
    mov ecx, length Xo
    mov eax, 0
    L:  
        movsx edx, byte ptr Xo[ecx-1] 
        add eax, edx
        loop L
endm

Print1 macro X
    local byte_exist
    byte_exist = 0

    for op, <X>
        if ((type op) eq 1)
            if byte_exist eq 0
                byte_exist = 1
                push eax
            endif
            movsx eax, op
            outi eax
            outchar ' '
        endif
    endm
    if byte_exist
        pop eax
    endif
endm

; вспомогательный макрос
MMmaximum macro X, Y, reg
    local Q
    ifdifi <X>, <reg>
        push eax
        mov reg, X
    endif
    cmp reg, Y
    jge Q
        xchg reg, Y
        ifdifi <X>, <reg>
            mov X, reg
        endif
    Q:
    ifdifi <X>, <reg>
        pop eax
    endif
endm

Maximum macro X:req, Y:req
; проверка условий
    if type X ne type Y
        .err <Error non identical size>
    endif
    if (type X eq 1)
        MMmaximum X, Y, al
    elseif (type X eq 2)
        MMmaximum X, Y, ax
    else
        .err <Error invalid size>
    endif
endm


JDIF macro LN, M
    local opm
    opm = 0
    for op, <LN>
        if (op lt 0)
            opm = opm + 1
            cmp ax, op
            je M
        endif
    endm
    if (opm eq 0)
        jmp M
    endif
endm


start:
; прикол этих штук в 5 инструкций не уложить если ecx не трогать)
    mov bl, 10000001b
    ONES bl
    outu al

    newline

    mov al, 10000001b
    ZEROS al
    outu bl
    newline

    forc i, <01234>
        mov X[&i&], i&*2
    endm


    SUM X
    outi eax
    newline

    Print1 <d1,d2,d4,d2,w2,d2,d2>

    outi w2
    newline
    outi w5
    newline


    Maximum w2, w5

    outi w2
    newline
    outi w5
    newline

    mov ax, -50

    JDIF <5, 7, 8,5,6,1,7,50,-50>, goodL
    outstrln 'JDIF not work', 0
    retL:
    
    
    exit
    goodL:
    outstrln 'JDIF work', 0
    jmp retL
    ; последнее пофиг я не шарю а как пробел выделить разбираться бессмысленно на экзамене нее будет в эизни не пригодится
    
end start