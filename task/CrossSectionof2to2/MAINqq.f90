PROGRAM main
    USE my_fxn
    USE MC_VEGAS
    IMPLICIT NONE

    INTEGER, PARAMETER        :: NDIM = 7
    INTEGER                   :: j
    REAL(KIND(0D0))           :: interval
    REAL(KIND(0d0))           :: avgi_qq, sigma_qq, sd, chi2a
    CHARACTER(LEN=40)         :: Tablefile
    CHARACTER(LEN = 128)      :: arg
    DATA Tablefile/'CT14LL.pds'/

    nd = NDIM

    CALL SetCT14(Tablefile)
    interval = 2d3/100
   
    OPEN(1,file = 'result/DATAqq_d4.txt', position = 'append', status='unknown')

    M_D = 3d3

    delta = 4
    CALL GET_COMMAND_ARGUMENT(1,arg)
    READ(arg,*) j
    M_D = M_D + j*interval

    CALL vegas(NDIM,fxn_1,avgi_qq,sd,chi2a,2)
    sigma_qq = avgi_qq * 3.894 * 10 ** 8
    print *,j,M_D, sigma_qq
    WRITE(1,*) M_D, sigma_qq ,'pb'
      
    close(1)
end program main


