module mod1
   contains

      elemental function contract(a,b) result(c)
         integer, intent(in) :: a, b
         integer             :: c
         c = a - b
      end function 

      elemental subroutine elesub1(a, b, c)
         integer, intent(in) :: a, b
         integer, intent(out) :: c
         c = a - b
      end subroutine elesub1
end module mod1

! In a simplified model, we ingnore implicit none, private, public

program prog1
   use mod1
   integer :: i, j, k, ia(3), ib(3), ic(3)
   i = 0
   j = -1
   ia = [1, 2, 3]
   ib = [4, 5, 6]

   write (*,*) contract(i, j)
   write (*,*) contract(i, ia)
   write (*,*) contract(ib, i)
   write (*,*) contract(ia, ib)
   call elesub1(i, j, k)
   write(*,*) k
   call elesub1(ia, j, ic)
   write(*,*) ic
   call elesub1(ia, ib, ic)
   write(*,*) ic
end program prog1
