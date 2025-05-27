.686P
.XMM
.model flat; соглашение не указываем чтобы лишний раз не думать что сделает masm 

.data
    z4 real4 6.8

.code
; в паскале хранится 16 битныъ целых числах поэтому при складывании до 101 элемента переполнений заведомо не будет в 32 битном регистре
; // среднее арифметическое stdcall
; function srartrstdcall(var x: ar; N:word):real; stdcall; external name '_srartrstdcall@8';
; // среднее арифметическое cdecl
; function srartrcdecl(var x: ar; N:word):real; cdecl; external name '_srartrcdecl';
; // среднее арифметическое pascal
; function srartrpascal(var x: ar; N:word):real; pascal; external name 'SRATRPASCAL';
; // среднее арифметическое register
; function srartrregister(var x: ar; N:word):real; register; external name 'srartrregister';

; мы ждём гениальный код заодно вспомнить cvtsi2ss напомню возврат в fld
end