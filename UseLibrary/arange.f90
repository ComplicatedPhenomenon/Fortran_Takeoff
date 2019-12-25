program test_arange
    use iso_fortran_env, only: i1 => int8
    implicit none
    integer(i1), dimension(:), allocatable :: res
    integer(i1), dimension(:), allocatable :: rev
    res = arange(1_i1, 10_i1, 3_i1)
    print *, res 
    rev = reverse(res)
    print *, rev
    deallocate(res)
    deallocate(rev)
    res = arange(5_i1, 10_i1)
    print *, res 
    deallocate(res)

    contains
    pure function arange(start, end, step) result(res)
        use iso_fortran_env, only: i1 => int8
        implicit none
        integer(i1), intent(in) :: start, end
        integer(i1), intent(in), optional:: step
        integer(i1) :: increment, len
        integer(i1) :: i
        integer(i1), dimension(:), allocatable :: res

        if (present(step)) then 
            increment = step 
        else 
            increment = 1_i1
        end if 
        len = (end - start) / increment + 1_i1
        allocate(res(len))
        do i = 1, len 
            res(i) = start + increment * (i -1_i1)
        end do 
    end function arange

    pure function reverse(x) result(rev)
        implicit none
        integer(i1), dimension(:), intent(in) :: x 
        integer(i1), dimension(size(x)) :: rev
        rev= x(size(x):1:-1)
    end function reverse


end program test_arange
    
