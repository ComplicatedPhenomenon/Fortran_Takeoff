program matrix
real(kind=4), dimension(2,2) :: a = 0
real, allocatable, dimension( :,:) :: b
read *,b
print *, b
read *,a
print *,a
print *,"size of  a =" ,sizeof(a)
print *,"shape of a =" ,shape(a)
print *,"The lower bound of a is :" ,lbound(a)
print *,"The indicies of the minimum value of a is :",minloc(a)
print *,a(2,2)
print *,transpose(a)
end program matrix
