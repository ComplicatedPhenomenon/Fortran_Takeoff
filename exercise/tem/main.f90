program main
   use my_fxn
   use MC_VEGAS 
   implicit none

   integer, parameter        :: NDIM = 3
   real(kind(0d0))           :: avgi_qq, avgi_gg, sigma_qq, sigma_gg, sd, chi2a
   Character(len=40)         :: Tablefile
   data Tablefile/'CT14LL.pds'/
   Call SetCT14(Tablefile)
   open(1,file = 'DATA.txt', status='unknown')
   call vegas(NDIM,fxn_1,avgi_qq,sd,chi2a)
   call vegas(NDIM,fxn_2,avgi_gg,sd,chi2a)
   sigma_qq=avgi_qq*3.894*10**8
   sigma_gg=avgi_gg*3.894*10**8
   write(1,*)'TEST',avgi_qq ,'Mev'
   write(1,*) avgi_gg ,'Mev'
   write(1,*) sigma_qq ,'pb'
   write(1,*) sigma_gg ,'pb'
   close(1)
   print *, 'The cross section of the ppbar to ttbar is sigma_qq=',avgi_qq,'Mev'
   print *, 'The cross section of the gg to ttbar is sigma_gg= ',  avgi_gg,'Mev'
   print *, 'The cross section of the ppbar to ttbar is sigma_qq=',sigma_qq,'pb'
   print *, 'The cross section of the gg to ttbar is sigma_gg=',   sigma_gg,'pb'
end program main
include "CT14Pdf.f90"
include "fxn.f90"
!include "MC_VEGAS.f90"
! it's still not encapsulated in a module, so I have to include it here

