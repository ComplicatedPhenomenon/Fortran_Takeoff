module bb
   public :: fxn_f, fxn_g 
   contains 
   function fxn_f(x) result(f)
   real(kind(0d0)) :: x, f     
   f = x ** 2
   end function fxn_f 

   function fxn_g(x) result(g)
   real(kind(0d0)) :: x, g    
   g = x ** 3
   end function fxn_g
end module bb
program main
   use bb
   use MC_VEGAS 
   implicit none

   real(kind(0d0))           :: f, g
   real(kind(0d0))           :: x
   integer                   :: NDIM
   real(kind(0d0))           :: avgi_f, avgi_g, sd, chi2a
   NDIM=1
   open(1,file = 'DATA.txt', status='unknown')
   call vegas(NDIM,fxn_f,avgi_f,sd,chi2a)
   call vegas(NDIM,fxn_g,avgi_g,sd,chi2a)
   write(1,*)'TEST'
   write(1,*)'avfi_f= ',avgi_f
   write(1,*)'avfi_g= ',avgi_g
   close(1)
   print *, 'avgi_f = ', avgi_f
   print *, 'avgi_g = ', avgi_g
end program main
include "MC_VEGAS.f90"


