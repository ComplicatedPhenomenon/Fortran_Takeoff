program complexarithmatic
implicit none

complex :: i = (0,1)
complex :: x, y, z
x = (7, 8)
y = (5,-7)
print *,"x = ", x
print *,"y = ", y
print *,"i * x * y = ", i*x*y
z = x + y
print *,"z = x + y = ",z
end program complexarithmatic
