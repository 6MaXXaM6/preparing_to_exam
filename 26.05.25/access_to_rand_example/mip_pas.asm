.686
.model flat

    .code 
extern SYSTEM_$$_RANDOM$LONGINT$$LONGINT:near; уебанское fpc соглашение по названиям
public iniar
public init_vec
    .code


iniar proc
    	push ebp
    	mov	 ebp, esp
        
        push eax
        push ebx
        push ecx
        push edx
        push edi
        push esi
       
        ; array pointer save to edi
        mov  edi, [ebp +  8]

       
        ;
        ; ecx now loop counter
        ;        
        mov  ecx, 0
array_loop_cond:
        cmp  ecx, [ebp + 12] ; cmp with array length
        ja  array_loop_finish
        
        ;
        ; pointer to element
        ; size of record 12        
        mov eax, 12
        mul ecx
        mov esi, eax

        push ecx
        ;
        ; arr[i].x := random(1024);
        ;        
    	mov	 eax, 1024
        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
        mov  dword ptr [edi+esi+0], eax

        ;
        ; arr[i].y := random(1024);
        ;        
    	mov	 eax, 1024
        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
        mov  [edi+esi+4], eax

        ;
        ; arr[i].z := random(1024);
        ;        
    	mov	 eax, 1024
        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
        mov  [edi+esi+8], eax
 
        pop ecx
       
        ;
        ; movement to next iteration
        ;

        inc ecx
        jmp array_loop_cond
array_loop_finish:

        pop esi
        pop edi
        pop edx
        pop ecx
        pop ebx
        pop eax
        pop ebp
        
        ret 8

iniar endp

init_vec proc
        push ebp
        mov  ebp, esp
        push ebx

        mov ebx, [ebp+8]
        
    	
        mov	 eax, 1024
        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
        mov [ebx+0], eax
 
        mov	 eax, 1024
        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
        mov [ebx+4], eax
                
        mov	 eax, 1024
        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
        mov [ebx+8], eax
       
        pop ebx
        pop ebp
        ret 4
init_vec endp

end
