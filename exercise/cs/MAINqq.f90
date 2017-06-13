program main
   use my_fxn
   use MC_VEGAS 
   implicit none

   integer, parameter        :: NDIM = 7
   real(kind(0d0))           :: avgi_qq, sigma_qq, avgi_gg, sigma_gg, sd, chi2a
   Character(len=40)         :: Tablefile
   data Tablefile/'CT14LL.pds'/
   Call SetCT14(Tablefile)
   open(1,file = 'DATA.txt', status='unknown')
   call vegas(NDIM,fxn_1,avgi_qq,sd,chi2a)
      sigma_gg=avgi_gg*3.894*10**8
   write(1,*) avgi_gg ,'Mev'
   write(1,*) sigma_gg ,'pb'
   close(1)
   print *, 'The cross section of the gg to ttbar is avgi_qq= ',  avgi_qq,'Mev'
   print *, 'The cross section of the gg to ttbar is sigma_qq=',   sigma_qq,'pb'
end program main
