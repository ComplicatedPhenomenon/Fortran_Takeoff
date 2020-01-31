! keyword save is not necessary in my compiler? 
module Proc_mod
   implicit none
   private
   public :: pointerAsParameter, demoOfSave

   integer, target, save :: moduleSaveInt

   contains
      subroutine pointerAsParameter(ptr_to_a, ptr_to_b)
         implicit none 
         ! integer, intent (out), pointer :: ptr_to_a,  ptr_to_b
         integer, intent (in out), pointer :: ptr_to_a,  ptr_to_b
         integer, target, save :: localSaveInt
         print *, "moduleSaveInt = ", moduleSaveInt
         print *, "localSaveInt  = ", localSaveInt
         moduleSaveInt = 50
         localSaveInt = 60

         ptr_to_a => moduleSaveInt
         ptr_to_b => localSaveInt
      end subroutine pointerAsParameter

      subroutine demoOfSave(i, control)
         implicit none

         integer, intent (in) :: i
         logical, intent (in) :: control
      
         integer, save :: j = 0  
         integer :: k 
         ! guess what's the output, Are both j and k undefined? 
         print *,  "Before j, k =", j, k  ! when demoOfSave exit, and called again, j is not 0 but the previous value
         
         j = j + i
         if ( control ) k = 0
         k = k + i
      
         print *, "After  j, k =", j, k
      end subroutine demoOfSave
end module Proc_mod

program Point_intent_in_out
   use Proc_mod, only: pointerAsParameter, demoOfSave
   implicit none

   integer, target :: int_a, int_b
   integer, pointer :: int_point_a, int_point_b

   int_a = 5
   int_b = 8

   int_point_a => int_a
   int_point_b => int_b

   call pointerAsParameter(int_point_a, int_point_b)
   call pointerAsParameter(int_point_a, int_point_b)

   call demoOfSave(4, .FALSE.)
   call demoOfSave(3, .TRUE.)

   ! int_point_a is now associated with saved module variable moduleSaveInt in module Proc_mod
   if(associated(int_point_a)) print *,'int_point_a:',int_point_a

   ! Even though int_point_b appears associated. its target is undefined, any reference to it is illegal
   if(associated(int_point_b)) print *,'int_point_b:', int_point_b

end program Point_intent_in_out
