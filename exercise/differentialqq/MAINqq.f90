program main
   use my_fxn
   use MC_VEGAS 
   implicit none

   integer, parameter        :: NDIM = 6
   real(kind(0d0))           :: avgi_qq, sigma_qq, sd, chi2a
   real(kind(0d0))           :: interval
   Character(len=40)         :: Tablefile
   data Tablefile/'CT14LL.pds'/
   Call SetCT14(Tablefile)

   interval = 2d0 /1000
   cos_theta = -1d0

   do i = 1, 2
      cos_theta = cos_theta +  interval 
      !*******************************************
      !     Transform cos_theta to module my_fxn
      !*******************************************
      call vegas(NDIM,fxn_1,avgi_qq,sd,chi2a)
      open(1,file = 'DATAqq.txt', access='append', status='unknown')
!      sigma_qq=avgi_qq*3.894*10**8
      write(1,*) 'i',i, avgi_qq
   end do
   close(1)
end program main
