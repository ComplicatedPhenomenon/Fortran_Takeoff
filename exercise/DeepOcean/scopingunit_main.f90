program scoping_test
   use module_example
   implicit none

   integer :: i = 1, j = 2
   write (*, '(A25,2I7,2F7.1)') 'Begining', i, j, x, y
   call sub1(i, j)
   write (*, '(A25,2I7,2F7.1)') 'After sub1', i, j, x, y
   call sub2
   write (*, '(A25,2I7,2F7.1)') 'After sub2', i, j, x, y
   contains
   subroutine sub2
      real :: x
      x = 1000.
      y = 2000.
      write(*,'(A25, 2F7.1)') 'In sub2 :', x ,y
   end subroutine sub2   
end program scoping_test

include 'scopingunit_module.f90'
include 'scopingunit_sub.f90'
