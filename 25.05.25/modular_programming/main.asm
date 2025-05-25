include console.inc
include helpful.inc
public author, happy, N

.data
    author db '6MaXXaM6', 0
    happy db 00h ; булево
    extrn criminal:byte
.const
    N db 10

.code

Start:
    outstr offset author
    outstrln ', Wake the fuck up, Samurai! We have a City to burn! ', 0
    cmp criminal, 0
    jne @F
        outstrln 'BORING!! ', 0
        jmp next
    @@:
    extrn kill_bad_people@0:proc ; мы используем stdcall (он прописан в console.inc) в обоих модулях необходимо это учитывать нижнее подчёркивание выставится автоматически  
    call kill_bad_people@0
    next:
    outstr offset author
    outstrln ', You want to sleep, please write 1 to sleep', 0
    inint eax

    extrn next_day:proc
    cmp eax, 1
    jne @F
        call next_day
    @@:
    exit
end Start
