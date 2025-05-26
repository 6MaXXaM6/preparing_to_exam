uses 
    mod_init_pas;

{
type
    vec_3d_t = record
        x,y,z :longint
    end;
}

var
    arr :array of vec_3d_t;

    i: integer;

begin
    RandSeed:=100500;
    
    setlength(arr,10);
    
    arr[1].y := 55;

   init_array_pas(arr,10);
   
    for i:=0 to 10-1 do
    begin
        //init_vec(arr[i]);
        writeln(i,': x=', arr[i].x, ' y=', arr[i].y, ' z=', arr[i].z);
    end;
end.


