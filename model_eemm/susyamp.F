c
c  squared matrix element for qq->kk  (double precision)
c
C     p1:  initial qark1                          *
C     p2:  initial qark2                          *
C     p3:  initial kai1                           *
C     p4:  initial kai2                           *
C     sqme0_q: squared matrix element            *
c----------------------------------------------------
        function  amps(ni,nf,pi,pf)
        implicit double precision (a-h,o-z)
        integer nf,ni
        real*8 pi(ni,4),pf(nf,4),tmp

        real*8 DOT
        complex*16 CCDOT

      REAL*8 p1(4), p2(4), p3(4), p4(4),p12(4),s
      common/s/s

      integer lam1,lam2,lam3,lam4,ls1,ls2,ls3,ls4
      integer i, j, k
      real*8  e,mu
      common/input/e,mu

      complex*16 vp1(4),up2(4),up4(4),vp3(4), curr1(4),curr2(4)
      complex*16 M,term1


      DO k=1,4
          p1(k)=pi(1,k)
          p2(k)=pi(2,k)
          p3(k)=pf(1,k)
          p4(k)=pf(2,k)
      	  p12(k)=p1(k)+p2(k)   !   root of s
      ENDDO
      tmp = 0d0
c-------all the spin and index of charge--------------
      DO 1 ls1=1,2 
      DO 1 ls2=1,2
      DO 1 ls3=1,2
      DO 1 ls4=1,2

      if(ls1.eq.1) lam1= 1
      if(ls1.eq.2) lam1= -1

      if(ls2.eq.1) lam2= 1
      if(ls2.eq.2) lam2= -1

      if(ls3.eq.1) lam3= 1
      if(ls3.eq.2) lam3= -1

      if(ls4.eq.1) lam4= 1
      if(ls4.eq.2) lam4= -1

c---------------polarization vecter ----------------
      call  v_spinor(p1, lam1, vp1)      ! vp1
      call  u_spinor(p2, lam2, up2)      ! up2
      call  v_spinor(p3, lam3, vp3)      ! up3
      call  u_spinor(p4, lam4, up4)      ! vp4

c================term1   ================================================

c-----------current 1,2  -------------------------
      call current(vp1, 1.0d0, 0.0d0, up2, curr1)
      call current(up4, 1.0d0, 0.0d0, vp3, curr2)

c----------------term1_1------------------------
      term1=-1.0*CCDOT(curr1,curr2)/DOT(p12,p12)
c      print*,curr1
c      print*,term1
c-------------------apmlitude----------------------
      M=e**2*term1

c===============return sqme0_q====================
      tmp=tmp+M* Conjg(M) 

 1    continue
c      pause
c================================================
      amps=tmp/4.0d0/(2.0d0*DOT(p12,p12))
c      print*,amps,DOT(p12,p12)
      RETURN
      END


