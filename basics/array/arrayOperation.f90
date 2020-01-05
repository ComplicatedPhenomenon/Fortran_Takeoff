module test_mod
    use, intrinsic :: iso_fortran_env, only: i1 => int8, i2 => int16, i4 => int32, &
                                           r4 => real32
    implicit none
contains
    elemental function square(x) result(res)
        implicit none 
        real(r4), intent(in) :: x
        real(r4) :: res
        res = x*x
    end function
end module

program functional_test
    use test_mod

    implicit none
    real(r4), dimension(3) :: x = (/ 1.0, 2.0, 3.0 /)
    real(r4), dimension(3) :: y = [1.0, 2.0, 3.0]
    character(len = 30) :: s = "ComplicatedPhenomenon"
    integer(i4) :: c(3,3)= reshape([0,3,2,4,3,2,5,1,2], shape(c))
    integer(i4) :: cc(8)=-1

    !print *, x(1:3)(1)
    print *, square(x)
    print *, square(y)
    print *, y(2:)
    print *, s(1:)


    write(*,'(3i3)') c        ! writes 0 3 2
                             !        4 3 2
                             !        5 1 2
    write(*,*) pack(c,mask=(c > 2))
                             ! writes 3 4 3 5
    write(*,*) pack(c,mask=(c > 2),vector=cc)
                             ! writes 3 4 3 5 -1 -1 -1 -1 -1
    write(*,*) pack(c,.true.) ! writes 0 3 2 4 3 2 5 1 2

end program functional_test
