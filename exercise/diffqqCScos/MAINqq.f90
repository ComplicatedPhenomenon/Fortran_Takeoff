program main
   use my_fxn
   use MC_VEGAS 
   implicit none


   integer, parameter        :: NDIM = 6
   integer                   :: i,j
   real(kind(0d0))           :: interval
   real(kind(0d0))           :: avgi_qq, sigma_qq, sd, chi2a
   Character(len=40)         :: Tablefile
   character(len = 128)      :: arg
   data Tablefile/'CT14LL.pds'/
   nd = NDIM
   Call SetCT14(Tablefile)

   open(1,file = 'DATAqq.txt', position = 'append', status='unknown')

   interval = 2d0/100
   cos_theta = -1d0
   i = 1

   call get_command_argument(i,arg)
   read(arg,*) j
   cos_theta = cos_theta + j * interval
   call vegas(NDIM,fxn_1,avgi_qq,sd,chi2a,2)

   sigma_qq = avgi_qq * 3.894 * 10 ** 8
   print *, j, cos_theta, sigma_qq
   write(1,*) cos_theta, sigma_qq ,'pb'

   close(1)
end program main

