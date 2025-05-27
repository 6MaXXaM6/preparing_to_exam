{$ASMMODE intel}

var 
    c :longint;

function sum(a, b :longint) :int64;
var
    ttt :longint=0;

begin
    {sum := c + a + b + ttt; }
    asm
        mov esi, 0
        mov edi, 0
        
        mov eax, c
        cdq
        add esi, eax
        adc edi, edx

        mov eax, a
        cdq
        add esi, eax
        adc edi, edx

        mov eax, b
        cdq
        add esi, eax
        adc edi, edx

        mov eax, ttt
        cdq
        add esi, eax
        adc edi, edx

        mov eax, esi
        mov edx, edi
    end ['esi', 'edi']; {мы их использовали}
end;

begin
    c := -100;
    writeln(sum(42, 8));
end.


