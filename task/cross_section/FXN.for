      double precision function FXN_qq(x,wgt)
      double precision x(*),wgt
      double precision::a_s    
      double precision ::A,s,m,Q,CT14Pdf
      
      double precision sqrts,m_res
c      common A,m
c      write(*,*)A,m
c      pause
      A=64000000d0
      m=172d0
      Q=2.0D0
      wgt=0d0
      pi=3.14159d0
      a_s=0.12d0
     
      s=x(2)*x(3)*A
c      write(*,*)s
c      pause
c      write(*,*) x(1),x(2),x(3)
c      pause
      sqrts=sqrt(s)
      m_res=2*m
      if(sqrts.lt.m_res)then
        FXN_qq=0d0
        return
        else 
      endif
               
! kinematic variable      
      p_1=sqrt(s)/2d0
      p_3=sqrt(s/4d0-m**2d0)
      p_4=sqrt(s/4d0-m**2d0)
      E_1=sqrt(s)/2d0
      E_3=sqrt(s)/2d0
      E_4=sqrt(s)/2d0

      t=(m**2d0-2d0*E_1*E_3+2d0*p_1*p_3*(2d0*x(1)-1d0))
      u=(m**2d0-2d0*E_1*E_4-2d0*p_1*p_4*(2d0*x(1)-1d0))
      f=(m**2d0-t)*(m**2d0-u) 
      tau_0=m**2d0/A
      
     
      FXN_qq=0.0d0
      do i=1,5
      
      FXN_qq=FXN_qq+
     <(1d0-tau_0)*(1d0-tau_0/(x(2)*(1d0-tau_0)+tau_0))*
     <CT14Pdf(i,x(2), Q) *CT14Pdf(-i, x(3), Q)*4d0*pi*
     <(a_s**2d0/(9d0*s**3d0))*sqrt(1d0-4d0*m**2d0/s )*
     <((m**2d0-t)**2d0+(m**2d0-u)**2d0+2d0*m**2d0*s)
      End do
      end function
      
      double precision function FXN_gg(x,wgt)
      double precision x(*),wgt
      double precision::a_s    
      double precision ::A,s,m,Q, CT14Pdf
      double precision sqrts,m_res
      
      A=64000000d0
      m=172d0
      Q=2.0D0
      wgt=0d0
      pi=3.14159d0
      a_s=0.12d0
     
      s=x(2)*x(3)*A
      
      sqrts=sqrt(s)
      m_res=2*m
      if(sqrts.lt.m_res)then
          FXN_gg=0d0
          return
      else 
      endif
     
      
      p_1=sqrt(s)/2d0
      p_3=sqrt(s/4d0-m**2d0)
      p_4=sqrt(s/4d0-m**2d0)
      E_1=sqrt(s)/2d0
      E_3=sqrt(s)/2d0
      E_4=sqrt(s)/2d0
     
      
      t=(m**2d0-2d0*E_1*E_3+2d0*p_1*p_3*(2d0*x(1)-1d0))
      u=(m**2d0-2d0*E_1*E_4-2d0*p_1*p_4*(2d0*x(1)-1d0))
      f=(m**2d0-t)*(m**2d0-u) 
      tau_0=m**2d0/A
 
      FXN_gg=(1d0-tau_0)*(1d0-tau_0/(x(2)*(1d0-tau_0)+tau_0))*
     <CT14Pdf(0,x(2),Q)*CT14Pdf(0,x(3),Q)*4d0*pi*
     <(a_s**2d0/(32d0*s))*sqrt(1d0-4d0*m**2d0/s)*
     <(6d0/s**2d0*f-(m**2d0*(s-4d0*m**2d0))/(3*f)+
     <4/3d0*(f-2d0*m**2d0*(m**2d0+t))/(m**2d0-t)**2d0+
     <4/3d0*(f-2d0*m**2d0*(m**2d0+u))/(m**2d0-u)**2d0-
     <3d0*(f+m**2d0*(u-t))/(s*(m**2d0-t))-  
     <3d0*(f+m**2d0*(t-u))/(s*(m**2d0-u)))
      end function
      
