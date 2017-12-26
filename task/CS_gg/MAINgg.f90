PROGRAM main
   USE my_fxn
   USE MC_VEGAS 
   IMPLICIT NONE

   INTEGER, PARAMETER        :: NDIM = 7
   INTEGER                   :: i,j
   REAL(KIND(0d0))           :: interval
   REAL(KIND(0d0))           :: avgi_gg, sigma_gg, sd, chi2a
   Character(len=40)         :: Tablefile
   CHARACTER(LEN = 128)      :: arg
   DATA Tablefile/'CT14LL.pds'/

   nd = NDIM

   CALL SetCT14(Tablefile)
   interval = 7d3/300

   M_D = 3d3
   i = 1
   CALL GET_COMMAND_ARGUMENT(i,arg)
   READ(arg,*) j
   M_D = M_D + j*interval

   CALL vegas(NDIM,fxn_2,avgi_gg,sd,chi2a)
   sigma_gg=avgi_gg*3.894*10**8
   PRINT *,j, M_D, sigma_gg

   OPEN(1,file = 'DATAgg1.txt', position = 'append', status='unknown')
   WRITE(1,*) M_D, sigma_gg ,'pb'
   CLOSE(1)

END PROGRAM main
