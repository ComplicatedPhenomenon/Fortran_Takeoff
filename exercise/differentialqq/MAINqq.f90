program main
   use my_fxn
   use MC_VEGAS 
   implicit none

   integer, parameter        :: NDIM = 6
   integer                   :: i
   real(kind(0d0))           :: avgi, sd, chi2a
   real(kind(0d0))           :: interval
   Character(len=40)         :: Tablefile
   data Tablefile/'CT14LL.pds'/
   Call SetCT14(Tablefile)
   open(1,file = 'DATAdiffqq2.txt', status='unknown')

   interval = 0.9d0 /50
   cos_theta = 0d0

   do i = 0, 50
   call vegas(NDIM,fxn_1,avgi,sd,chi2a, 2)

   write(1,*) i, cos_theta, avgi
   print *, i, cos_theta, avgi
   cos_theta = cos_theta + interval

!   call dividing_line
   end do
end program main
