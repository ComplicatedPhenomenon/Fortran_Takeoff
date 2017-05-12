********************************************************************************
* This file contains the following items:
*    (1)  the expressions for Dirac spinor, Plarization vectors. 
*    (2)  the intial programe for looptools.  
*
c*******************************************************************************
c       subroutines                                                            |
c                                                                              |
C	Dirac spinor, polarization vector    (single precision except momentum)|
c                                                                              |
c       when call these subroutine, turn all momentum to real*8  !!!           |
c                                                                              |
c                                                                              |
c- Spinor ---------------------------------------------------------------------- 
c
c  (1)  u_spinor(p, spin, u)   [ spin=+-1; real*8 p(mu) ] 
c  (2)  v_spinor(p, spin, v)   [ spin=+-1; real*8 p(mu) ]
c

c  (3)	CALUVB(V2,VB2)   u -> u_bar
c
c-Current----------------------------------------------------------------------
c 
c  (4)  current(u, a, b, v, out)       out=u^bar*(a - b*gamma5)*gamma(mu)*v 
c  (5)	slash_p_v(P,v,out)             out=slash(P)*v         [ real*8  P(mu) ]
c  (6)  Cslash_p_v(Q,v,out)                 slash(Q)*v         [ complex Q(mu) ]
c  (7)	slash_p_m_v(P,v,out,m)         out=[slash(p)+m]*v     [ real*8  P(mu) ]
c  (8)	ubar_slash_p(p,ubar,out)       out=ubar*slash(p)      [ real*8  P(mu) ]
c  (9)	ubar_slash_p_m(p,ubar,out,m)   out=ubar*[slash(P)+M]  [ real*8  P(mu) ]
C  (10) PLuv(u,PLu)                    PLu=P_L*u
C  (11) PRuv(u,PRu)                    PRu=P_R*u

C- GAMMA MATRIX----THE LAST INDICES ARE SPINOR INDICES-------------------------
C  (12A)  GAMMA0_L(PL)                 PL=1./2.*(1 - GAMMA5 )  COMPLEX*16 PL(4,4)
C  (12B)  GAMMA0_R(PR)                 PR=1./2.*(1 + GAMMA5 )  COMPLEX*16 PR(4,4)
C  (12C)  GAMMA1_L(V)                  V=GAMMA^\MU PL          COMPLEX*16 V(4,4,4)
C  (12D)  GAMMA1_R(V)                  V=GAMMA^\MU PR          COMPLEX*16 V(4,4,4)
C  (12E)  GAMMA2_L(V)                  V=GAMMA^\MU GAMMA^\NU PL
C                                                           COMPLEX V(4,4,4,4)
C  (12F)  GAMMA2_R(V)                                       COMPLEX V(4,4,4,4)
C  (12G)  GAMMA3_L()                COMMON /GAMMA3L/V       V(4,4,4,4,4)
C  (12H)  GAMMA3_R()                COMMON /GAMMA3R/V       V(4,4,4,4,4)
C  (12I)  GAMMA4_L()                COMMON /GAMMA4L/V       V(4,4,4,4,4,4)
C  (12J)  GAMMA4_R()                COMMON /GAMMA4R/V       V(4,4,4,4,4,4)
C  (12K)  GAMMA5_L()                COMMON /GAMMA5L/V       V(4,4,4,4,4,4,4)
C  (12L)  GAMMA5_R()                COMMON /GAMMA5R/V       V(4,4,4,4,4,4,4) 

C--TENSOR ----------------------------------------------------------------------

C  (13A) TENSOR0_L(SV1,SV2,OUT)        OUT=SV1 PL SV2   COMPLEX*16 OUT,SV1(4),SV2(4)
C  (13B) TENSOR0_R(SV1,SV2,OUT)        OUT=SV1 PR SV2   COMPLEX*16 OUT,SV1(4),SV2(4)
C  (13C) TENSOR1_L(SV1,SV2,OUT)        OUT=SV1 GAMMA^\MU PL SV2 
C                                        COMPLEX*16 SV1(4),SV2(4),OUT(4) 
C  (13D) TENSOR1_R(SV1,SV2,OUT)        OUT=SV1 GAMMA^\MU PR SV2 
C                                        COMPLEX*16 SV1(4),SV2(4),OUT(4)
C  (13E) TENSOR2_L(SV1,SV2,OUT)        OUT=SV1 GAMMA^\MU GAMMA^\NU PL SV2 
C                                        COMPLEX*16 SV1(4),SV2(4),OUT(4,4)
C  (13F) TENSOR2_R(SV1,SV2,OUT)        OUT=SV1 GAMMA^\MU GAMMA^\NU PR SV2 
C                                        COMPLEX*16 SV1(4),SV2(4),OUT(4,4)
C  (13G) TENSOR3_L(SV1,SV2,OUT)        OUT=SV1 GAMMA^\MU GAMMA^\NU GAMMA^\RHO PL SV2 
C                                        COMPLEX*16 SV1(4),SV2(4),OUT(4,4,4)
C  (13H) TENSOR3_R(SV1,SV2,OUT)        OUT=SV1 GAMMA^\MU GAMMA^\NU GAMMA^\RHO PR SV2 
C                                        COMPLEX*16 SV1(4),SV2(4),OUT(4,4,4)
C  (13I) TENSOR4_L(SV1,SV2,OUT)        OUT=SV1 GAMMA^\MU ... PL SV2 
C                                        COMPLEX*16 SV1(4),SV2(4),OUT(4,4,4,4)
C  (13J) TENSOR4_R(SV1,SV2,OUT)        OUT=SV1 GAMMA^\MU ... PR SV2 
C                                        COMPLEX*16 SV1(4),SV2(4),OUT(4,4,4,4)
C  (13K) TENSOR5_L(SV1,SV2,OUT)        OUT=SV1 GAMMA^\MU ... PL SV2 
C                                        COMPLEX*16 SV1(4),SV2(4),OUT(4,4,4,4,4)
C  (13L) TENSOR5_R(SV1,SV2,OUT)        OUT=SV1 GAMMA^\MU ... PR SV2 
C                                        COMPLEX*16 SV1(4),SV2(4),OUT(4,4,4,4,4)
 
c-Polarization vector----------------------------------------------------------
c 
c 
C	epsilon_mu(p,epsi,1)  epsi=epsilon^mu (p,1)     polarization->1
C	epsilon_mu(p,epsi,2)  epsi=epsilon^mu (p,2)     polarization->2
C	epsilon_mu(p,epsi,3)  epsi=epsilon^mu (p,3)     polarization->3
c
C	                 (for photon, gluon, only polarization->1,2)
c
c  (14) epsilon_mu(P,epsi,Ip)      [epsi -> complex 4-vec; real*8 P(mu) ]
C- MULTIPLICATION OF A MATRIX WITH A SPINOR---------------------------------
C  (15)  mat_sp_mul(v,sv1,out)    complex*16  v(4,4), sv1(4),out(4)
 
c some functions 
c
c--gauge tensor --------------------------------------------------------------
c
c  (a)  g(i,j)       g: double precision, i,j: interger number     
c
c (a1) DOT (A,B)  dot product of two Lorentz real 4-vector (real*4)
c (a2) DOT2(A,B)  =A(1)*B(1) + A(2)*B(2)  (real*4)
c (a3) CCDOT(A,B)  same as DOT, but for complex A,B
c (a4) CDOT(A,B) same as DOT, but for real A and complex B
c (a5) CDOT_vv(v1,v2) scalor product of two complex 4-vectors 

c-(1)-U SPINOR --------------------------------------------------------------

      subroutine u_spinor(p, spin, u)
c       calculate Dirac Spinor u as 4by1 complex matrix
c       for helicity spin=+-1 and momentum real*8 p(mu)
      implicit none
      real*8 p(4)
      integer spin        ! as input helicity of fermion lambd=+-1
      complex*16 u(4)
      
      real*8 q(4), p_mag, omega_U, omega_D, eps, pabz, coeff
      parameter (eps = 1.d-10)
      
      if ((spin .ne. 1) .and. (spin .ne. -1)) then
         write(*,*) 'u_spinor: bad spin value', spin
         call exit(1)
      endif
      if (p(4) .lt. 0d0) then
         q(1) = - p(1)
         q(2) = - p(2)
         q(3) = - p(3)
         q(4) = - p(4)
         call v_spinor(q, -spin, u)
      else
         p_mag = sqrt(p(1)**2 + p(2)**2 + p(3)**2)
         pabz = p_mag + p(3)
         omega_U = sqrt(max(0d0, p(4) - spin * p_mag))
         omega_D = sqrt(max(0d0, p(4) + spin * p_mag))
         if (pabz .gt. eps*p_mag) then
	    coeff = 1d0 / sqrt(2 * p_mag * pabz)
	    if (spin .eq. 1) then
               u(1) = omega_U * coeff * pabz
               u(2) = omega_U * coeff * cmplx(p(1), p(2))
               u(3) = omega_D * coeff * pabz
               u(4) = omega_D * coeff * cmplx(p(1), p(2))
	    else
               u(1) = omega_U * coeff * cmplx(-p(1), p(2))
               u(2) = omega_U * coeff * pabz
               u(3) = omega_D * coeff * cmplx(-p(1), p(2))
               u(4) = omega_D * coeff * pabz
	    endif
         else
	    if (spin .eq. 1) then
               u(1) = 0d0
               u(2) = omega_U
               u(3) = 0d0
               u(4) = omega_D
	    else
               u(1) = - omega_U
               u(2) = 0d0
               u(3) = - omega_D
               u(4) = 0d0
	    endif
         endif
      endif
      end

C
C (2) v_spinor *****************************************************************
C
      subroutine v_spinor(p, spin, v)
c        calculate Dirac Spinor v as a 4by1 complex matrix
c        for a given helicity called spin=+-1 and momentum real*8 p(mu)
      implicit none
      real*8 p(4)
      integer spin
      complex*16 v(4)
      
      real*8 q(4), p_mag, omega_U, omega_D, eps, pabz, coeff
      parameter (eps = 1.d-10)
      
      if ((spin .ne. 1) .and. (spin .ne. -1)) then
         write(*,*) 'v_spinor: bad spin value', spin
         call exit(1)
      endif
      if (p(4) .lt. 0d0) then
         q(1) = - p(1)
         q(2) = - p(2)
         q(3) = - p(3)
         q(4) = - p(4)
         call u_spinor(q, -spin, v)
      else
         p_mag = sqrt(p(1)**2 + p(2)**2 + p(3)**2)
         pabz = p_mag + p(3)
         omega_U = sqrt(max(0d0, p(4) + spin * p_mag))
         omega_D = sqrt(max(0d0, p(4) - spin * p_mag))
         if (pabz .gt. eps*p_mag) then
	    coeff = 1d0 / sqrt(2 * p_mag * pabz)
	    if (spin .eq. 1) then
               v(1) = - omega_U * coeff * cmplx(-p(1), p(2))
               v(2) = - omega_U * coeff * pabz
               v(3) =   omega_D * coeff * cmplx(-p(1), p(2))
               v(4) =   omega_D * coeff * pabz
	    else
               v(1) =   omega_U * coeff * pabz
               v(2) =   omega_U * coeff * cmplx(p(1), p(2))
               v(3) = - omega_D * coeff * pabz
               v(4) = - omega_D * coeff * cmplx(p(1), p(2))
	    endif
         else
	    if (spin .eq. 1) then
               v(1) =   omega_U
               v(2) =   0d0
               v(3) = - omega_D
               v(4) =   0d0
	    else
               v(1) =   0d0
               v(2) =   omega_U
               v(3) =   0d0
               v(4) =   - omega_D
	    endif
         endif
      endif
      end
c

C (3) u_bar, v_bar -------------------------------------------
c
	SUBROUTINE CALUVB(XUV,XUVB)
	complex*16 XUV(4),XUVB(4)
	DO 5 I=1,2
	XUVB(I)=CONJG(XUV(I+2))
5	XUVB(I+2)=CONJG(XUV(I))
	RETURN
	END
c
C (4) psi1^bar*(a - b*gamma5)*gamma(mu)*v ***********
c
      subroutine current(psi1, a, b, v, out)
c
c calculate  out(mu) = psi1^bar*(a - b*gamma5)*gamma(mu)*v
c arbitrary psi1 and v
c [ with the convention of neutral & charged couplings in the book, say:
c     for W: a = 1;  b = -1
c     for Z: a = gv, b = ga
c
      implicit none
      complex*16 psi1(4), v(4), out(4)
      real*8 a, b
      
      real*8 x, y
      complex*16 u1, u2, u3, u4, I
      parameter (I = (0., 1.))
      
      x = a + b
      y = a - b
      
      u1 = conjg(psi1(3)) * x
      u2 = conjg(psi1(4)) * x
      u3 = conjg(psi1(1)) * y
      u4 = conjg(psi1(2)) * y
      
      out(1) =   u1*v(4) + u2*v(3) - u3*v(2) - u4*v(1)
      out(2) = (-u1*v(4) + u2*v(3) + u3*v(2) - u4*v(1)) * I
      out(3) =   u1*v(3) - u2*v(4) - u3*v(1) + u4*v(2)
      out(4) =   u1*v(3) + u2*v(4) + u3*v(1) + u4*v(2)
      
      end


C-(5)-slash_p_v-------------------------------------------
c
	SUBROUTINE slash_p_v(SQ,SV1,SV2)
	REAL*8 SQ(4),T1,T2,T3,T4  
	complex*16 SV1(4),SV2(4)

	T1=SQ(1)
	T2=SQ(2)
	T3=SQ(3)
	T4=SQ(4)
	
	SV2(1)=(T4-T3)*SV1(3)-CMPLX(T1,-T2)*SV1(4)
	SV2(2)=-CMPLX(T1,T2)*SV1(3)+(T4+T3)*SV1(4)
	SV2(3)=(T4+T3)*SV1(1)+CMPLX(T1,-T2)*SV1(2)
	SV2(4)=CMPLX(T1,T2)*SV1(1)+(T4-T3)*SV1(2)

10	RETURN
	END

C-(6)-Cslash_p_v-------------------------------------------
c
	SUBROUTINE Cslash_p_v(SQ,SV1,SV2)	
	complex*16 SQ(4), SV1(4),SV2(4), T1,T2,T3,T4,xi
	T1=SQ(1)
	T2=SQ(2)
	T3=SQ(3)
	T4=SQ(4)
        xi=CMPLX(0.,1.)
	
	SV2(1) = (T4-T3)   *SV1(3) -(T1-xi*T2)*SV1(4)
	SV2(2) =-(T1+xi*T2)*SV1(3) +(T4+T3)   *SV1(4)
	SV2(3) = (T4+T3)   *SV1(1) +(T1-xi*T2)*SV1(2)
	SV2(4) = (T1+xi*T2)*SV1(1) +(T4-T3)   *SV1(2)

	RETURN
	END

C-(7)-slash_p_m_v--------------------------------------------------------------
c
	SUBROUTINE slash_p_m_v(SQ,SV1,SV2,XM)
	REAL*8 SQ(4),XM 
	complex*16 SV1(4),SV2(4),SV(4)
	CALL slash_p_v(SQ,SV1,SV)
	DO 5 I=1,4
5	SV2(I)=SV(I)+XM*SV1(I)
	RETURN
	END

C-(8)-ubar_slash_p-----------------------------------------------------------
c
	SUBROUTINE ubar_slash_p(SQ,SV1,SV2)
	REAL*8 SQ(4),T1,T2,T3,T4 
	complex*16 SV1(4),SV2(4)

	T1=SQ(1)
	T2=SQ(2)
	T3=SQ(3)
	T4=SQ(4)

	SV2(1)=(T4+T3)*SV1(3)+CMPLX(T1,T2)*SV1(4)
	SV2(2)=CMPLX(T1,-T2)*SV1(3)+(T4-T3)*SV1(4)
	SV2(3)=(T4-T3)*SV1(1)-CMPLX(T1,T2)*SV1(2)
	SV2(4)=-CMPLX(T1,-T2)*SV1(1)+(T4+T3)*SV1(2)
10	RETURN
	END

C-(9)-ubar_slash_p_m-------------------------------------------------------------
c
	SUBROUTINE ubar_slash_p_m(SQ,SV1,SV2,XM)
	REAL*8 SQ(4),XM  
	complex*16 SV1(4),SV2(4),SV(4)
	CALL ubar_slash_p(SQ,SV1,SV)
	DO 5 I=1,4
5	SV2(I)=SV(I)+XM*SV1(I)
	RETURN
	END


C-(10)-PRUV--P_R*U=(1+gamma_5)/2 *U---------
c
        SUBROUTINE PRUV(U,PRU)
        complex*16 U(4),PRU(4)
        PRU(1)=(0.,0.)
        PRU(2)=(0.,0.)
        PRU(3)=U(3)
        PRU(4)=U(4)
        RETURN
        END

C-(11)-PLUV--P_L*U=(1-gamma_5)/2 *U---------
c
        SUBROUTINE PLUV(U,PLU)
        complex*16 U(4),PLU(4)
        PLU(1)=U(1)
        PLU(2)=U(2)
        PLU(3)=(0.,0.)
        PLU(4)=(0.,0.)
        RETURN
        END


c---------------------------------------------------------------------------
c                     gamma matrix
c---------------------------------------------------------------------------
C (12A) --0 RANK GAMMA MATRIX-----------------------------------------------
        SUBROUTINE GAMMA0_L(PL)
        COMPLEX*16 PL(4,4)
        INTEGER I,J

        DO I=1,4
           DO J=1,4
             PL(I,J)=0.
           ENDDO
        ENDDO

         PL(1,1)=1.
         PL(2,2)=1.
        RETURN
        END
C (12B) --0 RANK GAMMA MATRIX-----------------------------------------------

        SUBROUTINE GAMMA0_R(PR)
        COMPLEX*16 PR(4,4)
        INTEGER I,J

        DO I=1,4
           DO J=1,4
             PR(I,J)=0.
           ENDDO
        ENDDO

         PR(3,3)=1.
         PR(4,4)=1.
        RETURN
        END        
C---------------------------------------------------------------------------
C THE LAST TWO INDICES ARE SPINOR INDICES. WE ADOPT THIS CONVENTION FOR ALL
C THE GAMMA MATRIX.
C---------------------------------------------------------------------------
C (12C) --1 RANK GAMMA MATRIX-----------------------------------------------
        SUBROUTINE GAMMA1_L(V)
        COMPLEX*16 V(4,4,4)
        INTEGER I,J,K

        DO I=1,4
           DO J=1,4
              DO K=1,4
               V(I,J,K)=0.
              ENDDO
           ENDDO
        ENDDO

        V(1,3,2)=-1.
        V(1,4,1)=-1.
        V(2,3,2)= CMPLX(0.,1.)
        V(2,4,1)=- CMPLX(0.,1.)
        V(3,3,1)=-1.
        V(3,4,2)=1.
        V(4,3,1)=1.
        V(4,4,2)=1.
        RETURN
        END        
C (12D) --1 RANK GAMMA MATRIX------------------------------------------------
        SUBROUTINE GAMMA1_R(V)
        COMPLEX*16 V(4,4,4)
        INTEGER I,J,K

        DO I=1,4
           DO J=1,4
              DO K=1,4
               V(I,J,K)=0.
              ENDDO
           ENDDO
        ENDDO

        V(1,1,4)=1.
        V(1,2,3)=1.
        V(2,1,4)=- CMPLX(0.,1.)
        V(2,2,3)= CMPLX(0.,1.)
        V(3,1,3)=1.
        V(3,2,4)=-1.
        V(4,1,3)=1.
        V(4,2,4)=1.
        RETURN
        END        
C (12E)--2 RANK GAMMA MATRIX------------------------------------------------------

        SUBROUTINE GAMMA2_L(V)
        COMPLEX V(4,4,4,4)
        COMPLEX*16 V1(4,4,4), V2(4,4,4) 
        INTEGER I,J,K,L,M
        
        CALL GAMMA1_L(V2)
        CALL GAMMA1_R(V1)

        DO I=1,4
           DO J=1,4
              DO K=1,4
                 DO L=1,4
                 V(I,J,K,L)=0.
                 ENDDO
              ENDDO
           ENDDO
        ENDDO
        
        DO I=1,4
           DO J=1,4
              DO K=1,4
                 DO L=1,4
                    DO M=1,4
                       V(I,J,K,L)=V(I,J,K,L) + V1(I,K,M)*V2(J,M,L)
                    ENDDO
                 ENDDO
              ENDDO
           ENDDO
        ENDDO
       
        RETURN
        END        
C (12F)-- 2 RANK GAMMA MATRIX --------------------------------------------------
        SUBROUTINE GAMMA2_R(V)
        COMPLEX V(4,4,4,4)
        COMPLEX*16 V1(4,4,4), V2(4,4,4) 
        INTEGER I,J,K,L,M
        
        CALL GAMMA1_L(V1)
        CALL GAMMA1_R(V2)

        DO I=1,4
           DO J=1,4
              DO K=1,4
                 DO L=1,4
                 V(I,J,K,L)=0.
                 ENDDO
              ENDDO
           ENDDO
        ENDDO
        
        DO I=1,4
           DO J=1,4
              DO K=1,4
                 DO L=1,4
                    DO M=1,4
                       V(I,J,K,L)=V(I,J,K,L) + V1(I,K,M)*V2(J,M,L)
                    ENDDO
                 ENDDO
              ENDDO
           ENDDO
        ENDDO
       
        RETURN
        END              
C --ASYMMETRIC TENSOR-----------------------------------------------------------

       SUBROUTINE ASYM(EPS)
       COMPLEX EPS(4,4,4,4)
       INTEGER I1,I2,I3,I4

       DO I1=1,4
          DO I2=1,4
             DO I3=1,4
                DO I4=1,4
                EPS(I1,I2,I3,I4)=0.
                ENDDO
             ENDDO
          ENDDO
        ENDDO
      
        EPS(1,2,3,4)=-1.
        EPS(1,2,4,3)=1.
        EPS(1,3,2,4)=1.
        EPS(1,3,4,2)=-1.
        EPS(1,4,2,3)=-1.
        EPS(1,4,3,2)=1.
        EPS(2,1,3,4)=1.
        EPS(2,1,4,3)=-1.
        EPS(2,3,1,4)=-1.
        EPS(2,3,4,1)=1.
        EPS(2,4,1,3)=1.
        EPS(2,4,3,1)=-1.
        EPS(3,1,2,4)=-1.
        EPS(3,1,4,2)=1.
        EPS(3,2,1,4)=1.
        EPS(3,2,4,1)=-1.
        EPS(3,4,1,2)=-1.
        EPS(3,4,2,1)=1.
        EPS(4,1,2,3)=1.
        EPS(4,1,3,2)=-1.
        EPS(4,2,1,3)=-1.
        EPS(4,2,3,1)=1.
        EPS(4,3,1,2)=1.
        EPS(4,3,2,1)=-1.
        RETURN
        END

C (12G)--3 RANK GAMMA MATRIX--------------------------------------------------
        SUBROUTINE GAMMA3_L()
        COMPLEX V(4,4,4,4,4),V1(4,4,4,4,4),EPS(4,4,4,4)
        COMPLEX*16 V2(4,4,4)
        DOUBLE PRECISION G
        INTEGER I1,I2,I3,I4,I5,I6
        COMMON /GAMMA3L/V

        CALL GAMMA1_L(V2)
        CALL ASYM(EPS)

        DO I1=1,4
             DO I2=1,4
                DO I3=1,4
                   DO I4=1,4
                      DO I5=1,4
                         V1(I1,I2,I3,I4,I5)=0.
                      ENDDO
                   ENDDO
                ENDDO
             ENDDO
        ENDDO
       

       DO I1=1,4
          DO I2=1,4
             DO I3=1,4
                DO I4=1,4
                   DO I5=1,4
                      DO I6=1,4
         V1(I1,I2,I3,I4,I5)=V1(I1,I2,I3,I4,I5) + EPS(I6,I1,I2,I3)*
     &            G(I6,I6)*V2(I6,I4,I5)
                      ENDDO
                   ENDDO
                ENDDO
             ENDDO
          ENDDO
       ENDDO
       
       DO I1=1,4
          DO I2=1,4
             DO I3=1,4
                DO I4=1,4
                   DO I5=1,4
          V(I1,I2,I3,I4,I5)= G(I1,I2)*V2(I3,I4,I5) + 
     &         G(I2,I3)*V2(I1,I4,I5) - G(I1,I3)*V2(I2,I4,I5) +
     &         CMPLX(0,1)*V1(I1,I2,I3,I4,I5)
                   ENDDO
                ENDDO
             ENDDO
          ENDDO
       ENDDO

       END        
        
C (12H)--3 RANK GAMMA MATRIX-----------------------------------------
        SUBROUTINE GAMMA3_R()
        COMPLEX V(4,4,4,4,4),V1(4,4,4,4,4),EPS(4,4,4,4)
        COMPLEX*16 V2(4,4,4)
        DOUBLE PRECISION G
        INTEGER I1,I2,I3,I4,I5,I6
        COMMON /GAMMA3R/V

        CALL GAMMA1_R(V2)
        CALL ASYM(EPS)

        DO I1=1,4
             DO I2=1,4
                DO I3=1,4
                   DO I4=1,4
                      DO I5=1,4
                         V1(I1,I2,I3,I4,I5)=0.
                      ENDDO
                   ENDDO
                ENDDO
             ENDDO
        ENDDO
       

       DO I1=1,4
          DO I2=1,4
             DO I3=1,4
                DO I4=1,4
                   DO I5=1,4
                      DO I6=1,4
         V1(I1,I2,I3,I4,I5)=V1(I1,I2,I3,I4,I5) + EPS(I6,I1,I2,I3)*
     &            G(I6,I6)*V2(I6,I4,I5)
                      ENDDO
                   ENDDO
                ENDDO
             ENDDO
          ENDDO
       ENDDO
       
       DO I1=1,4
          DO I2=1,4
             DO I3=1,4
                DO I4=1,4
                   DO I5=1,4
          V(I1,I2,I3,I4,I5)= G(I1,I2)*V2(I3,I4,I5) + 
     &         G(I2,I3)*V2(I1,I4,I5) - G(I1,I3)*V2(I2,I4,I5) -
     &         CMPLX(0,1)*V1(I1,I2,I3,I4,I5)
                   ENDDO
                ENDDO
             ENDDO
          ENDDO
       ENDDO

       END
                
C (12I)--4 RANK GAMMA MATRIX ------------------------------------------
        SUBROUTINE GAMMA4_L()
        COMPLEX V(4,4,4,4,4,4),EPS(4,4,4,4),V1(4,4,4,4),V2(4,4,4,4)
        COMPLEX*16 P(4,4)
        DOUBLE PRECISION G
        INTEGER I1,I2,I3,I4,I5,I6
        COMMON /GAMMA4L/V

        CALL GAMMA0_L(P)
        CALL GAMMA2_L(V1)
        CALL ASYM(EPS)

        DO I1=1,4
           DO I2=1,4
              DO I3=1,4
                 DO I4=1,4
             V2(I1,I2,I3,I4)=1./2.*( V1(I1,I2,I3,I4) - V1(I2,I1,I3,I4) )
                 ENDDO
              ENDDO
           ENDDO
        ENDDO
        
                
        DO I1=1,4
          DO I2=1,4
             DO I3=1,4
                DO I4=1,4
                   DO I5=1,4
                      DO I6=1,4
         V(I1,I2,I3,I4,I5,I6) =(G(I1,I4)*G(I2,I3) - G(I1,I3)*G(I2,I4) +
     &     G(I1,I2)*G(I3,I4) + CMPLX(0.,1.)*EPS(I1,I2,I3,I4) )*P(I5,I6)
     &     + G(I3,I4)*V2(I1,I2,I5,I6) - G(I2,I4)*V2(I1,I3,I5,I6)
     &     + G(I2,I3)*V2(I1,I4,I5,I6) + G(I1,I4)*V2(I2,I3,I5,I6)
     &     + G(I1,I2)*V2(I3,I4,I5,I6) - G(I1,I3)*V2(I2,I4,I5,I6)
                      ENDDO
                   ENDDO
                ENDDO
             ENDDO
          ENDDO
        ENDDO
       
        RETURN
        END

C (12J)--4 RANK GAMMA MATRIX----------------------------------------------
        SUBROUTINE GAMMA4_R()
        COMPLEX V(4,4,4,4,4,4),EPS(4,4,4,4),V1(4,4,4,4),V2(4,4,4,4)
        COMPLEX*16 P(4,4)
        DOUBLE PRECISION G
        INTEGER I1,I2,I3,I4,I5,I6
        COMMON /GAMMA4R/V

        CALL GAMMA0_R(P)
        CALL GAMMA2_R(V1)
        CALL ASYM(EPS)

        DO I1=1,4
           DO I2=1,4
              DO I3=1,4
                 DO I4=1,4
             V2(I1,I2,I3,I4)=1./2.*( V1(I1,I2,I3,I4) - V1(I2,I1,I3,I4) )
                 ENDDO
              ENDDO
           ENDDO
        ENDDO
        
                
        DO I1=1,4
          DO I2=1,4
             DO I3=1,4
                DO I4=1,4
                   DO I5=1,4
                      DO I6=1,4
         V(I1,I2,I3,I4,I5,I6) =(G(I1,I4)*G(I2,I3) - G(I1,I3)*G(I2,I4) +
     &     G(I1,I2)*G(I3,I4) - CMPLX(0.,1.)*EPS(I1,I2,I3,I4) )*P(I5,I6)
     &     + G(I3,I4)*V2(I1,I2,I5,I6) - G(I2,I4)*V2(I1,I3,I5,I6)
     &     + G(I2,I3)*V2(I1,I4,I5,I6) + G(I1,I4)*V2(I2,I3,I5,I6)
     &     + G(I1,I2)*V2(I3,I4,I5,I6) - G(I1,I3)*V2(I2,I4,I5,I6)
                      ENDDO
                   ENDDO
                ENDDO
             ENDDO
          ENDDO
        ENDDO
       
        RETURN
        END

C (12K)--5 RANK GAMMA MATRIX---------------------------------------------
        SUBROUTINE GAMMA5_L()
        COMPLEX V(4,4,4,4,4,4,4),V1(4,4,4,4,4),EPS(4,4,4,4)
        COMPLEX*16 V2(4,4,4)
        DOUBLE PRECISION G
        INTEGER I1,I2,I3,I4,I5,I6,I7,I8,M1,M2,M3,M4,M5,M6,M7
        COMMON /GAMMA5L/V

        CALL GAMMA1_L(V2)
        CALL ASYM(EPS)

        DO I1=1,4
             DO I2=1,4
                DO I3=1,4
                   DO I4=1,4
                      DO I5=1,4
                         V1(I1,I2,I3,I4,I5)=0.
                      ENDDO
                   ENDDO
                ENDDO
             ENDDO
        ENDDO
       

       DO I1=1,4
          DO I2=1,4
             DO I3=1,4
                DO I4=1,4
                   DO I5=1,4
                      DO I6=1,4
         V1(I1,I2,I3,I4,I5)=V1(I1,I2,I3,I4,I5) + EPS(I6,I1,I2,I3)*
     &            G(I6,I6)*V2(I6,I4,I5)
                      ENDDO
                   ENDDO
                ENDDO
             ENDDO
          ENDDO
       ENDDO

       DO M1=1,4
           DO M2=1,4
              DO M3=1,4
                 DO M4=1,4
                    DO M5=1,4
                       DO M6=1,4
                          DO M7=1,4
         V(M1,M2,M3,M4,M5,M6,M7)=( G(M2,M5)*G(M3,M4) - G(M2,M4)*G(M3,M5)
     &           + G(M2,M3)*G(M4,M5))*V2(M1,M6,M7) + 
     &           (-G(M1,M5)*G(M3,M4) + G(M1,M4)*G(M3,M5) - 
     &             G(M1,M3)*G(M4,M5))*V2(M2,M6,M7) +
     &           (G(M1,M5)*G(M2,M4) - G(M1,M4)*G(M2,M5) + 
     &             G(M1,M2)*G(M4,M5))*V2(M3,M6,M7)+     
     &           (-G(M1,M5)*G(M2,M3) + G(M1,M3)*G(M2,M5) - 
     &             G(M1,M2)*G(M3,M5))*V2(M4,M6,M7) +
     &           (G(M1,M4)*G(M2,M3) - G(M1,M3)*G(M2,M4) + 
     &             G(M1,M2)*G(M3,M4))*V2(M5,M6,M7) + CMPLX(0.,1.)*
     &   (( V1(M3,M4,M5,M6,M7)*G(M1,M2) - V1(M2,M4,M5,M6,M7)*G(M1,M3) +
     &      V1(M2,M3,M5,M6,M7)*G(M1,M4) - V1(M2,M3,M4,M6,M7)*G(M1,M5) +
     &      V1(M1,M4,M5,M6,M7)*G(M2,M3) - V1(M1,M3,M5,M6,M7)*G(M2,M4) +
     &      V1(M1,M3,M4,M6,M7)*G(M2,M5) + V1(M1,M2,M5,M6,M7)*G(M3,M4) -
     &      V1(M1,M2,M4,M6,M7)*G(M3,M5) + V1(M1,M2,M3,M6,M7)*G(M4,M5) )
     &   + EPS(M2,M3,M4,M5)*V2(M1,M6,M7) - EPS(M1,M3,M4,M5)*V2(M2,M6,M7)
     &   + EPS(M1,M2,M4,M5)*V2(M3,M6,M7) - EPS(M1,M2,M3,M5)*V2(M4,M6,M7)
     &   + EPS(M1,M2,M3,M4)*V2(M5,M6,M7) )
                         ENDDO
                      ENDDO
                   ENDDO
                ENDDO
              ENDDO
           ENDDO
       ENDDO
       END       

C (12L)--5 RANK GAMMA MATRIX ---------------------------------------------
        SUBROUTINE GAMMA5_R()
        COMPLEX V(4,4,4,4,4,4,4),V1(4,4,4,4,4),EPS(4,4,4,4)
        COMPLEX*16 V2(4,4,4)
        DOUBLE PRECISION G
        INTEGER I1,I2,I3,I4,I5,I6,I7,I8,M1,M2,M3,M4,M5,M6,M7
        COMMON /GAMMA5R/V

        CALL GAMMA1_R(V2)
        CALL ASYM(EPS)

        DO I1=1,4
             DO I2=1,4
                DO I3=1,4
                   DO I4=1,4
                      DO I5=1,4
                         V1(I1,I2,I3,I4,I5)=0.
                      ENDDO
                   ENDDO
                ENDDO
             ENDDO
        ENDDO
       

       DO I1=1,4
          DO I2=1,4
             DO I3=1,4
                DO I4=1,4
                   DO I5=1,4
                      DO I6=1,4
         V1(I1,I2,I3,I4,I5)=V1(I1,I2,I3,I4,I5) + EPS(I6,I1,I2,I3)*
     &            G(I6,I6)*V2(I6,I4,I5)
                      ENDDO
                   ENDDO
                ENDDO
             ENDDO
          ENDDO
       ENDDO

       DO M1=1,4
           DO M2=1,4
              DO M3=1,4
                 DO M4=1,4
                    DO M5=1,4
                       DO M6=1,4
                          DO M7=1,4
         V(M1,M2,M3,M4,M5,M6,M7)=( G(M2,M5)*G(M3,M4) - G(M2,M4)*G(M3,M5)
     &           + G(M2,M3)*G(M4,M5))*V2(M1,M6,M7) + 
     &           (-G(M1,M5)*G(M3,M4) + G(M1,M4)*G(M3,M5) - 
     &             G(M1,M3)*G(M4,M5))*V2(M2,M6,M7) +
     &           (G(M1,M5)*G(M2,M4) - G(M1,M4)*G(M2,M5) + 
     &             G(M1,M2)*G(M4,M5))*V2(M3,M6,M7)+     
     &           (-G(M1,M5)*G(M2,M3) + G(M1,M3)*G(M2,M5) - 
     &             G(M1,M2)*G(M3,M5))*V2(M4,M6,M7) +
     &           (G(M1,M4)*G(M2,M3) - G(M1,M3)*G(M2,M4) + 
     &             G(M1,M2)*G(M3,M4))*V2(M5,M6,M7) - CMPLX(0.,1.)*
     &   (( V1(M3,M4,M5,M6,M7)*G(M1,M2) - V1(M2,M4,M5,M6,M7)*G(M1,M3) +
     &      V1(M2,M3,M5,M6,M7)*G(M1,M4) - V1(M2,M3,M4,M6,M7)*G(M1,M5) +
     &      V1(M1,M4,M5,M6,M7)*G(M2,M3) - V1(M1,M3,M5,M6,M7)*G(M2,M4) +
     &      V1(M1,M3,M4,M6,M7)*G(M2,M5) + V1(M1,M2,M5,M6,M7)*G(M3,M4) -
     &      V1(M1,M2,M4,M6,M7)*G(M3,M5) + V1(M1,M2,M3,M6,M7)*G(M4,M5) )
     &   + EPS(M2,M3,M4,M5)*V2(M1,M6,M7) - EPS(M1,M3,M4,M5)*V2(M2,M6,M7)
     &   + EPS(M1,M2,M4,M5)*V2(M3,M6,M7) - EPS(M1,M2,M3,M5)*V2(M4,M6,M7)
     &   + EPS(M1,M2,M3,M4)*V2(M5,M6,M7) )
                         ENDDO
                      ENDDO
                   ENDDO
                ENDDO
              ENDDO
           ENDDO
       ENDDO
       END       


C (13A)-----------V1 PL V2-------------------------------------------------

       SUBROUTINE TENSOR0_L(SV1,SV2,OUT)
       COMPLEX*16 SV1(4),SV2(4),OUT

       OUT = SV1(1)*SV2(1) + SV1(2)*SV2(2)

       RETURN
       END

C (13B)---------- V1 PR V2 ------------------------------------------------
       SUBROUTINE TENSOR0_R(SV1,SV2,OUT)
       COMPLEX*16 SV1(4),SV2(4),OUT

       OUT = SV1(3)*SV2(3) + SV1(4)*SV2(4)

       RETURN
       END

C (13C)---V1 GAMMA^\MU PL V2 ----------------------------------
C        V1_1L_V2(V1,V2,OUT) 

       SUBROUTINE TENSOR1_L(SV1,SV2,OUT)
       COMPLEX*16 SV1(4),SV2(4),OUT(4)

       OUT(1)=-SV1(4)*SV2(1)-SV1(3)*SV2(2)
       OUT(2)=CMPLX(0.,-1.)*(SV1(4)*SV2(1)-SV1(3)*SV2(2))
       OUT(3)=-SV1(3)*SV2(1)+SV1(4)*SV2(2)
       OUT(4)=SV1(3)*SV2(1)+SV1(4)*SV2(2)
       RETURN
       END

C (13D)---V1 GAMMA^\MU PR V2 ----------------------------------


       SUBROUTINE TENSOR1_R(SV1,SV2,OUT)
       COMPLEX*16 SV1(4),SV2(4),OUT(4)

       OUT(1)=SV1(2)*SV2(3)+SV1(1)*SV2(4)
       OUT(2)=CMPLX(0.,1.)*(SV1(2)*SV2(3)-SV1(1)*SV2(4))
       OUT(3)=SV1(1)*SV2(3)-SV1(2)*SV2(4)
       OUT(4)=SV1(1)*SV2(3)+SV1(2)*SV2(4)
       RETURN
       END


C (13E)---V1 GAMMA^\MU GAMMA^\NU  PL V2 ----------------------------------

       SUBROUTINE TENSOR2_L(SV1,SV2,OUT)
       COMPLEX*16 SV1(4),SV2(4),OUT(4,4)
       COMPLEX  V(4,4,4,4)
       INTEGER I1,I2,I3,I4
       
       CALL GAMMA2_L(V)
        DO I1=1,4
           DO I2=1,4
             OUT(I1,I2)=0.
           ENDDO
        ENDDO

       DO I1=1,4
          DO I2=1,4
             DO I3=1,4
                DO I4=1,4
          OUT(I1,I2)=OUT(I1,I2) + SV1(I3)*V(I1,I2,I3,I4)*SV2(I4)
                ENDDO
             ENDDO
          ENDDO
       ENDDO

       RETURN
       END


C (13F)---V1 GAMMA^\MU GAMMA^\NU  PR V2 ----------------------------------

       SUBROUTINE TENSOR2_R(SV1,SV2,OUT)
       COMPLEX*16 SV1(4),SV2(4),OUT(4,4)
       COMPLEX  V(4,4,4,4)
       INTEGER I1,I2,I3,I4
       
       CALL GAMMA2_R(V)
        DO I1=1,4
           DO I2=1,4
             OUT(I1,I2)=0.
           ENDDO
        ENDDO

       DO I1=1,4
          DO I2=1,4
             DO I3=1,4
                DO I4=1,4
          OUT(I1,I2)=OUT(I1,I2) + SV1(I3)*V(I1,I2,I3,I4)*SV2(I4)
                ENDDO
             ENDDO
          ENDDO
       ENDDO

       RETURN
       END
 


C (13G)---V1 GAMMA^\MU GAMMA^\NU  GAMMA^\RHO PL V2 ----------------------

       SUBROUTINE TENSOR3_L(SV1,SV2,OUT)
       COMPLEX*16 SV1(4),SV2(4),OUT(4,4,4)
       COMPLEX  V(4,4,4,4,4)
       INTEGER I1,I2,I3,I4,I5
       COMMON /GAMMA3L/V

        DO I1=1,4
           DO I2=1,4
              DO I3=1,4
             OUT(I1,I2,I3)=0.
              ENDDO
           ENDDO
        ENDDO

       DO I1=1,4
          DO I2=1,4
             DO I3=1,4
                DO I4=1,4
                   DO I5=1,4
        OUT(I1,I2,I3)=OUT(I1,I2,I3) + SV1(I4)*V(I1,I2,I3,I4,I5)*SV2(I5)
                   ENDDO
                ENDDO
             ENDDO
          ENDDO
       ENDDO

       RETURN
       END
 
C (13H)---V1 GAMMA^\MU GAMMA^\NU  GAMMA^\RHO PR V2 ------------------------
       SUBROUTINE TENSOR3_R(SV1,SV2,OUT)
       COMPLEX*16 SV1(4),SV2(4),OUT(4,4,4)
       COMPLEX  V(4,4,4,4,4)
       INTEGER I1,I2,I3,I4,I5
       COMMON /GAMMA3R/V

        DO I1=1,4
           DO I2=1,4
              DO I3=1,4
             OUT(I1,I2,I3)=0.
              ENDDO
           ENDDO
        ENDDO

       DO I1=1,4
          DO I2=1,4
             DO I3=1,4
                DO I4=1,4
                   DO I5=1,4
        OUT(I1,I2,I3)=OUT(I1,I2,I3) + SV1(I4)*V(I1,I2,I3,I4,I5)*SV2(I5)
                   ENDDO
                ENDDO
             ENDDO
          ENDDO
       ENDDO

       RETURN
       END


C (13I)---V1 GAMMA^\MU GAMMA^\NU  GAMMA^\RHO GAMMA^\LAM PL V2 ----------------

       SUBROUTINE TENSOR4_L(SV1,SV2,OUT)
       COMPLEX*16 SV1(4),SV2(4),OUT(4,4,4,4)
       COMPLEX  V(4,4,4,4,4,4)
       INTEGER I1,I2,I3,I4,I5,I6
       COMMON /GAMMA4L/V

        DO I1=1,4
           DO I2=1,4
              DO I3=1,4
                 DO I4=1,4
             OUT(I1,I2,I3,I4)=0.
                 ENDDO
              ENDDO
           ENDDO
        ENDDO

       DO I1=1,4
          DO I2=1,4
             DO I3=1,4
                DO I4=1,4
                   DO I5=1,4
                      DO I6=1,4
        OUT(I1,I2,I3,I4)=OUT(I1,I2,I3,I4) + 
     &                  SV1(I5)*V(I1,I2,I3,I4,I5,I6)*SV2(I6)
                      ENDDO
                   ENDDO
                ENDDO
             ENDDO
          ENDDO
       ENDDO

       RETURN
       END

C (13J)---V1 GAMMA^\MU GAMMA^\NU  GAMMA^\RHO GAMMA^\LAM PR V2 ----------------

       SUBROUTINE TENSOR4_R(SV1,SV2,OUT)
       COMPLEX*16 SV1(4),SV2(4),OUT(4,4,4,4)
       COMPLEX  V(4,4,4,4,4,4)
       INTEGER I1,I2,I3,I4,I5,I6
       COMMON /GAMMA4R/V

        DO I1=1,4
           DO I2=1,4
              DO I3=1,4
                 DO I4=1,4
             OUT(I1,I2,I3,I4)=0.
                 ENDDO
              ENDDO
           ENDDO
        ENDDO

       DO I1=1,4
          DO I2=1,4
             DO I3=1,4
                DO I4=1,4
                   DO I5=1,4
                      DO I6=1,4
        OUT(I1,I2,I3,I4)=OUT(I1,I2,I3,I4) + 
     &                  SV1(I5)*V(I1,I2,I3,I4,I5,I6)*SV2(I6)
                      ENDDO
                   ENDDO
                ENDDO
             ENDDO
          ENDDO
       ENDDO

       RETURN
       END

C (13K)---V1 GAMMA^\MU GAMMA^\NU  GAMMA^\RHO GAMMA^\LAM GAMMA^\TAU PL V2 ----------------

       SUBROUTINE TENSOR5_L(SV1,SV2,OUT)
       COMPLEX*16 SV1(4),SV2(4),OUT(4,4,4,4,4)
       COMPLEX  V(4,4,4,4,4,4,4)
       INTEGER I1,I2,I3,I4,I5,I6,I7
       COMMON /GAMMA5L/V

        DO I1=1,4
           DO I2=1,4
              DO I3=1,4
                 DO I4=1,4
                    DO I5=1,4
             OUT(I1,I2,I3,I4,I5)=0.
                    ENDDO
                 ENDDO
              ENDDO
           ENDDO
        ENDDO

       DO I1=1,4
          DO I2=1,4
             DO I3=1,4
                DO I4=1,4
                   DO I5=1,4
                      DO I6=1,4
                         DO I7=1,4
        OUT(I1,I2,I3,I4,I5)=OUT(I1,I2,I3,I4,I5) + 
     &                  SV1(I6)*V(I1,I2,I3,I4,I5,I6,I7)*SV2(I7)
                         ENDDO
                      ENDDO
                   ENDDO
                ENDDO
             ENDDO
          ENDDO
       ENDDO

       RETURN
       END
C (13L)---V1 GAMMA^\MU GAMMA^\NU  GAMMA^\RHO GAMMA^\LAM GAMMA^\TAU PR V2 ----------------

       SUBROUTINE TENSOR5_R(SV1,SV2,OUT)
       COMPLEX*16 SV1(4),SV2(4),OUT(4,4,4,4,4)
       COMPLEX  V(4,4,4,4,4,4,4)
       INTEGER I1,I2,I3,I4,I5,I6,I7
       COMMON /GAMMA5R/V

        DO I1=1,4
           DO I2=1,4
              DO I3=1,4
                 DO I4=1,4
                    DO I5=1,4
             OUT(I1,I2,I3,I4,I5)=0.
                    ENDDO
                 ENDDO
              ENDDO
           ENDDO
        ENDDO

       DO I1=1,4
          DO I2=1,4
             DO I3=1,4
                DO I4=1,4
                   DO I5=1,4
                      DO I6=1,4
                         DO I7=1,4
        OUT(I1,I2,I3,I4,I5)=OUT(I1,I2,I3,I4,I5) + 
     &                  SV1(I6)*V(I1,I2,I3,I4,I5,I6,I7)*SV2(I7)
                         ENDDO
                      ENDDO
                   ENDDO
                ENDDO
             ENDDO
          ENDDO
       ENDDO

       RETURN
       END


C--(14) epsilon_mu----------------------------------------------------------
c
	SUBROUTINE epsilon_mu(P,epsi,Ip)
	REAL*8 P(4),XM,PXY,PMAG
        complex*16 epsi(4),  epsi_p(4),  epsi_m(4),  epsi_0(4) 

            if(P(4)**2-P(1)**2-P(2)**2-P(3)**2.lt.0.) then
c            write(*,*) 'squre-root negative in  epsilon_mu !'
            xm=0.
            else
            XM   = sqrt( P(4)**2-P(1)**2-P(2)**2-P(3)**2 )
            end if

        Pxy =  sqrt( P(1)**2+P(2)**2 )
        Pmag = sqrt( P(1)**2+P(2)**2+P(3)**2 )

c------
        IF(Pxy .GE. 1.0e-5) THEN       
          epsi_p(4) = 0.
          epsi_p(1) = CMPLX( -p(1)*p(3)/pmag,  p(2) )/pxy/sqrt(2.)
          epsi_p(2) = CMPLX( -p(2)*p(3)/pmag, -p(1) )/pxy/sqrt(2.)
          epsi_p(3) = pxy/pmag/sqrt(2.)

          epsi_m(4) = 0.
          epsi_m(1) = CMPLX( -p(1)*p(3)/pmag, -p(2) )/pxy/sqrt(2.)
          epsi_m(2) = CMPLX( -p(2)*p(3)/pmag,  p(1) )/pxy/sqrt(2.)
          epsi_m(3) = pxy/pmag/sqrt(2.)

          ELSE

          epsi_p(4) = 0.
          epsi_p(1) = 1./sqrt(2.)
          epsi_p(2) = CMPLX(0., 1.) /sqrt(2.)
          epsi_p(3) = 0.

          epsi_m(4) = 0.
          epsi_m(1) = 1./sqrt(2.)
          epsi_m(2) = -CMPLX(0., 1.) /sqrt(2.)
          epsi_m(3) = 0.

        END IF

         IF(XM .GE. 1.0e-5) THEN  
          epsi_0(4) = Pmag/XM
          epsi_0(1) = p(1)/Pmag *p(4)/Xm
          epsi_0(2) = p(2)/Pmag *p(4)/Xm
          epsi_0(3) = p(3)/Pmag *p(4)/Xm
          ELSE
          epsi_0(4) = 0.
          epsi_0(1) = 0.
          epsi_0(2) = 0.
          epsi_0(3) = 0.
          END IF

        IF(IP.eq.1) then
          DO i=1,4
          epsi(i) = epsi_p(i)
          END DO 
        END IF

        IF(IP.eq.2) then
          DO i=1,4
          epsi(i) = epsi_m(i)
          END DO 
        END IF

        IF(IP.eq.3) then
          DO i=1,4
          epsi(i) = epsi_0(i)
          END DO 
        END IF

	RETURN
	END

c (15) mat_sp_mul(v,sv1,out)-------------------------------------------------
        SUBROUTINE MAT_SP_MUL(V,SV1,OUT)
        COMPLEX*16  V(4,4), SV1(4), OUT(4)
        INTEGER I1,I2
        
        DO I1=1,4
           OUT(I1)=0.
        ENDDO

        DO I1=1,4
           DO I2=1,4
           OUT(I1) = OUT(I1) + V(I1,I2)*SV1(I2)
           ENDDO
        ENDDO

        END

C some small functions
c  (a) guage tensor g(i,j)************************************************
       FUNCTION G(I,J)

       INTEGER I,J
       DOUBLE PRECISION G

       IF(I.EQ.J) THEN
          IF(I.EQ.4) THEN
          G=1.
          ELSE
          G=-1.
          ENDIF
       ELSE
          G=0.
       ENDIF
       RETURN
       END

C (a1) DOT(A,B) **********************************************************
c
	FUNCTION DOT(A,B)
C	THIS FUNCTION IS THE DOT PRODUCT OF 4-VECTORS A AND B.
	double precision  A(4), B(4),DOT
	DOT = A(4)*B(4) - A(1)*B(1) - A(2)*B(2) - A(3)*B(3)
	RETURN
	END
c
C (a2) DOT2(A,B) ***********************************************************
c
	FUNCTION DOT2(A,B)
C	THIS FUNCTION RETURNS THE TRANSVERSE MONENTUM DOT PRODUCT.
	REAL*8 A(4), B(4),DOT2
	DOT2	= A(1)*B(1) + A(2)*B(2) 
	RETURN
	END
c
C (a3)  CDOT(A,B) **********************************************************
c
	FUNCTION  CDOT(A,B)
C	THIS FUNCTION IS THE DOT PRODUCT OF one real vector A and one  complex 
c        product of B
        real*8  A(4)
	COMPLEX*16 B(4), CDOT
	CDOT = A(4)*B(4) - A(1)*B(1) - A(2)*B(2) - A(3)*B(3)
	RETURN
	END
c
C (a4) CCDOT(A,B) **********************************************************
c
	FUNCTION CCDOT(A,B)
C	THIS FUNCTION IS THE COMPLEX DOT PRODUCT OF 
C	TWO COMPLEX-4-VECTORS A AND B.
	COMPLEX*16 A(4), B(4), CCDOT
	CCDOT = A(4)*B(4) - A(1)*B(1) - A(2)*B(2) - A(3)*B(3)
	RETURN
	END
c
c (a5) CDOT_vv(v1,v2) -----------
c
	function cdot_vv(SQ1,SQ2)
	complex*16 cdot_vv, SQ1(4),SQ2(4)
	cdot_vv=SQ1(1)*SQ2(1)+SQ1(2)*SQ2(2)+SQ1(3)*SQ2(3)+SQ1(4)*SQ2(4)
	RETURN
	END
