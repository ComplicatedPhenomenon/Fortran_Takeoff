program main
   use my_fxn
   use MC_VEGAS 
   implicit none

   integer, parameter        :: NDIM = 6
   integer                   :: i, j
   real(kind(0d0))           :: avgi, sd, chi2a
   real(kind(0d0))           :: interval
   Character(len=40)         :: Tablefile
   character(len = 128)      :: arg
   data Tablefile/'CT14LL.pds'/
   Call SetCT14(Tablefile)
   open(1,file = 'DATAdiffqq2.txt',position = 'append', status='unknown')

   interval = 0.9d0 /50
   cos_theta = 0d0

!   do i = 0, 50
   i =1 
   call get_command_argument(i,arg)
   read(arg,*) j
   cos_theta = cos_theta + j * interval
   call vegas(NDIM,fxn_1,avgi,sd,chi2a, 2)

   write(1,*) j, cos_theta, avgi
   print *, j, cos_theta, avgi

!   call dividing_line
!   end do
end program main
