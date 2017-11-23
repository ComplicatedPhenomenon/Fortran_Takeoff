PROGRAM main
   USE my_fxn
   USE MC_VEGAS
   IMPLICIT NONE

   INTEGER, PARAMETER        :: NDIM = 7
   INTEGER                   :: i,j
   REAL(KIND(0D0))           :: interval
   REAL(KIND(0d0))           :: avgi_qq, sigma_qq, sd, chi2a
   cHARACTER(LEN=40)         :: Tablefile
   CHARACTER(LEN = 128)      :: arg
   DATA Tablefile/'CT14LL.pds'/
   nd = NDIM

   CALL SetCT14(Tablefile)
   interval = 7d3/300
   
   M_D = 3d3
   i = 1
   CALL GET_COMMAND_ARGUMENT(i,arg)
   read(arg,*) j
   M_D = M_D + j*interval

   CALL vegas(NDIM,fxn_1,avgi_qq,sd,chi2a,2)
   sigma_qq = avgi_qq * 3.894 * 10 ** 8

   OPEN(1,file = 'DATAqq.txt', position = 'append', status='unknown')
   PRINT *, j, M_D, sigma_qq
   WRITE(1,*) M_D, sigma_qq ,'pb'

   close(1)
end program main
