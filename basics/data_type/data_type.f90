PROGRAM testingInt
  IMPLICIT NONE

  REAL(4) :: shortval
  REAL(8) :: longval
  REAL :: defval
  INTEGER :: i
  !===============================================================!
  ! print out 2**127 always get the error "Arithematica overflow  !
  ! I know in Fortran the LHS is evaluated before assigning to the!
  ! RHS. so `real(kind=8) :: var = 2d0**127d0`is invalid          !
  !===============================================================!

  INTEGER, PARAMETER :: dp1 = KIND(1.)
  INTEGER, PARAMETER :: dp2 = KIND(0.0d0)
  REAL(kind = 4) :: mantissa1
  REAL(kind = 8) :: mantissa2

  mantissa1 = 0d0
  mantissa2 = 0d0

  DO i = 0, 23
     mantissa1 = mantissa1 + 1./(2 ** i)
  END DO


  DO i = 0, 52
     mantissa2 = mantissa2 + 1d0/(2d0 ** i)
  END DO

  WRITE (*,*) 2d2,2e2, 2d2-2e2
  WRITE(*,*)"------------------------------------------------------------------------------"
  PRINT *,"KIND(1.)=",KIND(1.)
  PRINT *,"kind(1d0)= ",KIND(1d0)
  PRINT *,"kind of real = ",KIND(defval)
  WRITE(*,*)"------------------------------------------------------------------------------"
  WRITE(*,*)"Ranges of floating point datatypei with kind = 4 in Fortran"
  PRINT *,"The lagest number : mantissa1 * 2d0 ** 127_dp1 = ",mantissa1 * 2d0 ** 127.
  PRINT *,"The smallest numer: mantissa1 * 2d0 ** 127_dp1 = ",mantissa1 * 2d0 ** (-127.)

  WRITE(*,*)"------------------------------------------------------------------------------"
  WRITE(*,*)"Ranges of floating point datatypei with kind = 8 in Fortran"
  PRINT *,"The lagest number : mantissa2 * 2d0 ** 1023_dp2 = ",mantissa2 * 2d0 ** 1023_dp2
  PRINT *,"The smallest numer: mantissa2 * 2d0 ** 1023_dp2 = ",mantissa2 * 2d0 ** (-1023_dp2)

  WRITE(*,*)"------------------------------------------------------------------------------"
  WRITE(*,*)"Fetch the parameters by intrinsic functions"
  PRINT *,"The largest number of real with kind=4 is  :",HUGE(shortval)
  PRINT *,"The tinest number of real with kind=4 is  : ",TINY(shortval)
  PRINT *,"The largest number of real with kind=8 is  :",HUGE(longval)
  PRINT *,"The tinest number of real with kind=8 is  :",TINY(longval)
  PRINT *,"The largest number of real with default kind is :",HUGE(defval)
  WRITE(*,*)"------------------------------------------------------------------------------"
END PROGRAM testingInt
