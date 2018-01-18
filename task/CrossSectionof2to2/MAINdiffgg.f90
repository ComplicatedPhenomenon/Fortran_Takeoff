PROGRAM main
   USE my_fxn
   USE MC_VEGAS
   IMPLICIT NONE

   INTEGER, PARAMETER        :: NDIM = 6
   INTEGER                   :: j
   REAL(KIND(0D0))           :: interval
   REAL(KIND(0d0))           :: avgi_gg, diffCSgg, sd, chi2a
   cHARACTER(LEN=40)         :: Tablefile
   CHARACTER(LEN = 128)      :: arg
   DATA Tablefile/'CT14LL.pds'/
   nd = NDIM
   delta = 4

   CALL SetCT14(Tablefile)
   interval = 2d0/100

   cos_theta= -1d0
   CALL GET_COMMAND_ARGUMENT(1,arg)
   read(arg,*) j
   cos_theta = cos_theta + j*interval

   CALL vegas(NDIM,fxn_2,avgi_gg,sd,chi2a)

   diffCSgg =LOG( avgi_gg * 3.894 * 10 ** 8)

   OPEN(1,file = 'DATAgg4.txt', position = 'append', status='unknown')
   PRINT *, j, cos_theta, diffCSgg

   close(1)
end program main
