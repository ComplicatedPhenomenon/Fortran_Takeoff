program main
   use my_fxn
   use MC_VEGAS
   implicit none

   integer, parameter        :: NDIM = 7
   integer                   :: i
   real(kind(0d0))           :: interval
   real(kind(0d0))           :: avgi_qq, sigma_qq, sd, chi2a
   Character(len=40)         :: Tablefile
   data Tablefile/'CT14LL.pds'/
   Call SetCT14(Tablefile)
   open(1,file = 'DATAqq.txt', status='unknown')
   interval = 7d3/50
   M_D = 3.d3
   do i = 1,10
   call vegas(NDIM,fxn_1,avgi_qq,sd,chi2a)
   sigma_qq=avgi_qq*3.894*10**8
   write(1,*) avgi_qq ,'Mev'
   write(1,*) sigma_qq ,'pb'
   M_D=M_D+i*interval
   print *,"#######################"
   print *,"#######################"
   print *,"#######################"
   print *, i,M_D,avgi_qq
   end do
   close(1)
end program main
