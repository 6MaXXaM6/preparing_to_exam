#.686
#.model flat
#
#    .code 
#extern SYSTEM_$$_RANDOM$LONGINT$$LONGINT:near
#public iniar
#public init_vec
#    .code
    .text

#.type iniar, @func
.global iniar
iniar:
    	push %ebp
    	mov	 %esp, %ebp
        
        push %edi
        push %esi
        push %ecx
        push %edx
        push %eax
        push %ebx
        
        # array pointer save to edi
        mov   8(%ebp),  %edi
        mov   12(%ebp), %esi

        #
        # skip array length position
        #
        add  $4, %edi 
       
        #
        # ecx now loop counter
        #        
        mov $0, %ecx
array_loop_cond:
        cmp  %esi, %ecx
        ja  array_loop_finish
        
        #
        # pointer to element
        # size of record 12        
        mov $12, %eax
        mul %ecx
        mov %eax, %ebx      

        #
        # arr[i].x := random(1024);
        #        
    	mov	$1024, %eax
        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
        mov  %eax, (%edi,%ebx,1)

        #
        # arr[i].y := random(1024);
        #        
    	mov	 $1024, %eax
        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
        mov  %eax, 4(%edi,%ebx,1)

        #
        # arr[i].z := random(1024);
        #        
    	mov	 $1024, %eax
        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
        mov  %eax, 8(%edi,%ebx,1)
        
        #
        # movement to next iteration
        #
        inc %ecx
        jmp array_loop_cond
array_loop_finish:

        pop %ebx
        pop %eax
        pop %edx
        pop %ecx
        pop %esi
        pop %edi
        pop %ebp
        
        ret $8

.global init_vec
#.type init_vec, @function
init_vec:
        push %ebp
        mov  %esp, %ebp
        push %ebx

#        mov ebx, [ebp+8]
#        
#    	
#        mov	 eax, 1024
#        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
#        mov [ebx+0], eax
# 
#        mov	 eax, 1024
#        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
#        mov [ebx+4], eax
#                
#        mov	 eax, 1024
#        call SYSTEM_$$_RANDOM$LONGINT$$LONGINT
#        mov [ebx+8], eax
       
        pop %ebx
        pop %ebp
        ret $4


