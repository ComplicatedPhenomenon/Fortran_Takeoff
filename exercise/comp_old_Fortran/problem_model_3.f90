module wz
   private
   public :: uk 
   contains
      subroutine london(A, x, y ,z )
     ! subroutine london(x, y ,z )
         implicit none
         real, intent(in) :: A
         !real:: A
         real :: x, y, z
         print *, A
         x = A
         y = 2*A**2
         z = 3*A**3
      end subroutine london
      function uk(A, q) result(expr)
      !function uk(A) result(expr)
         implicit none
         real :: w
         real :: expr
         real :: A
         real :: q
         real :: x, y, z
         print *, A
         pause
         q  = 2
         call london(A, x, y, z)
        ! call london(x, y, z)
         w = 4*A**4
         expr = x *y*z*w*q
      end function uk
end module wz

program un
   use wz
   implicit none
   real :: B     
   real :: q
   B = 3
   print *,uk(B, q) ! place holder
end program un


! The statement with ! is used to replace no ! ones. However it went wrong
