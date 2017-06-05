module wz
   private
   public :: L_t
   real, parameter :: c = 30000.
   contains
      function L_t(t) result(distance)
         implicit none
         real,intent(in) :: t
         real :: distance
         distance = c * t
      end function L_t
end module wz
program ex1
   use wz
   implicit none
   integer, dimension(3) :: x
   integer, dimension(1:3) :: y
   real :: t
   real :: distance

   x = [1, 2, 3]
   y = [1, 2, 3]
   t = 3.           ! passing the variable to procedures works well here

   print *, x
   print *, y
   print *, y
   print *, x - y
   print *,1 + x - y
   print *,L_t(t)
   distance = L_t(t)
   print *, distance
end program ex1
