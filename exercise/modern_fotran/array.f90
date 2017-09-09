program alloc_array
implicit none

integer , dimension(:),   allocatable :: x_1d  
integer , dimension(:,:), allocatable :: x_2d 
integer, dimension(:, :), allocatable :: array
integer :: row, col

print *,allocated(x_1d)
x_1d = [1,2,3,4,5,6,5,4,3,2,1]
print *,allocated(x_1d)
print *,x_1d

print *,allocated(x_2d)
allocate(x_2d(2,3))
x_2d =reshape([1,2,3,4,5,6], shape(x_2d))
print *,allocated(x_2d)
print *,x_2d

allocate(array(2, 3))
print *,allocated(array)
do row = 1, 2
   do col = 1, 3
      array(row, col) = row*col
   end do
end do
print *,array
deallocate (array)
print *,allocated(array)
print *,array
end program alloc_array
