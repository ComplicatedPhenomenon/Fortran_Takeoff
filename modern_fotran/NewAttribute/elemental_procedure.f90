! 2017 / 09 /10  version  1.1    
! -----------------------------------------------------------------------------
! The ELEMENTAL attribute allows for declaring procedures that operate element
! by element and can be applied to arrays of any dimensions. This is another 
! way for defining more general procedures. 
! CAUTION :
! In a simplified model, we leave off implicit none, private, public
! -----------------------------------------------------------------------------
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

      subroutine elesub2(a, b, c)
         integer, intent(in) :: a, b
         integer, intent(out) :: c
         c = a - b
      end subroutine elesub2
end module mod1


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

   ! call elesub2(ia, j, ic)
   !               1
   ! Error: Rank mismatch in argument ‘a’ at (1) (scalar and rank-1)

   ! call elesub2(ia, j, ic)
   ! write(*,*) ic
   ! call elesub2(ia, ib, ic)
   ! write(*,*) ic
end program prog1
