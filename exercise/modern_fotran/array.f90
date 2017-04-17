program alloc_array
implicit none

real , dimension(:),   allocatable :: x_1d  !Attribute 
real , dimension(:,:), allocatable :: x_2d  !Allocatable
integer, dimension(:, :), allocatable :: array
integer :: row, col
x_1d = (/1,2,3,4,5,6,5,4,3,2,1/)
!allocate(x_2d(3,4))
!x_2d = transpose(reshape((/1.1 , 2.1, 3.1, 4.1, 5.1, 6.1, 7.1, 7.1, 9.1, 10.2 , 1.1 /),(/size (x_2d, 2), size(x_2d,1)/)))
!deallocate(x_2d)
allocate(array(2, 3))
array = transpose(reshape((/ 1, 2, 3, 4, 5, 6 /), (/ size(array, 2), size(array, 1) /)))
deallocate (array)
print *,x_1d
!print *,x_2d

do row = 1, 2
   do col = 1, 3
      print *,array(row, col)
   end do
end do
end program alloc_array




!*Allocatable arrays* how to understand this concept?
! for general case (allocatable 2D array with columns and rows different),one need size intrinsic
