unit mod_init_pas;

interface
    type
        vec_3d_t = record
                     x,y,z :longint
                   end;
(*
procedure init_array_pas(var arr :array of vec_3d_t; len :longword); stdcall;
procedure init_vec(var  vec :vec_3d_t); stdcall; 
*)

{$L ./mip_pas.obj}
procedure init_array_pas(var arr :array of vec_3d_t; len :longword); stdcall; external name 'iniar';
procedure init_vec(var  vec :vec_3d_t); stdcall; external name 'init_vec';


implementation

(*
procedure init_vec(var  vec :vec_3d_t); pascal;
begin
    vec.x := random(1024);
    vec.y := random(1024);
    vec.z := random(1024);
end;


procedure init_array_pas(var arr :array of vec_3d_t; len :longword); pascal;
var
    i: longword; 
begin
    for i:=0 to len-1 do
    begin
        arr[i].x := random(1024);
        arr[i].y := random(1024);
        arr[i].z := random(1024);
    end
end;
*)

begin
end.

