program main;
{$L module.obj}
//в одну строку для линукса
//wine ml /c /coff /Fl /I"Z:\opt\masm-32\include" module.asm; wine fpc secondupr.pas; wine ./secondupr.exe 
type
    ar = array of word; // 16 битные беззнаковые числа
var
    my_array : ar;
    N: word;
    i: integer;


// среднее арифметическое
function srartr(var x: ar; N:word):real;
var
    i: integer;
begin
    srartr:=0;
    for i :=0 to N do
        srartr:=srartr+x[i];
    srartr:=srartr/N;
end;

// среднее арифметическое stdcall
function srartrstdcall(var x: ar; N:word):real; stdcall; external name '_srartrstdcall@8';
// среднее арифметическое cdecl
function srartrcdecl(var x: ar; N:word):real; cdecl; external; // name 'srartrcdecl'; // нижнее подчёркивание прёт само причём неважно указать ли name илинет
// // среднее арифметическое pascal
function srartrpascal(var x: ar; N:word):real; pascal; external name 'SRATRPASCAL';
// // среднее арифметическое register
function srartrregister(var x: ar; N:word):real; register; external name 'srartrregister';



begin
    Randomize;
    N := random(100)+1;
    setlength(my_array, N);

    writeln(length(my_array));

    for i := 0 to N-1 do
    begin
        my_array[i] := random(100)
    end;

    for i := 0 to N-1 do
    begin
        write(my_array[i], ' ')
    end;

    writeln;

    writeln(srartr(my_array, N));

    writeln(srartrstdcall(my_array, N));

    writeln(srartrcdecl(my_array, N));

    writeln(srartrpascal(my_array, N));

    writeln(srartrregister(my_array, N));

    for i := 0 to N-1 do
    begin
        write(my_array[i], ' ')
    end;

end.