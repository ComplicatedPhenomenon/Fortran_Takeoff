PROGRAM outputdata
  IMPLICIT NONE

  REAL, DIMENSION(100) :: x, y
  INTEGER              :: i
  CHARACTER (len=200)  :: text
  CHARACTER (len=10)   :: postfix
  postfix = '.txt'
  text = 'WANGMIAO, I HOPE U CAN UNDERSTAND, THE SPACE IS VERY LIMITED, SO U NeeD TO BE MAKE GOOD USE OF IT'
  OPEN(9, file = 'secrets'//postfix, status = 'new')

  WRITE (9,*) text
  CLOSE(9)

  DO i = 1, 100
     x(i) = 0.1 * i
     y(i) = SIN(x(i))
  END DO

  !output data into a file
  OPEN(1, file = 'data1.dat',status = 'new')
  DO i = 1, 100
     WRITE (1,*) x(i), y(i)
  END DO

  CLOSE(1)

END PROGRAM outputdata
