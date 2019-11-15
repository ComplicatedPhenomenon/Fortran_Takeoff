MODULE ran001
  IMPLICIT NONE
  SAVE

  INTEGER :: n= 9876
END MODULE ran001

SUBROUTINE random0(ran)
  USE ran001
  IMPLICIT NONE

  REAL,INTENT (out) :: ran
  n = MOD (8121 * n + 28411,134456)
  ran = REAL (n) / 134456.
END SUBROUTINE random0


SUBROUTINE seed (iseed)
  USE ran001
IMPLICIT NONE

INTEGER, INTENT (in) :: iseed
  n = ABS (iseed)
END SUBROUTINE


PROGRAM test_random0
  IMPLICIT NONE
  REAL    :: ave
  INTEGER :: i
  INTEGER :: iseed
  INTEGER :: iseq
  REAL    :: ran
  REAL    :: sum

  WRITE (*,*) 'Enter seed: '
  READ (*,*) iseed

  CALL seed(iseed)
  WRITE (*,*) '10 random numbers '
  DO i = 1, 10
    CALL random0(ran)
    WRITE (*,'(3X,F16.6)') ran
  END DO
  WRITE (*,*) 'Average of 5 consecutive 1000-sample sequence'
  DO iseq = 1, 5
    sum = 0.
    DO i = 1, 1000
      CALL random0(ran)
      sum = sum + ran
    END DO
    ave = sum / 1000.
    WRITE (*,'(3X, F16.6)') ave
  END DO
END PROGRAM test_random0
