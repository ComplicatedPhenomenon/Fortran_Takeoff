PROGRAM kindCheck
  IMPLICIT NONE

  INTEGER     :: i
  REAL        :: r
  COMPLEX     :: cp
  CHARACTER   :: c
  LOGICAL     :: lg
  !***********************************************************
  !syntax SELECTED_REAL_KIND(P, R, RADIXI)I
  !A real data type with decimal precision at least P digits
  !a deciaml exponent range of at least R
  !and with the requested RADIX
  !***********************************************************

  INTEGER, PARAMETER :: p6 = SELECTED_REAL_KIND(6)
  INTEGER, PARAMETER :: p10r100 = SELECTED_REAL_KIND(10,100)
  INTEGER, PARAMETER :: r400 = SELECTED_REAL_KIND(r=400)
  REAL(kind=p6)      :: x
  REAL(kind=p10r100) :: y
  REAL(kind=r400)    :: z

  WRITE(*,*)"________________________________________________"
  PRINT *,'The default kind of different data type '
  PRINT *,'Real     ', KIND(r)
  PRINT *,'Complex  ', KIND(cp)
  PRINT *,'Character', KIND(c)
  PRINT *,'Logical  ', KIND(lg)
  WRITE(*,*)"________________________________________________"
  PRINT *, "precision & range ",PRECISION(x),RANGE(x)
  PRINT *, "precision & range ",PRECISION(y),RANGE(y)
  PRINT *, "precision & range ",PRECISION(z),RANGE(z)
  WRITE(*,*)"________________________________________________"
  PRINT *,41_p6
END PROGRAM kindCheck
