!module var_declare
!   implicit none
   
!   integer  :: a
!end module var_declare

module init_var
   implicit none
   integer, parameter :: a = 3
end module init_var

program test
   ! make the content of module available
   use init_var

   implicit none

   write(*,*), a ,'a+1 = ', a+1
end program test
