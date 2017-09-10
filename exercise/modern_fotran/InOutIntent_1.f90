! When the pointer dummy argument has the intent of intent (in out), 
! both the value and the association of the dummy argument can be changed.
module Proc_mod
   implicit none
   private 
   public :: Point_arg

   integer, target, save :: module_saved_int

   contains
      subroutine Point_arg(i_arg_a, i_arg_b)
         integer, intent (in out), pointer :: i_arg_a
         integer, intent (in out), pointer :: i_arg_b
         !integer, target :: local_non_saved_int
         integer, target, save :: local_non_saved_int

         module_saved_int = 50
         local_non_saved_int = 60
         i_arg_a => module_saved_int
         i_arg_b => local_non_saved_int
      end subroutine Point_arg
end module Proc_mod

program Point_intent_in_out
   use Proc_mod, only: Point_arg
   implicit none
   
   integer, target :: int_a, int_b
   integer, pointer :: int_point_a, int_point_b

   int_a = 5
   int_b = 8

   int_point_a => int_a
   int_point_b => int_b
   call Point_arg(int_point_a, int_point_b)

   ! int_point_a is now associated with saved module variable module_saved_int in module Proc_mod
   if(associated(int_point_a)) print *,'int_point_a:',int_point_a

   ! Even though int_point_b appears associated. its target is undefined, any reference to it is illegal
   if(associated(int_point_b)) print *,'int_point_b:',int_point_b

end program Point_intent_in_out
