      BLOCK DATA
C
C   MAKES DEFAULT PARAMETER ASSIGNMENTS FOR VEGAS
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      COMMON/BVEG1/NCALL,ITMX,NPRN,NDEV,XL(10),XU(10),ACC
      COMMON/BVEG2/IT,NDO,SI,SWGT,SCHI,XI(50,10)
      COMMON/BVEG3/ALPH,NDMX,MDS
      COMMON/RNSD/DSEED
      DATA NCALL/1000000/,ITMX/5/,NPRN/5/,ACC/-1./,
     1     XL/0.,0.,0.,0.,0.,0.,0.,0.,0.,0./,
     2     XU/1.,1.,1.,1.,1.,1.,1.,1.,1.,1./,
     3     ALPH/1.5/,NDMX/50/,MDS/1/,NDEV/6/,
     4     NDO/1/,XI/500*1./,IT/0/,SI,SWGT,SCHI/3*0./,
     5     DSEED/1234567./
      END 
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c modify the value of NCALL as you like, the time-taking c
c obviously changed                                      c
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
