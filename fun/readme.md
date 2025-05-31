## Для любимой одногруппницы (нет), Я ШУТНИК и да это пример свзяки fortran 77 и masm

для виртуалки следует установить кросскомпилятор для фортрана для бубунту:
 sudo apt install gfortran-mingw-w64
или установить на wine я уверен вы люди умные мне западло
 скомпилировать

- i686-w64-mingw32-gfortran -c main.f -o main.obj
- wine ml /c /coff  module.asm 
- i686-w64-mingw32-gfortran -static main.obj module.obj -o program.exe

если устанавливали через wine очевидно static лишнее

- wine ./program.exe