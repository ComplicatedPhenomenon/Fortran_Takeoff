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

   interval = 2d0 /500
   cos_theta = -0.99d0
!   cos_theta=-0.99399999999999999
   do i = 1, 6
   call vegas(NDIM,fxn_1,avgi,sd,chi2a)
   cos_theta = cos_theta + interval
   call dividing_line
   print *, cos_theta
   print *,i, avgi
   end do
end program main
