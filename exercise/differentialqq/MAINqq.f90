program main
   use my_fxn
   use MC_VEGAS 
   implicit none

   integer, parameter        :: NDIM = 6
   integer                   :: i
   real(kind(0d0))           :: avgi_qq, sd, chi2a
   real(kind(0d0))           :: interval
   Character(len=40)         :: Tablefile
   data Tablefile/'CT14LL.pds'/
   Call SetCT14(Tablefile)

   interval = 2d0 /1000
   cos_theta = -1d0
   print *,'***************************************************************'
   print *,' ************      ***********        *****         ***********'
   print *,'      *            *                 *                   *     '    
   print *,'      *            *                 *                   *     '    
   print *,'      *            ********           *****              *     '             
   print *,'      *            *                       *             *     '   
   print *,'      *            *                       *             *     '    
   print *,'      *            ***********        *****              *     '                
   print *,'                                                               '
   print *,'                                                               '
   print *,'***************************************************************'
   do i = 1, 3
      !*******************************************
      !     Transform cos_theta to module my_fxn
      !*******************************************
      call vegas(NDIM,fxn_1,avgi_qq,sd,chi2a)
      open(1,file = 'DATAqq.txt', access='append', status='unknown')
      write(1,*) 'i',i, avgi_qq
      print *,'*********************************'
      print *,'B cos_theta=', cos_theta
      print *,'*i =',i,'result =',avgi_qq
      !print *,'*i = ',i
      cos_theta = cos_theta +  interval 
      print *,'A cos_theta=', cos_theta
      print *,'*********************************'
   end do
   close(1)
end program main
