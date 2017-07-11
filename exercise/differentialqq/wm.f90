module global_var
   implicit none
   private
   real :: pi=3.14
   real, parameter :: e = 2.71828
   real :: varfo 
   public :: pi, e, varfo
   public :: ps, loop
   contains
      subroutine ps
         implicit none
         print *,'pi=',pi
         print *,'e=',e
         print *,'var from outside of this module:', varfo
      end subroutine ps

      subroutine loop
         implicit none
         integer :: i
         do i = 1, 10
         open(1,file = 'loop.txt', status='unknown')
         write(1,*) 'i=',i
         end do
         close(1)
      end subroutine loop
end module global_var
!******************************************************
! What's the use of implicit none included in a module?
! Why dummy variable and subroutine are connected?
!******************************************************
