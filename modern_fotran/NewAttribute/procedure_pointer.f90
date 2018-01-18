! DESCRIPTION:
! use procedure pointer to invok different subprograms possesing indentical interfaces
! compare it with function pointer in C.
module Calc_mod
   implicit none

   private
   public   :: Calc_debug, Calc_normal, Calc_proc


   interface
      function Calc_proc(real_arg, opt_format) result (ret_val)
         real, intent(in) :: real_arg
         character (*), intent(in), optional :: opt_format
         real :: ret_val
      end function Calc_proc
   end interface

   contains

      function Calc_debug(arg1, opt_format) result(ret_val)
         real, intent(in) :: arg1
         character (*), intent(in), optional :: opt_format
         real :: ret_val
         ret_val = 0.0

         print *,"WITH DEBUG"

      end function Calc_debug

      function Calc_normal(arg1, opt_format) result(ret_val)
         real, intent(in) :: arg1
         character (*), intent(in), optional :: opt_format
         real :: ret_val
         ret_val = 0.0

         print *,"NORMAL"
   
      end function Calc_normal
end module Calc_mod

program Proc_pointer_test
   use Calc_mod, only: Calc_debug, Calc_normal, Calc_proc
   implicit none

   procedure (Calc_proc), pointer :: calc_func_ptr => null ()
   real :: func_value = 0.0, real_arg = 0.0
   integer :: i_two_pass
   logical :: debug_on = .false.

   do i_two_pass = 1, 2
      if (debug_on) then
         calc_func_ptr => Calc_debug
      else 
         calc_func_ptr => Calc_normal
      end if
      select case(i_two_pass)
      case (1)
         func_value = calc_func_ptr(real_arg)
         debug_on = .not. debug_on           ! make sure next time it will select the other case.
      case(2)
         func_value = Calc_func_ptr (real_arg, "WM")
      end select
   end do
end program Proc_pointer_test

