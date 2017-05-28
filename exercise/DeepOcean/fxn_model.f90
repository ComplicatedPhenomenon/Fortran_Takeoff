module wz
   implicit none
   private
   public :: print_out
   real,parameter :: pi = 3.14159
   contains
      subroutine print_out(x)
      implicit none
      real, intent(in) :: x
      real :: area
      area = f(x)     ! pass `x` to `f`
      print *, area
      end subroutine print_out

      function f(x) result(area)
      implicit none

      real, intent(in):: x
      real            :: area

      area = pi * x ** 2
      end function f
end module wz

program test_module
use wz
implicit none
    real :: x
    x = 1.
   call print_out(x)
end program test_module

