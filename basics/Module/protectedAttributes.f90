!
!    Description: one subroutine call another function in module 
!    Modified date: 10/12/2018
!

module wz
   private
   public :: print_f_a, const
   real, protected :: const = 3.14 ! protect attribute allow only procedures within this module to update 
   !real, parameter :: const = 3.14
   contains
      function f_a(a) result(res)
         implicit none
         real, intent(in):: a
         real :: res
         const = 4
         res = const * a
      end function f_a

      subroutine print_f_a(a, last_val) 
         implicit none
         real,intent(in):: a
         real, intent(out) :: last_val
         print *, const
         last_val = const * f_a(a)
         print *, const
         print *, last_val
      end subroutine print_f_a
end module wz

program aa
   use wz
   implicit none
   real :: argument_a
   real :: argument_last_val
   argument_a = 4
   call print_f_a(argument_a,argument_last_val)          ! print_f_a(last_val)
end program aa
