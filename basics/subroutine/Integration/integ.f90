program test
implicit none

integer :: j, divisions
real :: ix, I, f
real :: step
divisions = 100000.
step = 1. / divisions
I = 0.
do j = 0, divisions
   !ix = (j + 0.5) * step 
   ix = j * step 
   I = I + f(ix) * step
   open(1, file = 'data1.dat',status = 'unknown')
   write (1,*) "ix =", ix, "delatI", f(ix) * step, I 
end do 
close (1)
print *, I
end program test


function f(x) result(expr)
real :: x , expr 
expr = 4.0 / (1.0 + x ** 2) 
end function f 
