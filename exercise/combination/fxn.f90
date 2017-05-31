
module my_fxn
   implicit none   
   private
   public :: fxn_1, fxn_2             ! for external use
                                      ! PRIVATE :: subname_1, subname_2
                                      ! all entities listed in PRIVATE will NOT be accessible from outside of the module 
   ! (Declared shared data here)      ! and all entities listed in PUBLIC can be accessed fron the out side of the module
   real(kind(0d0)), parameter      :: A=64000000d0
   real(kind(0d0)), parameter      :: m=172d0
   real(kind(0d0)), parameter      :: Q=2d0 
   real(kind(0d0)), parameter      :: pi=3.14159d0
   real(kind(0d0)), parameter      :: a_s = 0.12d0
   real(kind(0d0)), external       :: CT14pdf
   real(kind(0d0)), dimension(0:3) :: p1, p2
   real(kind(0d0)) :: s, sqrts,m_res
   integer         :: i
   contains        ! CONTAINS is vital, compiler will tell errors to you in human worlds
           
   subroutine commonpart(t, u, f, tau_0)
      implicit none
      real(kind(0d0)) :: t, u, f, tau_0
      real(kind(0d0)), dimension(1:3) :: x
      p1(0) = sqrt(s)/2
      p1(1) = 0d0
      p1(2) = sqrt(s/4-m**2)
      P1(3) = sqrt(s/4-m**2)
      P2(0) = sqrt(s)/2
      P2(1) = 0d0
      P2(2) = sqrt(s)/2
      P2(3) = sqrt(s)/2
!     While no errors appeare when we used x(1) here and I haven't declare type of x, I think use const worked, 
!     I think  subroutine and function are in similar position. x won't be a problem in function either 
      t = (m**2-2*p2(0)*p2(2)+2*p1(0)*p1(2)*(2*x(1)-1d0))
      u = (m**2-2*p2(0)*p2(3)-2*p1(0)*p1(3)*(2*x(1)-1d0))
      f = (m**2-t)*(m**2-u) 
      tau_0 = m**2/A
   end subroutine commonpart

   function fxn_1(x, wgt) result(fxn_qq) ! NO `,` 
      implicit none
      real(kind(0d0)), dimension(1:3) :: x
      real(kind(0d0))    :: wgt
      real(kind(0d0)) :: t, u, f, tau_0
      real(kind(0d0)) :: fxn_qq 
      wgt = 0
      s=x(2)*x(3)*A
      sqrts=sqrt(s)
      m_res=2*m
      if (sqrts.lt.m_res)then
         fxn_qq=0d0
         return
         else 
      endif
      call commonpart(t, u, f, tau_0)

      fxn_qq=0d0
      do i = 1, 5
      fxn_qq = fxn_qq + (1d0-tau_0)*(1d0-tau_0/((1d0-tau_0)*x(2)+tau_0))*CT14Pdf(i, x(2), Q)*CT14Pdf(-i, x(3), Q)*4*pi* & 
               &(a_s**2/(9*s**3))*sqrt(1d0-4*m**2/s)*((m**2-t)**2+(m**2-u)**2+2d0*m**2*s)
      end do
   end function fxn_1

  function fxn_2(x, wgt) result(fxn_gg)
     implicit none 
     real(kind(0d0)), dimension(1:3) :: x
     real(kind(0d0))    :: wgt
     real(kind(0d0)) :: t, u, f, tau_0
     real(kind(0d0)):: fxn_gg                          ! notice that you don't define the intent of the result
     wgt = 0
     s = x(2) * x(3) * A
     sqrts = sqrt(s)
     m_res = 2*m
     if (sqrts.lt.m_res)then
        fxn_gg = 0d0
        return
     else 
     endif
     call commonpart(t, u, f, tau_0)
     fxn_gg = (1d0-tau_0)*(1d0-tau_0/((1d0-tau_0)*x(2)+tau_0))*CT14Pdf(0,x(2),Q)*CT14Pdf(0,x(3),Q)*4*pi*(a_s**2/(32*s))*&
             &sqrt(1d0-4*m**2/s)*(6/s**2*f-(m**2*(s-4*m**2))/(3*f)+4/3d0*(f-2*m**2*(m**2+t))/(m**2-t)**2+&
             &4/3d0*(f-2*m**2*(m**2+u))/(m**2-u)**2-3*(f+m**2*(u-t))/(s*(m**2-t))-3*(f+m**2*(t-u))/(s*(m**2-u)))
   end function fxn_2
end module my_fxn
      
!include"CT14Pdf.f90"   
! any declared subroutines and functions local to the program block should be put after `comtain` statement
