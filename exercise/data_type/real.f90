program test_equlity
implicit none

integer :: i
real :: x
logical :: lol
i = 9 / 2
lol = 1 == (1. / 3.) * 3.
print *, lol
print *,"9/2 =",i 
end program test_equlity
