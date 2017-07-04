module global_var
   implicit none
   private
   real :: pi=3.14
   real, parameter :: e = 2.71828
   real :: varfo 
   public :: pi, e, varfo
   public :: ps
   contains
      subroutine ps
         implicit none
         print *,'pi=',pi
         print *,'e=',e
         print *,'var from outside of this module:', varfo
      end subroutine ps
end module global_var
!******************************************************
! What's the use of implicit none included in a module?
! Why dummy variable and subroutine are connected?
!******************************************************
