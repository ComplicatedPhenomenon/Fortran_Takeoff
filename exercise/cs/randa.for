      SUBROUTINE RANDA(NR,R)
C                                  SPECIFICATIONS FOR ARGUMENTS
      DOUBLE PRECISION DSEED,R
      DIMENSION R(NR)
C                                  SPECIFICATIONS FOR LOCAL VARIABLES
      INTEGER            I
      DOUBLE PRECISION   D2P31M,D2P31
C                                  D2P31M=(2**31) - 1
C                                  D2P31 =(2**31)(OR AN ADJUSTED VALUE)
      COMMON/RNSD/DSEED
      DATA               D2P31M/2147483647.D0/
      DATA               D2P31/2147483711.D0/
C                                  FIRST EXECUTABLE STATEMENT
      DO 55 I=1,NR
         DSEED = DMOD(16807.D0*DSEED,D2P31M)
55     R(I) = DSEED / D2P31
      RETURN
      END
