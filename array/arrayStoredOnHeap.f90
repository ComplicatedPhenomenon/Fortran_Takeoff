PROGRAM arraymem
  IMPLICIT NONE
  CALL meanArray(8000000)

CONTAINS

  SUBROUTINE meanArray(n)
    INTEGER, INTENT(in) :: n
    INTEGER, DIMENSION(n) :: a, b
    a = 12
    print *, LOC(a)
    print *, LOC(a(1))
    print *, LOC(a(2))
    print *, LOC(a(3))
    b = 255
    a = (a + b) / 2
    PRINT *, SUM(a)
  END SUBROUTINE meanArray

END PROGRAM arraymem
