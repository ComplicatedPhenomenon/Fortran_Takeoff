module serial_subs

    implicit none

contains

    function calc_pi(n) result(pi)

        implicit none
        integer(8) :: accept
        real(8) :: r(2), pi
        integer(8), intent(in) :: n
        integer(8) :: i

        accept = 0

        do i = 1, n
            call random_number(r)
            if (r(1)**2 + r(2)**2 <= 1) then
                accept = accept + 1
            end if
        end do

        pi = 4.0d0 * dble(accept)/dble(n) ! dble(a) converts a to double precision real type.  Pi/4 parts of a sphere circle

    end function calc_pi

end module serial_subs

program main

    use serial_subs

    implicit none
    integer(8) :: n
    real(8), parameter :: pi = 2.0d0*dacos(0.0d0)
    character (len=64) :: arg
    real(8) :: T1, T2, mypi
    ! 'How many samples you would like to take?'
    ! Usage of this program should be declare.
    call random_seed()

    if (command_argument_count() /= 1) then
        error stop "One command line argument should be passed, which is the number of iterations to perform."
    end if

    call get_command_argument(1, arg)
    read(arg,*) n
    call cpu_time(T1)
    mypi = calc_pi(n)
    call cpu_time(T2)
    write(*,'(a,f12.6)') "Calculated π = ", mypi
    write(*,'(a,f12.6)') "Actual π =     ", pi
    print *, 'The time usage is:',  T2-T1

end program main
