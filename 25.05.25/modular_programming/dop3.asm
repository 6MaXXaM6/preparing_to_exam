; рассмотреть различные соглашения и внешние имена
;прикол этого файла что тут не будет указываться соглашение)
.NOLIST
.NOLISTMACRO

.686
.XMM

.model flat, c
; pascal (всё будет капсом), с -cdecl(процедуры отдаются без @ нижнее подчёркивание), stdcall 
option casemap:none
; public next_day ; как угодно можно в public

.data
    extrn happy:byte
    extrn criminal:byte; обратите внимание что из dop1 стоит

.code

next_day proc public
    push ebp
    mov ebp, esp
    extrn Start:near; Метка старт - публичная) near proc - обозначение метки не более как вы поняли процедуры функции - метки так они и показываются в nm
    
    ; работаем с тем что передали
    mov al, happy
    not al
    mov ah, criminal
    xor ah, al
    mov happy, al
    mov criminal, ah

    lea eax, Start
    mov [ebp+4], eax ; поменяли куда возвращаемся чтобы зациклить

    pop ebp
    ret
next_day endp
Main:

end Main