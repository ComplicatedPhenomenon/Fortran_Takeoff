!---------------------------------------------------
!    Instructions: 
!    we set up the total energy for per beam A
!    tau_0    : m_res ** 2/S
!    alpha_s  : coupling constant
!    Q **2    : the factorization scale 
!
!---------------------------------------------------
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
   real(kind(0d0)) :: s, sqrts,m_res
   integer         :: i
   contains        
      function jacobian( upper, lower) result(jfactor)
         implicit none
         real(kind(0d0)), dimension(1:3) :: upper, lower
         real(kind(0d0))  :: jfactor
          
         jfactor = 1d0
         do i = 1, 3
            jfactor = jfactor * (upper(i) - lower(i))
         end do
      end function jacobian



      function dot_vec(p,q) result(fourvectordot)
         implicit none
         integer :: i,j 
         real(kind(0d0)) :: fourvectordot
         real(kind(0d0)), dimension(0:3) :: p,q

         fourvectordot = p(0) * q(0)
         do i = 1, 3
            fourvectordot = fourvectordot - p(i) * q(i)
         end do
      end function dot_vec
      
      

!------------------------------------------!
!  momentum variable 
!------------------------------------------!
!     subroutine commonpart(A, t, u, f, tau_0)
      subroutine commonpart(t, u, f, tau_0)
         implicit none
         real(kind(0d0)) :: t, u, f, tau_0
         real(kind(0d0)) :: theta, cos_theta, sin_theta
         real(kind(0d0)), dimension(0:3) :: p_1, p_2, p_3, p_4
!        print *, A
!        pause
         cos_theta = cos(theta)
         sin_theta = sqrt(1-cos_theta**2) 
         p_1 = [sqrt(s)/2d0,0d0,0d0, sqrt(s)/2d0]
         p_2 = [sqrt(s)/2d0,0d0,0d0, sqrt(s)/2d0]
         p_3 = [sqrt(s)/2d0, 0d0, sqrt(s/4-m**2)*sin_theta, sqrt(s/4-m**2)*cos_theta]
         p_4 = [sqrt(s)/2d0, 0d0, -sqrt(s/4-m**2)*sin_theta, -sqrt(s/4-m**2)*cos_theta]

         t = (m**2-2*dot_vec(p_1,p_3))  ! using the name of function and its input to call the output of function is okay
         u = (m**2-2*dot_vec(p_1,p_4))
         f = (m**2-t)*(m**2-u) 
         tau_0 = m**2/A
      end subroutine commonpart




      function fxn_1( x, wgt) result(fxn_qq)       ! NO `,` 
         implicit none
         real(kind(0d0)), dimension(2:3) :: x
         real(kind(0d0)) :: wgt
         real(kind(0d0)) :: A
         real(kind(0d0)) :: t, u, f, tau_0
         real(kind(0d0)) :: part_qq, fxn_qq 
         real(kind(0d0))  :: theta
         real(kind(0d0)), dimension(1:3) :: upper, lower
         real(kind(0d0)) :: jfactor
         A = 64000000d0

         wgt = 0
         s=x(2)*x(3)*A
         sqrts=sqrt(s)
         m_res=2*m
!        print *, A
!        pause
         if (sqrts < m_res)then
            fxn_qq=0d0
            return
          else 
         endif
         call commonpart(t, u, f, tau_0)

!        call commonpart(A, t, u, f, tau_0)
         part_qq = 0d0
         do i = 1, 5
            part_qq = part_qq+CT14Pdf(i, x(2), Q)*CT14Pdf(-i, x(3), Q) * &
            2*pi*(a_s**2/(9*s**3))*sqrt(1d0-4*m**2/s)*       &
            ((m**2-t)**2+(m**2-u)**2+2d0*m**2*s)
         end do

         upper = [1d0, 1d0, 1d0]
         lower = [-1d0, tau_0, tau_0/x(2)]
         theta = (upper(1) - lower(1))*theta+lower(1)
         x(2) = (upper(2) - lower(2))*x(2)+lower(2)
         x(3) = (upper(3) - lower(3))*x(3)+lower(3)
         jfactor = jacobian(upper, lower)          ! It's another way but with more var defined
         fxn_qq = jfactor * part_qq

      end function fxn_1




      function fxn_2( x, wgt) result(fxn_gg)
         implicit none 
         real(kind(0d0)), dimension(2:3) :: x
         real(kind(0d0)) :: wgt
         real(kind(0d0)) :: A
         real(kind(0d0)) :: t, u, f, tau_0
         real(kind(0d0)) :: part_gg,fxn_gg                          ! notice that you don't define the intent of the result
         real(kind(0d0)) :: theta
         real(kind(0d0)), dimension(1:3) :: upper, lower
         real(kind(0d0)) :: jfactor

         A = 64000000d0
         wgt = 0
         s = x(2) * x(3) * A
         sqrts = sqrt(s)
         m_res = 2*m
         if (sqrts < m_res)then
            fxn_gg = 0d0
            return
         else 
         endif
!        call commonpart(A, t, u, f, tau_0)
         call commonpart(t, u, f, tau_0)
         part_gg = CT14Pdf(0,x(2),Q)*CT14Pdf(0,x(3),Q)* &
                  2*pi*(a_s**2/(32*s))*sqrt(1d0-4*m**2/s)*  &                                            
                  (6/s**2*f-(m**2*(s-4*m**2))/(3*f) +       &
                  4/3d0*(f-2*m**2*(m**2+t))/(m**2-t)**2+    &
                  4/3d0*(f-2*m**2*(m**2+u))/(m**2-u)**2-    &
                  3*(f+m**2*(u-t))/(s*(m**2-t))-            &
                  3*(f+m**2*(t-u))/(s*(m**2-u)))

         upper = [1d0, 1d0, 1d0]
         lower = [-1d0, tau_0, tau_0/x(2)]
         theta = (upper(1) - lower(1))*theta+lower(1)
         x(2) = (upper(2) - lower(2))*x(2)+lower(2)
         x(3) = (upper(3) - lower(3))*x(3)+lower(3)
         jfactor = jacobian(upper, lower)
         fxn_gg = jfactor * part_gg
      end function fxn_2
end module my_fxn
