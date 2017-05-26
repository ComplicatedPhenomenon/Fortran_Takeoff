module const
   real(kind(0d0)), parameter      :: A=64000000d0
   real(kind(0d0)), parameter      :: m=172d0
   real(kind(0d0)), parameter      :: Q=2d0 
   real           , parameter      :: wgt=0d0
   real(kind(0d0)), parameter      :: pi=3.14159d0
   real           , parameter      :: a_s = 0.12d0
   real(kind(0d0))                 :: CT14pdf
   real(kind(0d0))                 :: s, sqrts,m_res
   real(kind(0d0)), dimension(0:3) :: p1, p2
   real           , dimension(1:3) :: x
end module const

module my_fxn
   use const
   private
   public :: fxn_1, fxn_2
   contains
           
   subroutine commonpart(t, u, f, tau_0)
      use const
      implicit none
      s=x(2)*x(3)*A
      sqrts=sqrt(s)
      m_res=2*m
      if (sqrts.lt.m_res)then
         FXN_qq=0d0
         return
         else 
      endif
               
      p1(0)=sqrt(s)/2d0
      p1(2)=sqrt(s/4d0-m**2d0)
      P1(3)=sqrt(s/4d0-m**2d0)
      P2(0)=sqrt(s)/2d0
      P2(2)=sqrt(s)/2d0
      P2(3)=sqrt(s)/2d0

      t=(m**2d0-2d0*p2(0)*p2(2)+2d0*p1(0)*p1(2)*(2d0*x(1)-1d0))
      u=(m**2d0-2d0*p2(0)*p2(3)-2d0*p1(0)*p1(3)*(2d0*x(1)-1d0))
      f=(m**2d0-t)*(m**2d0-u) 
      tau_0=m**2d0/A
   end subroutine commonpart

   function fxn_1(x(*), wgt) result(fxn_qq)
      implicit none

      real(kind(0d0)),intent(in) :: t, u, f, tau_0
      call commonpart(t, u, f, tau_0)
      FXN_qq=0.0d0
      do i=1,5
      FXN_qq=FXN_qq+(1d0-tau_0)*(1d0-tau_0/(x(2)*(1d0-tau_0)+tau_0))* CT14Pdf(i,x(2), Q) *CT14Pdf(-i, x(3), Q)*4d0*pi*         &
             (a_s**2d0/(9d0*s**3d0))*sqrt(1d0-4d0*m**2d0/s )* ((m**2d0-t)**2d0+(m**2d0-u)**2d0+2d0*m**2d0*s)
      End do
   end function fxn_2

   function fxn_2(x(*), wgt) result(fxn_gg)
      implicit none 
      real(kind(0d0)),intent(in) :: t, u, f, tau_0
      call commonpart(t, u, f, tau_0)
      FXN_gg=(1d0-tau_0)*(1d0-tau_0/(x(2)*(1d0-tau_0)+tau_0))*CT14Pdf(0,x(2),Q)*CT14Pdf(0,x(3),Q)*4d0*pi*(a_s**2d0/(32d0*s))*  &
             sqrt(1d0-4d0*m**2d0/s)* (6d0/s**2d0*f-(m**2d0*(s-4d0*m**2d0))/(3*f) +                                             &
             4/3d0*(f-2d0*m**2d0*(m**2d0+t))/(m**2d0-t)**2d0 + 4/3d0*(f-2d0*m**2d0*(m**2d0+u))/(m**2d0-u)**2d0-                &
             3d0*(f+m**2d0*(u-t))/(s*(m**2d0-t)) - 3d0*(f+m**2d0*(t-u))/(s*(m**2d0-u)))
      end function
   end function fxn_2

end module my_fxn
      
      
