program test_intent
   implicit none

   integer :: i
   integer :: output
   i = 2
   call sub(i, output)
   print *,output
end program test_intent

subroutine sub(input, output)
   implicit none 

   integer, intent(in)   :: input
   integer, intent(out)  :: output
   output = 2 * input
end subroutine sub
