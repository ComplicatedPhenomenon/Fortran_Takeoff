program test
implicit none

integer :: j, divisions
real :: ix, I, function
real :: step
divisions = 100000.
step = 1. / divisions
I = 0.
do j = 0, divisions
   ix = (j + 0.5) * step 
   I = I + function(ix) * step
end do 
print *, I
end program test


function function(x) result(expr)
real :: x , expr 
expr = x**2 
end function function
