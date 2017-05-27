module const
   real(kind(0d0)), parameter      :: A=64000000d0
   real(kind(0d0)), parameter      :: m=172d0
   real(kind(0d0)), parameter      :: Q=2d0 
   real(kind(0d0)), parameter      :: pi=3.14159d0
   real           , parameter      :: a_s = 0.12d0
end module const

module my_fxn
   use const
   private
   real(kind(0d0)), public  :: fxn_1, fxn_2
   contains
           
   subroutine commonpart(t, u, f, tau_0)
      implicit none
      real(kind(0d0)), intent(out):: t, u, f, tau_0
      real(kind(0d0)), dimension(1:3) :: x
      real(kind(0d0))  :: s, sqrts,m_res
      real(kind(0d0)), dimension(0:3) :: p1, p2
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

   function fxn_1(x, wgt), result(fxn_qq)
      implicit none

      real(kind(0d0)), dimension(1:3), intent(in) :: x
      real(kind(0d0)):: wgt
!     real(kind(0d0)), intent(in):: wgt
!     dummy argument with intent(in) context assignment
      real(kind(0d0)):: fxn_qq
      real(kind(0d0)):: t, u, f, tau_0
      integer        :: i
      real(kind(0d0))  :: s, sqrts,m_res
      real(kind(0d0)), external       :: CT14pdf
      wgt = 0d0
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

   function fxn_2(x, wgt),result(fxn_gg)
      implicit none 

      real(kind(0d0)), dimension(1:3) :: x
      real(kind(0d0)):: wgt
      real(kind(0d0)):: fxn_gg                          ! notice that you don't define the intent of the result
      real(kind(0d0)):: t, u, f, tau_0
      real(kind(0d0))  :: s, sqrts,m_res
      real(kind(0d0)), external:: CT14pdf
      wgt = 0d0
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
      
include"CT14Pdf.f90"   
