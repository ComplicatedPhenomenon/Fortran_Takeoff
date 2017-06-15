program main
   use my_fxn
   use MC_VEGAS 
   implicit none

   integer, parameter        :: NDIM = 7
!   integer, parameter        :: NDIM = 6
   real(kind(0d0))           :: avgi_qq, sigma_qq, sd, chi2a
   Character(len=40)         :: Tablefile
   data Tablefile/'CT14LL.pds'/
   Call SetCT14(Tablefile)
   open(1,file = 'DATA.txt', status='unknown')
   call vegas(NDIM,fxn_1,avgi_qq,sd,chi2a)
   sigma_qq=avgi_qq*3.894*10**8
   write(1,*) avgi_qq ,'Mev'
   write(1,*) sigma_qq ,'pb'
   close(1)
   print *, 'The cross section of the qq to ttbar is avgi_qq= ',  avgi_qq,'Mev'
   print *, 'The cross section of the qq to ttbar is sigma_qq=',   sigma_qq,'pb'
end program main
