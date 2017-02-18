<<<<<<< HEAD
      program substract
      real:: a=1.0002
      real:: b=1.0001
      real:: c
      c=a-b
      print *,a
      print *,b
      print *,c
      end program substract
=======
      program ch1205
      implicit none
      integer :: i
      real :: small = 1.0 
      real :: big =1.0
      
      do i=1,50   
        print 100,i,small,big
100     format (' ',i3,' ',e10.4,' ',e10.4)
        small = small/10.0
	big = big *10.0
      end do 
      end program ch1205
>>>>>>> 854050ac0255a92e44494d18fa0a94b5ff4087e3
