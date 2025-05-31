      PROGRAM MAIN
      INTEGER N
      PARAMETER (N = 5)
      INTEGER ARRAY(N)
      REAL AVG_VALUE
      REAL AVERAGE  ! Объявляем тип функции
      EXTERNAL AVERAGE  ! Указываем, что это внешняя функция
      
C Заполнение массива данными
      DATA ARRAY /10, 20, 30, 40, 50/
      
C Вызов функции среднего
      AVG_VALUE = AVERAGE(ARRAY, N)
      
C Вывод результата
      PRINT *, 'Array:'
      PRINT *, (ARRAY(I), I=1,N)
      PRINT *, 'Average: ', AVG_VALUE
      
      END