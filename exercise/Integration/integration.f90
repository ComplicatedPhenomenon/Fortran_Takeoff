program test
implicit none

integer :: j, divisions
real :: ix, I, function
real :: step
!=====================================================
! I make the total amount of infinitesimal a variable*
! so you can modify it for precision needs           *
!=====================================================
divisions = 100000.
!=====================================================
! DON'T write step = 1 / divisions, it take me hours *
! to find out the mistake. (or step is always 0, How *
! can you be unware of it?). Although you already   *
! learned the data type in Fortran. PNWU             *
!=====================================================
step = 1. / divisions
I = 0.
do j = 0, divisions
   ix = (j + 0.5) * step 
   I = I + function(ix) * step
end do 
print *, I
end program test


!=====================================================
! you use it when you need to! So you don't nest the *
! function in a module here                          *
!=====================================================
function function(x) result(expr)
real :: x , expr 
!expr = 4.0 / (1.0 + x ** 2) 
!expr = x
include 'expr.m'
end function function
