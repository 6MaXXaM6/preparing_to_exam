include console.inc
public criminal, kill_bad_people


.data
    criminal db 0
    extrn N:byte

.code

kill_bad_people proc public
    push ebp
    mov ebp, esp
    outu N
    outstrln ' bad people has die'
    pop ebp
    ret
kill_bad_people endp
end
