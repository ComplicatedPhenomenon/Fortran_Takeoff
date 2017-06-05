module my_fxn
   implicit none   
   private
   public :: fxn_2   
   
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
      
      

      subroutine commonpart(p4_v,k_v,s13, s14, s23, s24, tau_0)
         implicit none
        ! real(kind(0d0)) :: S
         real(kind(0d0)) :: s12,  s13, s14, s23, s24, tau_0 ! for output
         real(kind(0d0)) :: p3_v, p4_v, k_v   ! intermediate vars
         real(kind(0d0)) :: theta, cos_theta, sin_theta, &
                            eta, cos_eta, sin_eta,        &
                            ksi, cos_ksi, sin_ksi,        &
                            p3_0, p4_0, gm
         real(kind(0d0)), dimension(0:3) :: k1, k2, p3, p4, k ! 5 kinematics vars

         p3_v = sqrt(p3_0**2-m**2) 
         p4_v = sqrt(p4_0**2-m**2) 
         k_v = sqrt((sqrt(s12)-p3_0-p4_0)**2-gm**2)

         cos_theta = cos(theta)
         sin_theta = sqrt(1-cos_theta**2) 
         cos_eta = cos(eta)
         sin_eta = sqrt(1-cos_eta**2)  ! ?wm?
         cos_ksi = (k_v**2-p3_v**2-p4_v**2)/(2*p3_v*p4_v)
         sin_ksi = sqrt(1-cos_ksi**2)

         k1 = [sqrt(s12)/2d0,0d0,0d0, sqrt(s12)/2d0]
         k2 = [sqrt(s12)/2d0,0d0,0d0, sqrt(s12)/2d0]
         p3 = [p3_0, p3_v*(cos_theta*cos_eta*sin_ksi+sin_theta*cos_ksi), &
               p3_v* sin_eta*sin_ksi, p3_v*( cos_theta*cos_ksi-sin_theta*cos_eta*sin_ksi)]
         p4 = [p4_0, p4_v*sin_theta, 0d0, p4_v*cos_theta]
         k  = 0 - p3 - p4

         s13 = (m**2- 2*dot_vec(k1,p3))
         s14 = (m**2- 2*dot_vec(k1,p4))
         s23 = (m**2- 2*dot_vec(k2,p3))
         s24 = (m**2- 2*dot_vec(k2,p3))
         tau_0 = m**2/S

      end subroutine commonpart




      function fxn_2( x, wgt) result(fxn_gg)
         implicit none 
         real(kind(0d0)), dimension(1:2) :: x               ! 2 var
         real(kind(0d0)), dimension(1:7) :: z               ! used to store the 7 variables of integration
         real(kind(0d0)) :: wgt
         !
         real(kind(0d0)) :: tau_0
         real(kind(0d0)) :: p3_0, p4_0, theta, eta, gm      ! other 5 vars
         real(kind(0d0)) :: sigma, tau, m_plus, m_minus,  &   ! intermediate var 
                            p3_v, p4_v, k_v
         real(kind(0d0)) :: s12,s13,s14,s23, s24,sunn       ! var from input file
         real(kind(0d0)) :: part_gg,fxn_gg       
         real(kind(0d0)) :: p3_0_max, p4_0_max, theta_max, eta_max, gm_max, x1_max, x2_max, &
                            p3_0_min, p4_0_min, theta_min, eta_min, gm_min, x1_min, x2_min
         real(kind(0d0)), dimension(1:7) :: upper, lower
         real(kind(0d0)) :: jfactor
         sunn = 3                                          !!! only a test
         S = 64000000d0
         wgt = 0
         s12 = x(1) * x(2) * S

         z = [ p3_0, p4_0, theta, eta, gm, x(1),x(2)]
         call commonpart(p4_v,k_v,s13, s14, s23, s24, tau_0) 
       

         sigma = sqrt(s12)-p4_0
         tau = sigma**2 - k_v**2
         m_plus = m + gm
         m_minus = m - gm
         
         p3_0_max = 1/(2*tau)*(sigma*(tau+m_plus*m_minus)+p4_v*sqrt((tau-m_plus**2)*(tau-m_minus**2)))
         p3_0_min = 1/(2*tau)*(sigma*(tau+m_plus*m_minus)-p4_v-sqrt((tau-m_plus**2)*(tau-m_minus**2)))
         p4_0_max = sqrt(s12)/2 - (4*m**2-gm**2)/(2*sqrt(s12))
         p4_0_min = m
         theta_max = 1
         theta_min = -1
         eta_max = 2*pi
         eta_min = 0
         gm_max = s12                                      !!! 
         gm_min = 0
         x1_max = 1
         x1_min = 1/tau_0
         x2_max = 1
         x2_min = tau_0/x(2)

         upper = [p3_0_max, p4_0_max, theta_max, eta_max, gm_max, x1_max, x2_max]
         lower = [p3_0_min, p4_0_min, theta_min, eta_min, gm_min, x1_min, x2_min]

         z = (upper - lower)*z + lower  ! feel the power of using advanced concept
         
         jfactor = jacobian(upper, lower)
         

         m_res = 2*m
         if (sqrt(s12) < m_res)then
            fxn_gg = 0d0
            return
         else 
         endif

         include "b2.m"
         part_gg = CT14Pdf(0,x(1),Q)*CT14Pdf(0,x(2),Q) * part_gg

         fxn_gg = jfactor * part_gg
      end function fxn_2
end module my_fxn
