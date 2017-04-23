module aa
contains
function myFunction(x)
real :: x , myFunction 
! myFunction = 4.0 / (1.0 + x ** 2) 
myFunction = x
return 
end function myFunction
end module aa

program test
use aa, only: myFunction
implicit none

integer :: ix, divisions
real :: I
real :: x
real :: step 
divisions = 100
step = 1 / divisions
I = 0.
do ix = 0, divisions 
   I = I + myFunction((ix+0.5) * step) * step
end do 
print *, I
end program test
