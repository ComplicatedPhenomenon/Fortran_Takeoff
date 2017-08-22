program main
   use my_fxn
   use MC_VEGAS
   implicit none

   integer, parameter        :: NDIM = 7
   integer                   :: i,j
   real(kind(0d0))           :: interval
   real(kind(0d0))           :: avgi_qq, sigma_qq, sd, chi2a
   Character(len=40)         :: Tablefile
   character(len = 128)      :: arg
   data Tablefile/'CT14LL.pds'/
   Call SetCT14(Tablefile)
   open(1,file = 'DATAqq.txt', position = 'append', status='unknown')
   interval = 7d3/100
   !do i = 0, 50
   M_D = 3d3
   i = 1
   call get_command_argument(i,arg)
   read(arg,*) j
   M_D = M_D + j*interval
   call vegas(NDIM,fxn_1,avgi_qq,sd,chi2a,2)
   sigma_qq = avgi_qq * 3.894 * 10 ** 8
   print *, j, M_D, sigma_qq
   write(1,*) M_D, sigma_qq ,'pb'

   !end do
   close(1)
end program main
