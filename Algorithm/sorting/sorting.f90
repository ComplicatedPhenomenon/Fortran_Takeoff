! ToDo: mergeSort is not right
module sorting 
    use iso_fortran_env, only: i4 => int32, i8 => int64
    implicit none
contains
    subroutine bubbleSort(array)
        implicit none
        integer, dimension(:):: array
        integer :: i, j, tem
        i = size(array)
        do while (i > 1)
            do j = 1, i - 1 
                if (array(j) > array(j + 1)) then
                    tem = array(j)
                    array(j) = array(j + 1)
                    array(j + 1) = tem
                end if 
            end do
            i = i - 1
        end do 
    end subroutine bubbleSort

    subroutine selectSort(array) 
        implicit none
        integer, dimension(:) :: array
        integer :: i, j, tem
        

        do i = 1, size(array) - 1
            do j = i + 1, size(array)
                if (array(i) > array(j)) then
                    tem = array(i)
                    array(i) = array(j)
                    array(j) = tem
                end if 
            end do
        end do
    end subroutine selectSort

    pure recursive function mergeSort(array) result(res)
        implicit none
        integer, dimension(:), intent(in) :: array
        integer, dimension(size(array)) :: res
        integer, dimension(size(array)/2) :: left
        integer, dimension(size(array) - size(array)/2) :: right 
        integer :: mid, l, r, i  
        
        if (size(array) > 1) then 
            mid = size(array) / 2
            left = array(:mid) 
            right = array(mid+1:)
            mergeSort(left)
            mergeSort(right)
        end if 
        
        l = 1
        r = 1
        i = 1
        do while(l <= size(left) .and. r <= size(right))
            if (left(l) < right(r)) then 
                res(i) = left(l)
                l = l + 1
            else
                res(i) = right(r)
                r = r + 1
            end if
            i = i + 1
        end do

        do while(l <= size(left))
            res(i) = left(l)
            l = l + 1
            i = i + 1
        end do 
        do while(r <= size(right))
            res(i) = right(r)
            r = r + 1
            i = i + 1
        end do 
    end function mergeSort

    pure recursive function quickSort(x) result(res)
        integer, dimension(:), intent(in) :: x !! Input array
        integer, dimension(size(x)) :: res
        integer, dimension(size(x)- 1) :: tem
        integer :: pivot

        if(size(x) > 1)then
            pivot = x(size(x) / 2 + 1)
            tem = [x(1 : size(x)/2), x(size(x) / 2 + 2:)]
            res = [quickSort(pack(tem, tem < pivot)), pivot, &
                   quickSort(pack(tem, tem >= pivot))]
          else
            res = x
          endif
    end function quickSort
end module sorting 

program test
    use sorting, only : bubbleSort, selectSort, mergeSort, quickSort
    implicit none
    integer, dimension(5) :: array = [2, 9, 3, 0, -1]
    integer, dimension(8) :: array_8, res 
    call bubbleSort(array)
    print *, array
    
    array = [2, 9, 3, 0, -1]
    call selectSort(array)
    print *, array


    array_8 = [2, 11, 4, 1, 9, 3, 0, -1]
    res = mergeSort(array_8)
    print *, res
    
    array_8 = [2, 11, 4, 1, 9, 3, 0, -1]
    print *, "OA: ", array_8
    res = quickSort(array_8)
    print *, res
end program test
