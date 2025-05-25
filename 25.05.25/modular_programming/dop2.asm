;прикол этого файла что тут не будет указываться соглашение)
.NOLISTMACRO

.686
.XMM
.model flat
option casemap:none

public _next_day ; как угодно можно в public
.data
    extrn _happy:byte
    extrn _criminal:byte; обратите внимание что из dop1 стоит

.code

_next_day proc
    push ebp
    mov ebp, esp
    extrn _Start:near; Метка старт - публичная) near proc - обозначение метки не более как вы поняли процедуры функции - метки так они и показываются в nm
    
    ; работаем с тем что передали
    mov al, _happy
    not al
    mov ah, _criminal
    xor ah, al
    mov _happy, al
    mov _criminal, ah

    mov [ebp+4], offset _Start ; поменяли куда возвращаемся чтобы зациклить

    pop ebp
    ret
_next_day endp

end