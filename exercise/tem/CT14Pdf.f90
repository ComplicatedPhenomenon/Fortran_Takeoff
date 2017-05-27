!*==CT14PDF.spg  processed by SPAG 6.72Dc at 11:08 on 27 May 2017
!============================================================================
!                CTEQ-TEA Parton Distribution Functions: version 2014
!                       December 31, 2014
!
!   When using these PDFs, please cite the references below
!
!
!   This package provides a standard interface for CT10, CT12
!   (unpublished), and CT14 parton distribution functions.
!
!   The following sets of CTEQ PDF table files can be computed
!    with this program:
!               PDF                             References
!   (1) 1+50 sets of CT10 NNLO PDF's;             [1]
!   (2' ) 1+52 sets of CT10 NLO PDF's;            [2]
!   (2'') 1+52 sets of CT10W NLO PDF's;           [2]
!   (3) 4 sets of CT10W NNLO and NLO PDF's        [2]
!       with alternative alpha_s values;
!   (4) 1+56 sets of CT14 NNLO PDF's;             [3]
!   (5) 1+56 sets of CT14 NLO PDF's;              [3]
!   (6) 2 sets of CT14 LO PDF's;                  [3]
!   (7) 11 CT14 NNLO sets and 11 CT14 NLO sets    [3]
!       with alternative alpha_s values
!   (8) 3 CT14 NNLO and 3 CT14 NLO sets           [3]
!       with up to 3, 4, and 6 active quark flavors
!   (9) 4 CT14 NNLO sets with intrinsic charm     [X]
 
!   References
!   [1] J. Gao, M. Guzzi, J. Huston, H.-L. Lai, Z. Li, P. M. Nadolsky,
!       J. Pumplin, D. Stump, C.-P. Yuan,  arXiv:1302.6246 [hep-ph]
!   [2] H.-L. Lai, M. Guzzi, J. Huston, Z. Li, P. M. Nadolsky,
!       J. Pumplin, and C.-P. Yuan, arXiv: 1007.2241 [hep-ph]
!   [3] S. Dulat, T.-J. Hou, J. Gao, M. Guzzi, J. Huston,
!       P. M. Nadolsky, J. Pumplin, C. Schmidt, D. Stump, and
!       C.-P. Yuan, arXiv:1506.XXXX
!
! ===========================================================================
!   The table grids are generated for
!    *  10^-9 < x < 1 and 1.3 < Q < 10^5 (GeV).
!
!   PDF values outside of the above range are returned using extrapolation.
!
!   The Table_Files are assumed to be in the working directory.
!
!   Before using the PDF, it is necessary to do the initialization by
!       Call SetCT14(Iset)
!   where Tablefile is a 40-character text string with the name of the
!   the desired PDF specified in the above table.table (.pds) file
!
!   Other provided functions include:
!   The function CT14Pdf (Iparton, X, Q)
!     returns the parton distribution inside the proton for parton [Iparton]
!     at [X] Bjorken_X and scale [Q] (GeV) in PDF set [Iset].
!     Iparton  is the parton label (5, 4, 3, 2, 1, 0, -1, ......, -5)
!                              for (b, c, s, d, u, g, u_bar, ..., b_bar),
!
!   The function CT14Alphas (Q)
!     returns the value of the QCD coupling strength alpha_s(Q) at
!     an energy scale Q. The alpha_s value is obtained from the interpolation
!     of a numerical table of alpha_s included in each .pds file.
!     In the PDF fit, the alpha_s values are obtained at each momentum
!     scale by evolution in the HOPPET program at the respective QCD order
!     (NLO or NNLO). The table of alpha_s values at discrete Q values
!     is included in the input .pds file. The function CT14Alphas
!     estimates alpha_s at an arbitrary Q value, which agrees
!     with the direct evolution by HOPPET within a fraction of percent
!     point at typical Q.
!
!   The function CT14Mass(i)
!     returns the value of the quark mass for the i-th flavor.
!     The flavors are:
!     1  2  3  4  5  6
!     u  d  s  c  b  t
!
!   Values of various PDF parameters assumed in the computation of the
!    PDFs can be obtained by
!     Call CT14GetPars( xmin,Qini,Qmax,Nloops,Nfl),
!   which returns
!     xmin, the minimal value of x;
!     Qmin,  the initial Q scale for the PDF evolution;
!     Qmax,  the maximal Q scale included in the PDF table;
!     Nloop, the number of QCD loops (order of the PDF in the QCD coupling);
!     Nfl,   the maximal number of quark flavors assumed in the PDF and
!            alpha_s evolution.
 
!   These programs, as provided, are in double precision.  By removing the
!   "Implicit Double Precision" lines, they can also be run in single
!   precision.
!   If you have detailed questions concerning these CT14 distributions,
!   or if you find problems/bugs using this package, direct inquires to
!   nadolsky@smu.edu.
!
!===========================================================================
      FUNCTION CT14PDF(Iparton,X,Q)
      IMPLICIT NONE
!*--CT14PDF97
!*** Start of declarations inserted by SPAG
      DOUBLE PRECISION ALFaq , CT14PDF , PARTONX12 , Q , QALfa , qsml , &
                     & X
      INTEGER IORder , Iparton , IPDsset , IPK , MXVal , NFL , NFMx ,   &
            & NT , NX
!*** End of declarations inserted by SPAG
      LOGICAL warn
      INTEGER ISEtch , IPDsformat
      COMMON /CTQPAR2/ NX , NT , NFMx , MXVal/QCDTBL/ ALFaq , QALfa ,   &
                     & IPK , IORder , NFL/SETCHANGE/ ISEtch , IPDsset , &
                     & IPDsformat                 !for external use
 
      DATA warn/.TRUE./
      DATA qsml/.3D0/
      SAVE warn
 
      IF ( IPDsset.NE.1 ) STOP                                          &
                           &'CT14Pdf: the PDF table was not initialized'
 
      IF ( X.LT.0D0 .OR. X.GT.1D0 ) THEN
         PRINT * , 'X out of range in CT14Pdf: ' , X
         CT14PDF = 0D0
         RETURN
      ENDIF
 
      IF ( Q.LT.qsml ) THEN
         PRINT * , 'Q out of range in CT14Pdf: ' , Q
         STOP
      ENDIF
 
      IF ( ABS(Iparton).GT.NFMx ) THEN
         IF ( warn ) THEN
!        print a warning for calling extra flavor
            warn = .FALSE.
            PRINT * , 'Warning: Iparton out of range in CT14Pdf! '
            PRINT * , 'Iparton, MxFlvN0: ' , Iparton , NFMx
         ENDIF
         CT14PDF = 0D0
      ELSE
 
         CT14PDF = PARTONX12(Iparton,X,Q)
         IF ( CT14PDF.LT.0D0 ) CT14PDF = 0D0
      ENDIF                     !if (abs(Iparton...
 
 
!                             ********************
      END
!*==SETCT14.spg  processed by SPAG 6.72Dc at 11:08 on 27 May 2017
 
      SUBROUTINE SETCT14(Tablefile)
      IMPLICIT NONE
!*--SETCT14149
!*** Start of declarations inserted by SPAG
      INTEGER IPDsformat , IPDsset , ISEtch , iu , NEXTUN
!*** End of declarations inserted by SPAG
      CHARACTER Tablefile*40
      COMMON /SETCHANGE/ ISEtch , IPDsset , IPDsformat
      DATA IPDsset , IPDsformat/0 , 0/
      SAVE 
 
      iu = NEXTUN()
      OPEN (iu,FILE=Tablefile,STATUS='OLD',ERR=100)
      CALL READPDS0(iu)
      CLOSE (iu)
      ISEtch = 1
      RETURN
 
 100  PRINT * , ' Data file ' , Tablefile , ' cannot be opened '//      &
           &'in SetCT14!!'
      STOP
!                             ********************
      END
!*==CT14GETPARS.spg  processed by SPAG 6.72Dc at 11:08 on 27 May 2017
 
      SUBROUTINE CT14GETPARS(Xmin,Qini,Qmax,Nloops,Nfl)
! Get various parameters associated with the PDF grid
! Output: xmin  is the minimal value of x
!         Qmin  is the initial Q scale
!         Qmax  is the maximal Q scale
!         Nloop is the number of QCD loops
!         Nfl   is the maximal number of quark flavors
      IMPLICIT NONE
!*--CT14GETPARS180
      DOUBLE PRECISION QINi0 , QMAx0 , XMIn0 , Xmin , Qini , Qmax
      INTEGER Nloops , IPK , IORder , Nfl , NFL0
      DOUBLE PRECISION ALFaq , QALfa
 
      COMMON /XQRANGE/ QINi0 , QMAx0 , XMIn0
      COMMON /QCDTBL/ ALFaq , QALfa , IPK , IORder , NFL0
 
      Qini = QINi0
      Nloops = IORder - 1
 
      END
!*==CT14ALPHAS.spg  processed by SPAG 6.72Dc at 11:08 on 27 May 2017
 
 
      FUNCTION CT14ALPHAS(Qq)
 
      IMPLICIT NONE
!*--CT14ALPHAS198
!*** Start of declarations inserted by SPAG
      DOUBLE PRECISION ALScteq , CT14ALPHAS , q , QBAse , QINi , QMAx , &
                     & Qq , tt , TV , UPD , XMIn , XV
      INTEGER IPDsformat , IPDsset , ISEtch , jlq , jm , jq , ju ,      &
            & MAXVAL , MXF , MXPQX , MXQ , MXVal , MXX , NFMx , NT , NX
!*** End of declarations inserted by SPAG
 
      PARAMETER (MXX=201,MXQ=40,MXF=6,MAXVAL=4)
      PARAMETER (MXPQX=(MXF+1+MAXVAL)*MXQ*MXX)
      DOUBLE PRECISION alsout
 
      COMMON /CTQPAR1/ QBAse , XV(0:MXX) , TV(0:MXQ) , UPD(MXPQX) ,     &
                     & ALScteq(0:MXQ)/CTQPAR2/ NX , NT , NFMx ,         &
                     & MXVal/XQRANGE/ QINi , QMAx ,                     &
                     & XMIn/SETCHANGE/ ISEtch , IPDsset , IPDsformat
 
      DATA q , jq/ - 1D0 , 0/
      SAVE 
 
      IF ( IPDsset.NE.1 ) STOP                                          &
                        &'CT14Alphas: the PDF table was not initialized'
 
 
      IF ( IPDsformat.LT.11 ) THEN
         PRINT *
         PRINT * ,                                                      &
           &'STOP in CT14alphas: the PDF table file has an older format'
         PRINT * ,                                                      &
              &'and does not include the table of QCD coupling values.'
         PRINT * , 'You can still compute the PDFs, but do not call'
         PRINT * ,                                                      &
            &'the CT14alphas function for the interpolation of alpha_s.'
         STOP
      ENDIF
 
      q = Qq
      tt = LOG(LOG(q/QBAse))
 
!         --------------   Find lower end of interval containing Q, i.e.,
!                          get jq such that qv(jq) .le. q .le. qv(jq+1)...
      jlq = -1
      ju = NT + 1
 100  IF ( ju-jlq.GT.1 ) THEN
         jm = (ju+jlq)/2
         IF ( tt.GE.TV(jm) ) THEN
            jlq = jm
         ELSE
            ju = jm
         ENDIF
         GOTO 100
      ENDIF
 
      IF ( jlq.LE.0 ) THEN
         jq = 0
      ELSEIF ( jlq.LE.NT-2 ) THEN
!                                  keep q in the middle, as shown above
         jq = jlq - 1
      ELSE
!                         JLq .GE. Nt-1 case:  Keep at least 4 points >= Jq.
         jq = NT - 3
 
      ENDIF
!                                 This is the interpolation variable in Q
      CALL POLINT4F(TV(jq),ALScteq(jq),tt,alsout)
 
      CT14ALPHAS = alsout
 
!                                       ********************
      END
!*==CT14MASS.spg  processed by SPAG 6.72Dc at 11:08 on 27 May 2017
 
 
      FUNCTION CT14MASS(I)
!     Returns the value of the quark mass for the i-th flavor
!     The flavors are:
!     1  2  3  4  5  6
!     u  d  s  c  b  t
      IMPLICIT NONE
!*--CT14MASS277
      DOUBLE PRECISION CT14MASS , AMAss
      INTEGER ISEtch , IPDsset , I , IPDsformat
      COMMON /SETCHANGE/ ISEtch , IPDsset , IPDsformat/MASSTBL/ AMAss(6)
 
 
      IF ( IPDsset.NE.1 ) STOP                                          &
                          &'CT14Mass: the PDF table was not initialized'
 
      CT14MASS = AMAss(I)
 
      END
!*==READPDS0.spg  processed by SPAG 6.72Dc at 11:08 on 27 May 2017
 
 
      SUBROUTINE READPDS0(Nu)
      IMPLICIT NONE
!*--READPDS0294
!*** Start of declarations inserted by SPAG
      DOUBLE PRECISION aa , aimass , alambda , ALFaq , ALScteq , AMAss ,&
                     & dr , dummy , fl , fswitch , QALfa , QBAse ,      &
                     & qbase1 , qbase2 , QINi , QMAx , TV , UPD , XMIn ,&
                     & XV
      INTEGER i , IORder , IPDsset , IPK , iret , ISEtch , MAXVAL ,     &
            & MXF , MXPQX , MXQ , MXVal , MXX , n0 , nblk , NFL , NFMx ,&
            & ng , npts , NT , Nu
      INTEGER NX
!*** End of declarations inserted by SPAG
      CHARACTER line*80
      INTEGER IPDsformat
      PARAMETER (MXX=201,MXQ=40,MXF=6,MAXVAL=4)
      PARAMETER (MXPQX=(MXF+1+MAXVAL)*MXQ*MXX)
      DOUBLE PRECISION qv(0:MXQ)
 
      COMMON /CTQPAR1/ QBAse , XV(0:MXX) , TV(0:MXQ) , UPD(MXPQX) ,     &
                     & ALScteq(0:MXQ)/CTQPAR2/ NX , NT , NFMx ,         &
                     & MXVal/XQRANGE/ QINi , QMAx ,                     &
                     & XMIn/MASSTBL/ AMAss(6)/QCDTBL/ ALFaq , QALfa ,   &
                     & IPK , IORder , NFL/SETCHANGE/ ISEtch , IPDsset , &
                     & IPDsformat                 !for external use
 
      READ (Nu,'(A)') line
      READ (Nu,'(A)') line
 
      IF ( line(1:11).EQ.'  ipk, Ordr' ) THEN !post-CT10 .pds format;
! Set alphas(MZ) at scale Zm, quark masses, and evolution type
         IPDsformat = 10          !Post-CT10 .pds format
         READ (Nu,*) IPK , dr , QALfa , ALFaq , (AMAss(i),i=1,6)
         IORder = NINT(dr)
         READ (Nu,'(A)') line
         IF ( line(1:7).EQ.'  IMASS' ) THEN
            IPDsformat = 11       !CT12 .pds format
            READ (Nu,*) aimass , fswitch , n0 , n0 , n0 , NFMx , MXVal
            NFL = NFMx
         ELSE                     !Pre-CT12 format
            READ (Nu,*) n0 , n0 , n0 , NFMx , MXVal
         ENDIF                    !Line(1:7)
 
      ELSE                        !old .pds format;
         IPDsformat = 6           !CTEQ6.6 .pds format; alpha_s  is not specified
         READ (Nu,*) dr , fl , alambda , (AMAss(i),i=1,6)
                                                        !set Lambda_QCD
         IORder = NINT(dr)
 
         READ (Nu,'(A)') line
         READ (Nu,*) dummy , dummy , dummy , NFMx , MXVal , n0
      ENDIF                       !Line(1:11...
 
      READ (Nu,'(A)') line
      READ (Nu,*) NX , NT , n0 , ng , n0
 
      IF ( ng.GT.0 ) READ (Nu,'(A)') (line,i=1,ng+1)
 
      READ (Nu,'(A)') line
      IF ( IPDsformat.GE.11 ) THEN
                                  !CT12 format with alpha_s values
         READ (Nu,*) QINi , QMAx , (qv(i),TV(i),ALScteq(i),i=0,NT)
      ELSE                        !pre-CT12 format
         READ (Nu,*) QINi , QMAx , (qv(i),TV(i),i=0,NT)
      ENDIF                       !ipdsformat.ge.11
 
! check that qBase is consistent with the definition of Tv(0:nQ) for 2 values of Qv
      qbase1 = qv(1)/EXP(EXP(TV(1)))
      qbase2 = qv(NT)/EXP(EXP(TV(NT)))
      IF ( ABS(qbase1-qbase2).GT.1E-5 ) THEN
         PRINT * , 'Readpds0: something wrong with qbase'
         PRINT * , 'qbase1, qbase2=' , qbase1 , qbase2
         STOP
      ELSE
         QBAse = (qbase1+qbase2)/2.0D0
      ENDIF                     !abs(qbase1...
 
      READ (Nu,'(A)') line
      READ (Nu,*) XMIn , aa , (XV(i),i=1,NX)
      XV(0) = 0D0
 
      nblk = (NX+1)*(NT+1)
      npts = nblk*(NFMx+1+MXVal)
      READ (Nu,'(A)') line
      READ (Nu,*,IOSTAT=iret) (UPD(i),i=1,npts)
 
!                        ****************************
      END
!*==PARTONX12.spg  processed by SPAG 6.72Dc at 11:08 on 27 May 2017
 
      FUNCTION PARTONX12(Iprtn,Xx,Qq)
 
!  Given the parton distribution function in the array U in
!  COMMON / PEVLDT / , this routine interpolates to find
!  the parton distribution at an arbitray point in x and q.
!
      IMPLICIT NONE
!*--PARTONX12389
!*** Start of declarations inserted by SPAG
      DOUBLE PRECISION ALScteq , const1 , const2 , const3 , const4 ,    &
                     & const5 , const6 , ff , fij , fvec , fx , g1 ,    &
                     & g4 , h00 , onep , PARTONX12 , q , QBAse , QINi , &
                     & QMAx
      DOUBLE PRECISION Qq , s12 , s1213 , s13 , s23 , s24 , s2434 ,     &
                     & s34 , sdet , sf2 , sf3 , ss , svec1 , svec2 ,    &
                     & svec3 , svec4 , sy2 , sy3 , t12 , t13
      DOUBLE PRECISION t23 , t24 , t34 , tdet , tf2 , tf3 , tmp , tmp1 ,&
                     & tmp2 , tt , TV , tvec1 , tvec2 , tvec3 , tvec4 , &
                     & ty2 , ty3 , UPD , x , XMIn
      DOUBLE PRECISION xpow , XV , xvpow , Xx
      INTEGER i , ientry , ip , IPDsformat , IPDsset , Iprtn , ISEtch , &
            & it , j1 , jlq , jlx , jm , jq , jtmp , ju , jx , MAXVAL , &
            & MXF , MXPQX , MXQ
      INTEGER MXVal , MXX , NFMx , nqvec , NT , NX
!*** End of declarations inserted by SPAG
 
      PARAMETER (MXX=201,MXQ=40,MXF=6,MAXVAL=4)
      PARAMETER (MXPQX=(MXF+1+MAXVAL)*MXQ*MXX)
 
      COMMON /CTQPAR1/ QBAse , XV(0:MXX) , TV(0:MXQ) , UPD(MXPQX) ,     &
                     & ALScteq(0:MXQ)/CTQPAR2/ NX , NT , NFMx ,         &
                     & MXVal/XQRANGE/ QINi , QMAx ,                     &
                     & XMIn/SETCHANGE/ ISEtch , IPDsset , IPDsformat
 
      DIMENSION fvec(4) , fij(4)
      DIMENSION xvpow(0:MXX)
      DATA onep/1.00001/
      DATA xpow/0.3D0/          !**** choice of interpolation variable
      DATA nqvec/4/
      DATA ientry/0/
      DATA x , q , jx , jq/ - 1D0 , -1D0 , 0 , 0/
      SAVE xvpow
      SAVE x , q , jx , jq , jlx , jlq
      SAVE ss , const1 , const2 , const3 , const4 , const5 , const6
      SAVE sy2 , sy3 , s23 , tt , t12 , t13 , t23 , t24 , t34 , ty2 ,   &
       & ty3
      SAVE tmp1 , tmp2 , tdet
 
! store the powers used for interpolation on first call...
      IF ( ISEtch.EQ.1 ) THEN
         ISEtch = 0
 
         xvpow(0) = 0D0
         DO i = 1 , NX
            xvpow(i) = XV(i)**xpow
         ENDDO
      ELSEIF ( (Xx.EQ.x) .AND. (Qq.EQ.q) ) THEN
         GOTO 300
      ENDIF
 
      x = Xx
      q = Qq
      tt = LOG(LOG(q/QBAse))
 
!      -------------    find lower end of interval containing x, i.e.,
!                       get jx such that xv(jx) .le. x .le. xv(jx+1)...
      jlx = -1
      ju = NX + 1
 100  IF ( ju-jlx.GT.1 ) THEN
         jm = (ju+jlx)/2
         IF ( x.GE.XV(jm) ) THEN
            jlx = jm
         ELSE
            ju = jm
         ENDIF
         GOTO 100
      ENDIF
!                     Ix    0   1   2      Jx  JLx         Nx-2     Nx
!                           |---|---|---|...|---|-x-|---|...|---|---|
!                     x     0  Xmin               x                 1
!
      IF ( jlx.LE.-1 ) THEN
         PRINT '(A,1pE12.4)' , 'Severe error: x <= 0 in PartonX12! x = '&
             & , x
         STOP
      ELSEIF ( jlx.EQ.0 ) THEN
         jx = 0
      ELSEIF ( jlx.LE.NX-2 ) THEN
 
!                For interrior points, keep x in the middle, as shown above
         jx = jlx - 1
      ELSEIF ( jlx.EQ.NX-1 .OR. x.LT.onep ) THEN
 
!                  We tolerate a slight over-shoot of one (OneP=1.00001),
!              perhaps due to roundoff or whatever, but not more than that.
!                                      Keep at least 4 points >= Jx
         jx = jlx - 2
      ELSE
         PRINT '(A,1pE12.4)' ,                                          &
             & 'Severe error: x > 1 in PartonX12! x = ' , x
         STOP
      ENDIF
!          ---------- Note: JLx uniquely identifies the x-bin; Jx does not.
 
!                       This is the variable to be interpolated in
      ss = x**xpow
 
      IF ( jlx.GE.2 .AND. jlx.LE.NX-2 ) THEN
 
!     initiation work for "interior bins": store the lattice points in s...
         svec1 = xvpow(jx)
         svec2 = xvpow(jx+1)
         svec3 = xvpow(jx+2)
         svec4 = xvpow(jx+3)
 
         s12 = svec1 - svec2
         s13 = svec1 - svec3
         s23 = svec2 - svec3
         s24 = svec2 - svec4
         s34 = svec3 - svec4
 
         sy2 = ss - svec2
         sy3 = ss - svec3
 
! constants needed for interpolating in s at fixed t lattice points...
         const1 = s13/s23
         const2 = s12/s23
         const3 = s34/s23
         const4 = s24/s23
         s1213 = s12 + s13
         s2434 = s24 + s34
         sdet = s12*s34 - s1213*s2434
         tmp = sy2*sy3/sdet
         const5 = (s34*sy2-s2434*sy3)*tmp/s12
         const6 = (s1213*sy2-s12*sy3)*tmp/s34
 
      ENDIF
 
!         --------------Now find lower end of interval containing Q, i.e.,
!                          get jq such that qv(jq) .le. q .le. qv(jq+1)...
      jlq = -1
      ju = NT + 1
 200  IF ( ju-jlq.GT.1 ) THEN
         jm = (ju+jlq)/2
         IF ( tt.GE.TV(jm) ) THEN
            jlq = jm
         ELSE
            ju = jm
         ENDIF
         GOTO 200
      ENDIF
 
      IF ( jlq.LE.0 ) THEN
         jq = 0
      ELSEIF ( jlq.LE.NT-2 ) THEN
!                                  keep q in the middle, as shown above
         jq = jlq - 1
      ELSE
!                         JLq .GE. Nt-1 case:  Keep at least 4 points >= Jq.
         jq = NT - 3
 
      ENDIF
!                                   This is the interpolation variable in Q
 
      IF ( jlq.GE.1 .AND. jlq.LE.NT-2 ) THEN
!                                        store the lattice points in t...
         tvec1 = TV(jq)
         tvec2 = TV(jq+1)
         tvec3 = TV(jq+2)
         tvec4 = TV(jq+3)
 
         t12 = tvec1 - tvec2
         t13 = tvec1 - tvec3
         t23 = tvec2 - tvec3
         t24 = tvec2 - tvec4
         t34 = tvec3 - tvec4
 
         ty2 = tt - tvec2
         ty3 = tt - tvec3
 
         tmp1 = t12 + t13
         tmp2 = t24 + t34
 
         tdet = t12*t34 - tmp1*tmp2
 
      ENDIF
 
 
! get the pdf function values at the lattice points...
 
 300  IF ( Iprtn.GT.MXVal ) THEN
         ip = -Iprtn
      ELSE
         ip = Iprtn
      ENDIF
      jtmp = ((ip+NFMx)*(NT+1)+(jq-1))*(NX+1) + jx + 1
 
      DO it = 1 , nqvec
         j1 = jtmp + it*(NX+1)
 
         IF ( jx.EQ.0 ) THEN
!                      For the first 4 x points, interpolate x^2*f(x,Q)
!                      This applies to the two lowest bins JLx = 0, 1
!            We can not put the JLx.eq.1 bin into the "interrior" section
!                           (as we do for q), since Upd(J1) is undefined.
            fij(1) = 0
            fij(2) = UPD(j1+1)*XV(1)**2
            fij(3) = UPD(j1+2)*XV(2)**2
            fij(4) = UPD(j1+3)*XV(3)**2
!
!                 Use Polint which allows x to be anywhere w.r.t. the grid
 
            CALL POLINT4F(xvpow(0),fij(1),ss,fx)
 
            IF ( x.GT.0D0 ) fvec(it) = fx/x**2
!                                              Pdf is undefined for x.eq.0
         ELSEIF ( jlx.EQ.NX-1 ) THEN
!                                                This is the highest x bin:
 
            CALL POLINT4F(xvpow(NX-3),UPD(j1),ss,fx)
 
            fvec(it) = fx
 
         ELSE
!                       for all interior points, use Jon's in-line function
!                              This applied to (JLx.Ge.2 .and. JLx.Le.Nx-2)
            sf2 = UPD(j1+1)
            sf3 = UPD(j1+2)
 
            g1 = sf2*const1 - sf3*const2
            g4 = -sf2*const3 + sf3*const4
 
            fvec(it) = (const5*(UPD(j1)-g1)+const6*(UPD(j1+3)-g4)       &
                     & +sf2*sy3-sf3*sy2)/s23
 
         ENDIF
 
      ENDDO
!                                   We now have the four values Fvec(1:4)
!     interpolate in t...
 
      IF ( jlq.LE.0 ) THEN
!                         1st Q-bin, as well as extrapolation to lower Q
         CALL POLINT4F(TV(0),fvec(1),tt,ff)
 
      ELSEIF ( jlq.GE.NT-1 ) THEN
!                         Last Q-bin, as well as extrapolation to higher Q
         CALL POLINT4F(TV(NT-3),fvec(1),tt,ff)
      ELSE
!                         Interrior bins : (JLq.GE.1 .and. JLq.LE.Nt-2)
!       which include JLq.Eq.1 and JLq.Eq.Nt-2, since Upd is defined for
!                         the full range QV(0:Nt)  (in contrast to XV)
         tf2 = fvec(2)
         tf3 = fvec(3)
 
         g1 = (tf2*t13-tf3*t12)/t23
         g4 = (-tf2*t34+tf3*t24)/t23
 
         h00 = ((t34*ty2-tmp2*ty3)*(fvec(1)-g1)/t12+(tmp1*ty2-t12*ty3)  &
             & *(fvec(4)-g4)/t34)
 
         ff = (h00*ty2*ty3/tdet+tf2*ty3-tf3*ty2)/t23
      ENDIF
 
      PARTONX12 = ff
 
!                                       ********************
      END
!*==POLINT4F.spg  processed by SPAG 6.72Dc at 11:08 on 27 May 2017
 
 
      SUBROUTINE POLINT4F(Xa,Ya,X,Y)
 
      IMPLICIT NONE
!*--POLINT4F656
!*** Start of declarations inserted by SPAG
      DOUBLE PRECISION c1 , c2 , c3 , cc1 , cc2 , cd1 , cd2 , d1 , d2 , &
                     & d3 , dc1 , dd1 , den , h1 , h2 , h3 , h4 , w ,   &
                     & X , Xa
      DOUBLE PRECISION Y , Ya
!*** End of declarations inserted by SPAG
!  The POLINT4 routine is based on the POLINT routine from "Numerical Recipes",
!  but assuming N=4, and ignoring the error estimation.
!  suggested by Z. Sullivan.
      DIMENSION Xa(*) , Ya(*)
 
      h1 = Xa(1) - X
      h2 = Xa(2) - X
      h3 = Xa(3) - X
      h4 = Xa(4) - X
 
      w = Ya(2) - Ya(1)
      den = w/(h1-h2)
      d1 = h2*den
      c1 = h1*den
 
      w = Ya(3) - Ya(2)
      den = w/(h2-h3)
      d2 = h3*den
      c2 = h2*den
 
      w = Ya(4) - Ya(3)
      den = w/(h3-h4)
      d3 = h4*den
      c3 = h3*den
 
      w = c2 - d1
      den = w/(h1-h3)
      cd1 = h3*den
      cc1 = h1*den
 
      w = c3 - d2
      den = w/(h2-h4)
      cd2 = h4*den
      cc2 = h2*den
 
      w = cc2 - cd1
      den = w/(h1-h4)
      dd1 = h4*den
      dc1 = h1*den
 
      IF ( (h3+h4).LT.0D0 ) THEN
         Y = Ya(4) + d3 + cd2 + dd1
      ELSEIF ( (h2+h3).LT.0D0 ) THEN
         Y = Ya(3) + d2 + cd1 + dc1
      ELSEIF ( (h1+h2).LT.0D0 ) THEN
         Y = Ya(2) + c2 + cd1 + dc1
      ELSE
         Y = Ya(1) + c1 + cc1 + dc1
      ENDIF
 
!               *************************
      END
!*==NEXTUN.spg  processed by SPAG 6.72Dc at 11:08 on 27 May 2017
 
      FUNCTION NEXTUN()
      IMPLICIT NONE
!*--NEXTUN719
!*** Start of declarations inserted by SPAG
      INTEGER n , NEXTUN
!*** End of declarations inserted by SPAG
!                                 Returns an unallocated FORTRAN i/o unit.
      LOGICAL ex
!
      DO n = 10 , 300
         INQUIRE (UNIT=n,OPENED=ex)
         IF ( .NOT.ex ) THEN
            NEXTUN = n
            RETURN
         ENDIF
      ENDDO
      STOP ' There is no available I/O unit. '
!               *************************
      END
!
 

