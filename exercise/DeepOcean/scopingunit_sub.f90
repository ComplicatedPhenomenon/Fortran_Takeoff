subroutine sub1(i, j)
   implicit none
   integer, intent(inout) :: i, j
   integer, dimension(5) :: array
   write(*,'(A25,2I7)') 'In sub1 before sub2: ', i,j
   call sub2
   write(*,'(A25,2I7)') 'In sub1 after  sub2: ', i,j
   array = [( 1000 *i, i = 1,5)]
   write(*,'(A25, 7I7)') 'After array def in sub2 :', i, j, array
   contains
      subroutine sub2
      integer  :: i
      i = 1000
      j = 2000
      write(*,'(A25,2I7)') 'In sub1 in  sub2: ', i,j
      end subroutine sub2
end subroutine sub1
