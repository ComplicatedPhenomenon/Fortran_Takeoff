MODULE omp_subs
  IMPLICIT NONE
CONTAINS
  FUNCTION calc_pi(n) RESULT(pi)
    IMPLICIT NONE
    INTEGER(8) :: accept
    REAL(8) :: r(2), pi
    INTEGER(8), INTENT(in) :: n
    INTEGER(8) :: i

    accept = 0

    !$omp parallel do private(r,i) reduction(+:accept)
    DO i = 1, n
       CALL RANDOM_NUMBER(r)
       IF (r(1)**2 + r(2)**2 <= 1) THEN
          accept = accept + 1
       END IF
    END DO
    !$omp end parallel do

    pi = 4.0d0 * DBLE(accept)/DBLE(n)

  END FUNCTION calc_pi

END MODULE omp_subs

PROGRAM main
    USE omp_subs
    IMPLICIT NONE

    INTEGER(8) :: n
    REAL(8), PARAMETER :: pi = 2.0d0*dacos(0.0d0)
    REAL(8) :: mypi
    CHARACTER (len=64) :: arg

    CALL RANDOM_SEED()

    IF (command_argument_count() /= 1) THEN
        error STOP "One command line argument should be passed, which is the number of iterations to perform."
    END IF

    CALL get_command_argument(1, arg)
    READ(arg,*) n

    mypi = calc_pi(n)

    WRITE(*,'(a,f12.6)') "Calculated = ", mypi
    WRITE(*,'(a,f12.6)') "Actual =     ", pi

END PROGRAM main
