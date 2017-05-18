program main
use MC_VEGAS 
implicit none

real(kind(0d0)), external :: f, g
integer                   :: NDIM
real(kind(0d0))           :: avgi_f, avgi_g, sd, chi2a

NDIM=1
open(1,file = 'DATA.txt', status='unknown')
call vegas(NDIM,f,avgi_f,sd,chi2a)
call vegas(NDIM,g,avgi_g,sd,chi2a)
write(1,*)'TEST',avgi_f,avgi_g
close(1)
print *, 'avgi_f = ', avgi_f
print *, 'avgi_g = ', avgi_g
end program main
real(kind=8) function f(x)
implicit none
double precision x
      
f = x ** 2
end function 

real(kind=8) function g(x)
implicit none

double precision  x
g = x ** 3
end function 

include "MC_VEGAS.f90"
