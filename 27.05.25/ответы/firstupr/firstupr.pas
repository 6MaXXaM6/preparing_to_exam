program main;
{$L module.obj} // имя объектного файла с функцией

type
    ar = array [1..10] of integer; // 16 битные знаковые числа
var
    my_array : ar;
    i: integer;


function howmanyotr(var x: ar):word; stdcall ;external name '_howmanyotr@4';

// function howmanyotr(var x: ar):word;
// var
//     i: integer;
// begin
//     howmanyotr := 0;

//     for i := 1 to 10 do
//     begin
//         if (x[i] < 0) then
//             howmanyotr := howmanyotr + 1
//     end;
// end;

begin
    for i := 1 to 10 do
    begin
        read(my_array[i])
    end;


    writeln(howmanyotr(my_array));

    for i := 1 to 10 do
    begin
        write(my_array[i], ' ')
    end;
end.