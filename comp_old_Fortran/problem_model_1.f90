module wz
   private
   public :: print_f_a 
   real, parameter :: const = 3.14
   contains
      function f_a(a) result(expr)
         implicit none
         !real :: a
         real,intent(in):: a
         real :: expr
         print *,a
         expr = const * a
      end function f_a

      subroutine print_f_a(a,last_val) !subroutine print_f_a(last_val)
         implicit none
         real :: last_val
         real,intent(in):: a
         real :: expr
         
         print *,a
         expr = f_a(a)
         last_val = const * expr
         print *, last_val
      end subroutine print_f_a
end module wz

program aa
   use wz
   implicit none
   real :: a
   real :: last_val
   a = 4
   call print_f_a(a,last_val)          ! print_f_a(last_val)
end program aa
