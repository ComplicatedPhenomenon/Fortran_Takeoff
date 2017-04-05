      program kindCheck
      implicit none

      integer :: i
      real :: r
      complex :: cp
      character*1 :: c
      logical :: lg

      print *,'Integer  ', kind(i)
      print *,'Real     ', kind(r)
      print *,'Complex  ', kind(cp)
      print *,'Character', kind(c)
      print *,'Logical  ', kind(lg)
!Fortran is not blank space sensitive 
      end program kindCheck
