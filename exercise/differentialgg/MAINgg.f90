program main
   use my_fxn
   use MC_VEGAS 
   implicit none

   integer, parameter        :: NDIM = 7
!   integer, parameter        :: NDIM = 6 
   real(kind(0d0))           :: avgi_gg, sigma_gg, sd, chi2a
   Character(len=40)         :: Tablefile
   data Tablefile/'CT14LL.pds'/
   Call SetCT14(Tablefile)
   open(1,file = 'DATAgg.txt', status='unknown')
   call vegas(NDIM,fxn_2,avgi_gg,sd,chi2a)
   sigma_gg=avgi_gg*3.894*10**8
   write(1,*) avgi_gg ,'Mev'
   write(1,*) sigma_gg ,'pb'
   close(1)
   print *, 'The cross section of the gg to ttbar is avgi_gg= ',  avgi_gg,'Mev'
   print *, 'The cross section of the gg to ttbar is sigma_gg=',   sigma_gg,'pb'
end program main
