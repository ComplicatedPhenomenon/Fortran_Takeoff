MODULE coarray_subs

  IMPLICIT NONE

CONTAINS

  FUNCTION calc_pi(n) RESULT(pi)

    USE opencoarrays, ONLY: co_sum

    IMPLICIT NONE
    INTEGER(8), SAVE, codimension[*] :: accept
    REAL(8) :: r(2), pi
    INTEGER(8), INTENT(in) :: n
    INTEGER(8) :: i

    accept = 0

    DO i = this_image(), n, num_images()
       CALL RANDOM_NUMBER(r)
       IF (r(1)**2 + r(2)**2 <= 1) THEN
          accept = accept + 1
       END IF
    END DO

    sync all

    CALL co_sum(accept, 1)
    pi = 4.0d0 * DBLE(accept)/DBLE(n)

  END FUNCTION calc_pi

END MODULE coarray_subs

PROGRAM main

    USE coarray_subs

    IMPLICIT NONE
    REAL(8), PARAMETER :: pi = 2.0d0*dacos(0.0d0)
    INTEGER(8) ::  n
    CHARACTER (len=64) :: arg
    REAL(8) :: T1, T2, mypi

    CALL RANDOM_SEED()

    critical

    IF (command_argument_count() /= 1 .AND. this_image() == 1) THEN
        error STOP "One command line argument should be passed, which is the number of iterations to perform."
    END IF

    CALL get_command_argument(1, arg)
    call cpu_time(T1)
    READ(arg,*) n

    END critical

    mypi = calc_pi(n)
    call cpu_time(T2)
    IF (this_image() == 1) THEN
        WRITE(*,'(a,f12.6)') "Calculated = ", mypi
        WRITE(*,'(a,f12.6)') "Actual =     ", pi
    END IF
    print *, 'The time usage is:',  T2-T1
END PROGRAM main
