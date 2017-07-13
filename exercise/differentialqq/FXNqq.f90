module my_fxn
   implicit none   
   private
   public ::  fxn_1, dividing_line   
   public ::  cos_theta         
   !*********************************************************************************
   ! From some perspective, it's like <form [module name] import [], []...> in Python
   ! Without attribut private and public , it like <from [module name] import *>
   ! With only private, then accessing permission to variable is limited
   !*********************************************************************************
   
   
   real(kind(0d0)), parameter      :: S=1.69d8
   real(kind(0d0)), parameter      :: g_s = 0.118d0
   real(kind(0d0)), parameter      :: M_D = 1d4
   real(kind(0d0)), parameter      :: m=172d0
   real(kind(0d0)), parameter      :: Q=2d0 
   real(kind(0d0)), parameter      :: pi=3.14159d0
   real(kind(0d0)), external       :: CT14pdf
   real(kind(0d0)) :: s12
   real(kind(0d0)) :: cos_theta
!   real(kind(0d0)), parameter      :: cos_theta=-0.99399999999999999
   integer         :: i
   contains        
      function jacobian( upper, lower) result(jfactor)
         implicit none
         real(kind(0d0)), dimension(1:6) :: upper, lower
         real(kind(0d0))  :: jfactor
          
         jfactor = 1d0
         do i = 1, 6
            jfactor = jfactor * (upper(i) - lower(i))
         end do
      end function jacobian



      function dot_vec(p,q) result(fourvectordot)
         implicit none
         real(kind(0d0)) :: fourvectordot
         real(kind(0d0)), dimension(0:3) :: p,q

         fourvectordot = p(0) * q(0)
         do i = 1, 3
            fourvectordot = fourvectordot - p(i) * q(i)
         end do
      end function dot_vec
      
      subroutine dividing_line
         implicit none
     
         integer :: j = 0;
         integer :: n = 16;
         i = 1  
         do while (i<n)
            j = 0;
            do while (j<n)
               if (j>=i) then
                  write(*,"(A)",advance="no") " *"
               else
                  write(*,"(A)",advance="no") " ."
               end if
               j=j+1;
            end do
            i = i +1;
            print *,""
         end do
      end subroutine dividing_line


      subroutine commonpart(p3_0, p4_0,eta, k_v,P3_v, p4_v, s13, s14, s23, s24) 
         implicit none
         real(kind(0d0)), intent(in) :: p3_0, p4_0, eta, k_v, p3_v, p4_v 
         real(kind(0d0)), intent(out):: s13, s14, s23, s24
         real(kind(0d0)) :: sin_theta, &
                            cos_eta, sin_eta,        &
                            cos_ksi, sin_ksi
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

      function fxn_1(z, wgt) result(fxn_qq)
         implicit none 
         real(kind(0d0)), dimension(1:6) :: z      
         real(kind(0d0)) :: wgt
         real(kind(0d0)) :: tau_0
         real(kind(0d0)) :: sigma, tau, m_plus, m_minus,  &   ! intermediate var 
                            p3_v, p4_v, k_v, phi
         real(kind(0d0)) :: s13,s14,s23, s24, gm   
         real(kind(0d0)) :: part1_qq,part_qq,fxn_qq       
         real(kind(0d0)) :: p3_0_max, p4_0_max, eta_max, gm_max, x1_max, x2_max, &
                            p3_0_min, p4_0_min, eta_min, gm_min, x1_min, x2_min
         real(kind(0d0)), dimension(1:6) :: upper, lower
         real(kind(0d0)) :: jfactor

         wgt = 0
!-----------------------------------------------------------
!        z = [ gm, eta, cos_theta,x(1),x(2),p4_0, p3_0]]
!       call commonpart(z(7),z(6),z(3),z(2),z(1)...)
!-----------------------------------------------------------
         gm_max = M_D
         gm_min = 0.1d0
         z(1)= (gm_max-gm_min)*z(1) + gm_min

!         tau_0 = (2*m+z(1))**2/S
         tau_0 = (2*m)**2/S

         eta_max = 2*pi
         eta_min = 0
         z(2) = (eta_max-eta_min)*z(2)+eta_min

         x1_max = 1
         x1_min = tau_0
         z(3) = (x1_max-x1_min)*z(3) + x1_min

         x2_max = 1
         x2_min = tau_0/z(3)
         z(4) = (x2_max-x2_min)*z(4)+x2_min

         s12 = z(3)*z(4) * S
         if (sqrt(s12) < 2*m+z(1))then
            fxn_qq = 0d0 
            return
            else
         end if

         p4_0_max = sqrt(s12)/2 - ((m+z(1))**2-m**2)/(2*sqrt(s12))
         p4_0_min = m
         z(5) = (p4_0_max-p4_0_min)*z(5)+p4_0_min

         p4_v = sqrt(z(5)**2-m**2) 
         sigma = sqrt(s12)-z(5)
         tau = sigma**2 - p4_v**2
         m_plus = m + z(1)
         m_minus = m - z(1)

         p3_0_max = 1/(2*tau)*(sigma*(tau+m_plus*m_minus)+p4_v*sqrt((tau-m_plus**2)*(tau-m_minus**2)))
         p3_0_min = 1/(2*tau)*(sigma*(tau+m_plus*m_minus)-p4_v-sqrt((tau-m_plus**2)*(tau-m_minus**2)))
         z(6) = (p3_0_max-p3_0_min)*z(6)+p3_0_min

         p3_v = sqrt(z(6)**2-m**2)  
         k_v = sqrt((sqrt(s12)-z(5)-z(6))**2-z(1)**2)

         gm = z(1)

         upper = [gm_max, eta_max, x1_max, x2_max, p4_0_max, p3_0_max]
         lower = [gm_min, eta_min, x1_min, x2_min, p4_0_min, p3_0_min]
         jfactor = jacobian(upper, lower)
         call commonpart(z(6),z(5),z(2), k_v,p3_v, p4_v, s13, s14, s23, s24) 

!         include "Fortranjuicy.m"
         include "juicy.m"
         part1_qq = 0d0

         do i = 1, 5
            part1_qq = part1_qq+CT14Pdf(i, z(3), Q)*CT14Pdf(-i, z(4), Q)*part_qq 
         end do

         phi = 1/(8*(2*pi)**4) * 1/(2*s12)
!         fxn_qq = jfactor * g_s**4/M_D**4*2*pi*z(1)*phi*part1_qq
         fxn_qq = jfactor * g_s**4/M_D**5*pi*z(1)**2*phi*part1_qq
      end function fxn_1
end module my_fxn

