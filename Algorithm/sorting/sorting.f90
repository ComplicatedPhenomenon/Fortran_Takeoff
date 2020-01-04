module sorting 
    use iso_fortran_env, only:i1 => int8, i2 => int16, i4 => int32, i8 => int64
    implicit none
contains
    subroutine bubbleSort(inputArray, size)
        implicit none
        integer :: size
        integer, dimension(size) :: inputArray
        integer :: i, j, tem
        i = size
        do while (i > 1)
            do j = 1, i - 1 
                if (inputArray(j) > inputArray(j + 1)) then
                    tem = inputArray(j)
                    inputArray(j) = inputArray(j + 1)
                    inputArray(j + 1) = tem
                end if 
            end do
            i = i - 1
        end do 
    end subroutine bubbleSort

    subroutine selectSort(inputArray, size) 
        implicit none
        integer :: size
        integer, dimension(size) :: inputArray
        integer :: i, j, tem
        

        do i = 1, size - 1
            do j = i + 1, size
                if (inputArray(i) > inputArray(j)) then
                    tem = inputArray(i)
                    inputArray(i) = inputArray(j)
                    inputArray(j) = tem
                end if 
            end do
        end do
    end subroutine selectSort

    subroutine mergeSort(inputArray, size) 
        implicit none
        integer :: size
        integer, dimension(size) :: inputArray
        integer, dimension(size/2) :: left
        integer, dimension(size - size/2) :: right 
        integer :: mid 
        mid = size/2
        if (size > 1) then 
            left = inputArray(:mid) 
            right = inputArray(mid+1:)
        end if 
    end subroutine mergeSort

    pure recursive function quickSort(x) result(res)
        integer(i1), dimension(:), intent(in) :: x !! Input array
        integer(i1), dimension(size(x)) :: res
        integer(i1), dimension(size(x)-1) :: rest
        integer(i8), dimension(:), allocatable :: split
        integer(i1) :: pivot
        if(size(x) > 1)then
            pivot = head(split(x, 2))
            rest = [split(x, 1), tail(split(x, 2))]
            res = [quickSort(pack(rest, rest < pivot)), pivot, &
                quickSort(pack(rest, rest >= pivot))]
        else
            res = x
        endif
    end function quickSort


end module sorting 

program test
    use :: sorting, only : bubbleSort, selectSort, mergeSort
    implicit none
    integer, dimension(5) :: inputArray = [2, 9, 3, 0, -1]
    call bubbleSort(inputArray, 5)
    print *, inputArray
    
    inputArray = [2, 9, 3, 0, -1]
    call selectSort(inputArray, 5)
    print *, inputArray


    inputArray = [2, 9, 3, 0, -1]
    call mergeSort(inputArray, 5)
end program test
