!module var_declare
!   implicit none
   
!   integer  :: a
!end module var_declare

module init_var
   implicit none
   integer, parameter :: a = 3
   real   , parameter :: pi = 3.1415926
end module init_var

program test
   ! make the content of module available
   use init_var, only : a

   implicit none

   write(*,*), a ,'a+1 = ', a+1
end program test
