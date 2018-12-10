module bessel_mod

contains

  REAL (KIND=8) FUNCTION BESSI0(X)
  
    REAL *8 X,Y,P1,P2,P3,P4,P5,P6,P7,  &
         Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,AX,BX
    DATA P1,P2,P3,P4,P5,P6,P7/1.D0,3.5156229D0,3.0899424D0,1.2067429D0,  &
         0.2659732D0,0.360768D-1,0.45813D-2/
    DATA Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9/0.39894228D0,0.1328592D-1, &
         0.225319D-2,-0.157565D-2,0.916281D-2,-0.2057706D-1,  &
         0.2635537D-1,-0.1647633D-1,0.392377D-2/
    IF(ABS(X).LT.3.75D0) THEN
       Y=(X/3.75D0)**2
       BESSI0=P1+Y*(P2+Y*(P3+Y*(P4+Y*(P5+Y*(P6+Y*P7)))))
    ELSE
       AX=ABS(X)
       Y=3.75D0/AX
       BX=EXP(AX)/SQRT(AX)
       AX=Q1+Y*(Q2+Y*(Q3+Y*(Q4+Y*(Q5+Y*(Q6+Y*(Q7+Y*(Q8+Y*Q9)))))))
       BESSI0=AX*BX
    ENDIF
    RETURN
  END FUNCTION BESSI0

!-----------------------------------------------------------------------

  REAL (KIND=8) FUNCTION BESSI1(X)
  
    REAL *8 X,Y,P1,P2,P3,P4,P5,P6,P7,  &
         Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,AX,BX
    DATA P1,P2,P3,P4,P5,P6,P7/0.5D0,0.87890594D0,0.51498869D0,  &
         0.15084934D0,0.2658733D-1,0.301532D-2,0.32411D-3/
    DATA Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9/0.39894228D0,-0.3988024D-1, &
         -0.362018D-2,0.163801D-2,-0.1031555D-1,0.2282967D-1, &
         -0.2895312D-1,0.1787654D-1,-0.420059D-2/
    IF(ABS(X).LT.3.75D0) THEN
       Y=(X/3.75D0)**2
       BESSI1=X*(P1+Y*(P2+Y*(P3+Y*(P4+Y*(P5+Y*(P6+Y*P7))))))
    ELSE
       AX=ABS(X)
       Y=3.75D0/AX
       BX=EXP(AX)/SQRT(AX)
       AX=Q1+Y*(Q2+Y*(Q3+Y*(Q4+Y*(Q5+Y*(Q6+Y*(Q7+Y*(Q8+Y*Q9)))))))
       BESSI1=AX*BX
    ENDIF
    RETURN
  END FUNCTION BESSI1

!-----------------------------------------------------------------------

  REAL (KIND=8) FUNCTION BESSI(N,X)

    PARAMETER (IACC = 40,BIGNO = 1.D10, BIGNI = 1.D-10)
    REAL *8 X,TOX,BIM,BI,BIP
    
    IF (N.EQ.0) THEN
       BESSI = BESSI0(X)
       RETURN
    ENDIF
    IF (N.EQ.1) THEN
       BESSI = BESSI1(X)
       RETURN
    ENDIF
    IF(X.EQ.0.D0) THEN
       BESSI=0.D0
       RETURN
    ENDIF
    TOX = 2.D0/X
    BIP = 0.D0
    BI  = 1.D0
    BESSI = 0.D0
    M = 2*((N+INT(SQRT(FLOAT(IACC*N)))))
    DO J = M,1,-1
       BIM = BIP+DFLOAT(J)*TOX*BI
       BIP = BI
       BI  = BIM
       IF (ABS(BI).GT.BIGNO) THEN
          BI  = BI*BIGNI
          BIP = BIP*BIGNI
          BESSI = BESSI*BIGNI
       ENDIF
       IF (J.EQ.N) BESSI = BIP
    END DO
    BESSI = BESSI*BESSI0(X)/BI
    RETURN
  END FUNCTION BESSI

!-----------------------------------------------------------------------

  REAL (KIND=8) FUNCTION BESSK0(X)

    REAL*8 X,Y,AX,P1,P2,P3,P4,P5,P6,P7,Q1,Q2,Q3,Q4,Q5,Q6,Q7

    DATA P1,P2,P3,P4,P5,P6,P7/-0.57721566D0,0.42278420D0,0.23069756D0, &
         0.3488590D-1,0.262698D-2,0.10750D-3,0.74D-5/
    DATA Q1,Q2,Q3,Q4,Q5,Q6,Q7/1.25331414D0,-0.7832358D-1,0.2189568D-1, & 
         -0.1062446D-1,0.587872D-2,-0.251540D-2,0.53208D-3/
    IF(X.EQ.0.D0) THEN
       BESSK0=1.D30
       RETURN
    ENDIF
    IF(X.LE.2.D0) THEN
       Y=X*X/4.D0
       AX=-LOG(X/2.D0)*BESSI0(X)
       BESSK0=AX+(P1+Y*(P2+Y*(P3+Y*(P4+Y*(P5+Y*(P6+Y*P7))))))
    ELSE
       Y=(2.D0/X)
       AX=EXP(-X)/SQRT(X)
       BESSK0=AX*(Q1+Y*(Q2+Y*(Q3+Y*(Q4+Y*(Q5+Y*(Q6+Y*Q7))))))
    ENDIF
    RETURN
  END FUNCTION BESSK0

!-----------------------------------------------------------------------

  REAL (KIND=8) FUNCTION BESSK1(X)

    REAL*8 X,Y,AX,P1,P2,P3,P4,P5,P6,P7,Q1,Q2,Q3,Q4,Q5,Q6,Q7

    DATA P1,P2,P3,P4,P5,P6,P7/1.D0,0.15443144D0,-0.67278579D0,  &
         -0.18156897D0,-0.1919402D-1,-0.110404D-2,-0.4686D-4/
    DATA Q1,Q2,Q3,Q4,Q5,Q6,Q7/1.25331414D0,0.23498619D0,-0.3655620D-1, &
         0.1504268D-1,-0.780353D-2,0.325614D-2,-0.68245D-3/
    IF(X.EQ.0.D0) THEN
       BESSK1=1.D32
       RETURN
    ENDIF
    IF(X.LE.2.D0) THEN
       Y=X*X/4.D0
       AX=LOG(X/2.D0)*BESSI1(X)
       BESSK1=AX+(1.D0/X)*(P1+Y*(P2+Y*(P3+Y*(P4+Y*(P5+Y*(P6+Y*P7))))))
    ELSE
       Y=(2.D0/X)
       AX=EXP(-X)/SQRT(X)
       BESSK1=AX*(Q1+Y*(Q2+Y*(Q3+Y*(Q4+Y*(Q5+Y*(Q6+Y*Q7))))))
    ENDIF
    RETURN
  END FUNCTION BESSK1

!-----------------------------------------------------------------------

  REAL (KIND=8) FUNCTION BESSK(N,X)
  
    REAL *8 X,TOX,BK,BKM,BKP
    
    IF (N.EQ.0) THEN
       BESSK = BESSK0(X)
       RETURN
    ENDIF
    IF (N.EQ.1) THEN
       BESSK = BESSK1(X)
       RETURN
    ENDIF
    IF (X.EQ.0.D0) THEN
       BESSK = 1.D30
       RETURN
    ENDIF
    TOX = 2.D0/X
    BK  = BESSK1(X)
    BKM = BESSK0(X)
    DO J=1,N-1
       BKP = BKM+DFLOAT(J)*TOX*BK
       BKM = BK
       BK  = BKP
    ENDDO
    BESSK = BK
    RETURN
  END FUNCTION BESSK

!-----------------------------------------------------------------------

end module bessel_mod
