program test_equlity
implicit none

!double precision is not needed anymore
integer :: i
real :: x
logical :: lol
i = 9 / 2
lol = 1 == (1 / 3) * 3.
print *,"lol = 1 == (1/3) * 3. is TRUE or FALSE : ", lol
print *,"9/2 =",i 
end program test_equlity
