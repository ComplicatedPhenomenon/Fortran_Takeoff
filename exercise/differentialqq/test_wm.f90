program wm
   use global_var
   implicit none
   varfo = 419
   print *,'******Call pi via use module where pi is defined*********'
   print *, 'pi=',pi
   print *,"Now I will change the value of pi, let's see what happen"
   pi = 3.14159265358
   print *, 'pi=',pi
   print *,'***Print  pi,e ,and varfo via a subroutine defined in a module*****'

   call ps
   print *,"You cann't assign to e any more, cause it's a constant"
end program wm
