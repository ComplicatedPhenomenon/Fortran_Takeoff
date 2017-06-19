module my_fxn
   implicit none   
   private
   public ::  fxn_2   
   
   
   real(kind(0d0)), parameter      :: S=6.4d7
   real(kind(0d0)), parameter      :: g_s = 0.118d0
!   real(kind(0d0)), parameter      :: M_p = 1.220910d19
!   real(kind(0d0)), parameter      :: M_D = 1d3
!   real(kind(0d0)), parameter      :: M_D = 1d5
   real(kind(0d0)), parameter      :: M_D = 1d4
   real(kind(0d0)), parameter      :: m=172d0
   real(kind(0d0)), parameter      :: Q=2d0 
   real(kind(0d0)), parameter      :: pi=3.14159d0
   real(kind(0d0)), external       :: CT14pdf
   real(kind(0d0)) :: s12
   integer         :: i
   contains        
      function jacobian( upper, lower) result(jfactor)
         implicit none
         real(kind(0d0)), dimension(1:7) :: upper, lower
!         real(kind(0d0)), dimension(1:6) :: upper, lower
         real(kind(0d0))  :: jfactor
          
         jfactor = 1d0
         do i = 1, 7
!         do i = 1, 6
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
         real(kind(0d0)), dimension(0:3) :: k1, k2, p3, p4, k 


         sin_theta = sqrt(1-cos_theta**2) 
         cos_eta = cos(eta)
         sin_eta = sqrt(1-cos_eta**2)  
         cos_ksi = (k_v**2-p3_v**2-p4_v**2)/(2*p3_v*p4_v)
         sin_ksi = sqrt(1-cos_ksi**2)

         k1 = [sqrt(s12)/2d0,0d0,0d0, sqrt(s12)/2d0]
         k2 = [sqrt(s12)/2d0,0d0,0d0, -sqrt(s12)/2d0]
         p3 = [p3_0, p3_v*(cos_theta*cos_eta*sin_ksi+sin_theta*cos_ksi), &
               p3_v* sin_eta*sin_ksi, p3_v*( cos_theta*cos_ksi-sin_theta*cos_eta*sin_ksi)]
         p4 = [p4_0, p4_v*sin_theta, 0d0, p4_v*cos_theta]
         do i = 1, 3
         k(i)  = 0 - p3(i) - p4(i)
         end do
         k(0) = sqrt(s12) - p3_0-p4_0

         s13 = m**2- 2*dot_vec(k1,p3)
         s14 = m**2- 2*dot_vec(k1,p4)
         s23 = m**2- 2*dot_vec(k2,p3)
         s24 = m**2- 2*dot_vec(k2,p3)

      end subroutine commonpart

      function fxn_2(z, wgt) result(fxn_gg)
         implicit none 
         real(kind(0d0)), dimension(1:7) :: z      
!         real(kind(0d0)), dimension(2:7) :: z      
         real(kind(0d0)) :: wgt
         real(kind(0d0)) :: tau_0
         real(kind(0d0)) :: sigma, tau, m_plus, m_minus,  &   ! intermediate var 
                            p3_v, p4_v, k_v, phi
         real(kind(0d0)) :: s13,s14,s23, s24, gm, sunn    
         real(kind(0d0)) :: part_gg,fxn_gg       
         real(kind(0d0)) :: p3_0_max, p4_0_max, cos_theta_max, eta_max, gm_max, x1_max, x2_max, &
                            p3_0_min, p4_0_min, cos_theta_min, eta_min, gm_min, x1_min, x2_min
         real(kind(0d0)), dimension(1:7) :: upper, lower
!         real(kind(0d0)), dimension(1:6) :: upper, lower
         real(kind(0d0)) :: jfactor

         sunn = 3                                        
         wgt = 0
!-----------------------------------------------------------
!        z = [ gm, eta, cos_theta,x(1),x(2),p4_0, p3_0]]
!       call commonpart(z(7),z(6),z(3),z(2),z(1)...)
!-----------------------------------------------------------
         gm_max = M_D
         gm_min = 0.01d0
         z(1)= (gm_max-gm_min)*z(1) + gm_min

         tau_0 = (2*m+z(1))**2/S
         tau_0 = (2*m+1)**2/S

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
         if (sqrt(s12) < 2*m+z(1))then
!         if (sqrt(s12) < 2*m+1)then
            fxn_gg = 0d0 
            return
            else
         end if

         p4_0_max = sqrt(s12)/2 - ((m+z(1))**2-m**2)/(2*sqrt(s12))
!         p4_0_max = sqrt(s12)/2 - ((m+1)**2-m**2)/(2*sqrt(s12))
         p4_0_min = m
         z(6) = (p4_0_max-p4_0_min)*z(6)+p4_0_min

         p4_v = sqrt(z(6)**2-m**2) 
         sigma = sqrt(s12)-z(6)
         tau = sigma**2 - p4_v**2
         m_plus = m + z(1)
         m_minus = m - z(1)
!         m_plus = m + 1
!         m_minus = m - 1

         p3_0_max = 1/(2*tau)*(sigma*(tau+m_plus*m_minus)+p4_v*sqrt((tau-m_plus**2)*(tau-m_minus**2)))
         p3_0_min = 1/(2*tau)*(sigma*(tau+m_plus*m_minus)-p4_v-sqrt((tau-m_plus**2)*(tau-m_minus**2)))
         z(7) = (p3_0_max-p3_0_min)*z(7)+p3_0_min

         p3_v = sqrt(z(7)**2-m**2)  
         k_v = sqrt((sqrt(s12)-z(6)-z(7))**2-z(1)**2)
!         k_v = sqrt((sqrt(s12)-z(6)-z(7))**2-1**2)

!         gm = 1
         gm = z(1)

         upper = [gm_max, eta_max, cos_theta_max, x1_max, x2_max, p4_0_max, p3_0_max]
         lower = [gm_min, eta_min, cos_theta_min, x1_min, x2_min, p4_0_min, p3_0_min]
!         upper = [eta_max, cos_theta_max, x1_max, x2_max, p4_0_max, p3_0_max]
!         lower = [eta_min, cos_theta_min, x1_min, x2_min, p4_0_min, p3_0_min]
         jfactor = jacobian(upper, lower)
         call commonpart(z(7),z(6),z(3),z(2), k_v,p3_v, p4_v, s13, s14, s23, s24) 

         include "apple13.m"
         print *,part_gg
         pause

         part_gg = CT14Pdf(0,z(4),Q)*CT14Pdf(0,z(5),Q) * part_gg
         phi = 1/(8*(2*pi)**4) * 1/(2*s12)
!         fxn_gg = jfactor*g_s**4/M_p**2*phi*part_gg
         fxn_gg = jfactor*g_s**4/M_D**4*2*pi*z(1)*phi*part_gg
      end function fxn_2
end module my_fxn

