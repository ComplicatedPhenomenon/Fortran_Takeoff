program l_interval_1
implicit none

real, dimension (1:3) :: x, y
integer :: i
real :: temp, l
print *,'Input the first vector'
read (*,*) x(1),x(2),x(3)
print *,'Input the second vector'
read (*,*) y(1),y(2),y(3)
temp = 0
do i = 1, 3
   temp = (x(i)-y(i)) ** 2 + temp
end do
l = sqrt (temp)
print *,l

end program l_interval_1
