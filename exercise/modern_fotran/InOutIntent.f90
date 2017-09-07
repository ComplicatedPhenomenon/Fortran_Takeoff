program test_intent
   use init_var, only : a
   implicit none

   integer :: i
   integer :: output
   i = 2
   call sub(i, output)
   print *,output
   write(*,*), a ,'a+1 = ', a+1
end program test_intent

subroutine sub(input, output)
   implicit none 

   integer, intent(in)   :: input
   integer, intent(out)  :: output
   output = 2 * input
end subroutine sub

module init_var
   implicit none
   integer, parameter :: a = 3
   real   , parameter :: pi = 3.1415926
end module init_var
