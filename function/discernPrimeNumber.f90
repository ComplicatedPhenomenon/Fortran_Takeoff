!  Task
!  1. if you define the input as int, then it should has a range
!  2.  make a data structure to store  denumerator which makes `flag = 1`.
!

PROGRAM discernPrimeNum
  IMPLICIT NONE
  INTEGER :: input
  INTEGER :: i, flag = 0
  READ (*,*) input
  DO i = 2, INT(input/2)
     IF (MOD(input,i) == 0) THEN
        flag = 1
     END IF
     EXIT
  END DO
  IF (flag == 0) THEN
     PRINT *, input, "is a prime numbe"
  ELSE
     PRINT *, input, "is a composite number"
  END IF

END PROGRAM discernPrimeNum
