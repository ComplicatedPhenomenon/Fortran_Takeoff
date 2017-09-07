program main
   use my_fxn
   use MC_VEGAS 
   implicit none

   integer, parameter        :: NDIM = 7
   integer                   :: i,j
   real(kind(0d0))           :: interval
   real(kind(0d0))           :: avgi_gg, sigma_gg, sd, chi2a
   Character(len=40)         :: Tablefile
   character(len = 128)      :: arg
   data Tablefile/'CT14LL.pds'/

   nd = NDIM

   Call SetCT14(Tablefile)
   open(1,file = 'DATAgg2.txt', position = 'append', status='unknown')
   interval = 7d3/300

   M_D = 3d3
   i = 1
   call get_command_argument(i,arg)
   read(arg,*) j
   M_D = M_D + j*interval
   call vegas(NDIM,fxn_2,avgi_gg,sd,chi2a,2)
   sigma_gg=avgi_gg*3.894*10**8
   print *, j, M_D, sigma_gg
   write(1,*) M_D, sigma_gg ,'pb'

   close(1)
end program main
