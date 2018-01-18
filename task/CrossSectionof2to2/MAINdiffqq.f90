PROGRAM main
   USE my_fxn
   USE MC_VEGAS
   IMPLICIT NONE

   INTEGER, PARAMETER        :: NDIM = 6
   INTEGER                   :: j
   REAL(KIND(0D0))           :: interval
   REAL(KIND(0d0))           :: avgi_qq, diffCSqq, sd, chi2a
   cHARACTER(LEN=40)         :: Tablefile
   CHARACTER(LEN = 128)      :: arg
   DATA Tablefile/'CT14LL.pds'/
   nd = NDIM
   delta = 3
   M_D = 3d3
   CALL SetCT14(Tablefile)
   interval = 2d0/100


   cos_theta= -1d0

   CALL GET_COMMAND_ARGUMENT(1,arg)
   read(arg,*) j
   cos_theta = cos_theta + j*interval

   CALL vegas(NDIM,fxn_1,avgi_qq,sd,chi2a)

   diffCSqq = LOG(avgi_qq * 3.894 * 10 ** 8)

   OPEN(1,file = 'result/diffDATAqq_d3.txt', position = 'append', status='unknown')
   PRINT *, j, cos_theta, diffCSqq
   WRITE(1,*)  cos_theta, diffCSqq 

   close(1)
end program main
