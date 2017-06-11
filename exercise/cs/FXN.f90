module my_fxn
   implicit none   
   private
   public :: fxn_2   
   
   
   real(kind(0d0)), parameter      :: S=64000000d0
   real(kind(0d0)), parameter      :: g_s = 0.001d0
   real(kind(0d0)), parameter      :: M_p = 1000d0
   real(kind(0d0)), parameter      :: m=172d0
   real(kind(0d0)), parameter      :: Q=2d0 
   real(kind(0d0)), parameter      :: pi=3.14159d0
   real(kind(0d0)), parameter      :: a_s = 0.12d0
   real(kind(0d0)), external       :: CT14pdf
   real(kind(0d0)) :: s12,sqrts,m_res
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
      
      

      subroutine commonpart(p3_0, p4_0,cos_theta,eta, k_v,P3_v, p4_v, s13, s14, s23, s24) 
         implicit none
         real(kind(0d0)) :: s13, s14, s23, s24
         real(kind(0d0)) :: p3_v, p4_v, k_v  
         real(kind(0d0)) :: cos_theta, sin_theta, &
                            eta, cos_eta, sin_eta,        &
                            ksi, cos_ksi, sin_ksi,        &
                            p3_0, p4_0
         real(kind(0d0)), dimension(0:3) :: k1, k2, p3, p4, k ! 5 kinematics vars


         sin_theta = sqrt(1-cos_theta**2) 
         cos_eta = cos(eta)
         sin_eta = sqrt(1-cos_eta**2)  
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

      end subroutine commonpart




      function fxn_2(z, wgt) result(fxn_gg)
         implicit none 
         real(kind(0d0)), dimension(1:7) :: z               ! used to store the 7 variables of integration
         real(kind(0d0)), dimension(1:7) :: tem               ! used to store the 7 variables of integration
         real(kind(0d0)), dimension(1:2) :: x               ! used to store the 7 variables of integration
         real(kind(0d0)) :: wgt
         real(kind(0d0)) :: m_res, tau_0
         real(kind(0d0)) :: p3_0, p4_0, theta, eta, gm      ! other 5 vars
         real(kind(0d0)) :: sigma, tau, m_plus, m_minus,  &   ! intermediate var 
                            p3_v, p4_v, k_v
         real(kind(0d0)) :: s13,s14,s23, s24,sunn       ! var from input file
         real(kind(0d0)) :: part_gg,fxn_gg       
         real(kind(0d0)) :: p3_0_max, p4_0_max, cos_theta_max, eta_max, gm_max, x1_max, x2_max, &
                            p3_0_min, p4_0_min, cos_theta_min, eta_min, gm_min, x1_min, x2_min
         real(kind(0d0)), dimension(1:7) :: upper, lower
         real(kind(0d0)) :: jfactor

         sunn = 3                                          !!! only a test
         wgt = 0
         tau_0 = m**2/S
!-----------------------------------------------------------
!        z = [ p3_0, p4_0, theta, eta, gm, x(1),x(2)]
!        z = [ gm, eta, cos_theta,x(1),x(2),p4_0, p3_0]]
!       call commonpart(z(7),z(6),z(3),z(2),z(1)...)
!-----------------------------------------------------------
         gm_max = m/4                                      !!! 
         gm_min = m/10
         z(1)= (gm_max-gm_min)*z(1) + gm_min

         eta_max = 2*pi
         eta_min = 0
         z(2) = (eta_max-eta_min)*z(2)+eta_min

         cos_theta_max = 1
         cos_theta_min = -1
         z(3) = (cos_theta_max-cos_theta_min)*z(3)+cos_theta_min

         x1_max = 1
         x1_min = tau_0
         z(4) = (x1_max-x1_min)*z(4) + x1_min

         x2_max = 1
         x2_min = tau_0/z(4)
         z(5) = (x2_max-x2_min)*z(5)+x2_min

         s12 = z(4)*z(5) * S

         p4_0_max = sqrt(s12)/2 - (4*m**2-gm**2)/(2*sqrt(s12))
         p4_0_min = m
         z(6) = (p4_0_max-p4_0_min)*z(6)+p4_0_min

         p4_v = sqrt(z(6)**2-m**2) 
         sigma = sqrt(s12)-z(6)
         tau = sigma**2 - p4_v**2
         m_plus = m + z(1)
         m_minus = m - z(1)

         p3_0_max = 1/(2*tau)*(sigma*(tau+m_plus*m_minus)+p4_v*sqrt((tau-m_plus**2)*(tau-m_minus**2)))
         p3_0_min = 1/(2*tau)*(sigma*(tau+m_plus*m_minus)-p4_v-sqrt((tau-m_plus**2)*(tau-m_minus**2)))
         z(7) = (p3_0_max-p3_0_min)*z(7)+p3_0_min

         p3_v = sqrt(z(7)**2-m**2)    !Do you see you make p3_0 satisfy 0<p3_0<1
         k_v = sqrt((sqrt(s12)-z(6)-z(7))**2-z(1)**2)
!         z = (upper - lower)*z + lower  ! feel the power of using advanced concept
!---------------------------------------------------------------------------------
! oder! order! order !
!---------------------------------------------------------------------------------
!         print *,z(4), z(5)
!         pause
         upper = [gm_max, eta_max, cos_theta_max, x1_max, x2_max, p4_0_max, p3_0_max]
         lower = [gm_min, eta_min, cos_theta_min, x1_min, x2_min, p4_0_min, p3_0_min]
         jfactor = jacobian(upper, lower)
!         print *, jfactor
 !        pause

         m_res = 2*m
!         if (sqrt(s12) < m_res)then
!            fxn_gg = 0d0 
!            else if (z(7)<p3_0_min)then
!               fxn_gg = 0d0 
!               else if (z(6)< m)then
!                  fxn_gg = 0d0 
!                  else if (z(1)<gm_min)then
!                     fxn_gg = 0d0 
!                     else 
!                             return
!                 end if
!         print *, z
 !        pause
         gm = z(1)

         call commonpart(z(7),z(6),z(3),z(2), k_v,p3_v, p4_v, s13, s14, s23, s24) 
         print *, gm, sunn, m, s12, s13, s14, s23, s24
         pause

         include "apple21.m"
         print *, part_gg
         pause
         part_gg = CT14Pdf(0,z(4),Q)*CT14Pdf(0,z(5),Q) * part_gg
         print *, part_gg
         pause
!         print *, g_s**4/M_p**2
!         pause
         fxn_gg = jfactor * g_s**4/M_p**2 * part_gg
      end function fxn_2
end module my_fxn

! s12, m_plus and m_minus all are problems
