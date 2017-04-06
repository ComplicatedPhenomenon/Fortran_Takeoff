      program ch1205
      implicit none

      integer :: i
      real :: small = 1.0 
      real :: big =1.0
      integer :: lageval , wm 

      wm = 2 ** 30 -1 + 2 ** 30
      print *, huge(lageval)
      print *, wm
      do i=1,50   
        print 100,i,small,big
100     format (' ',i3,' ',e10.4,' ',e10.4)
        small = small/10.0
        big = big *10.0
      end do 
      
      end program ch1205

      !======================================================

      real function ave_value (func,first_value,last_value,n)
      implicit none

      real, external :: func
      real,intent(in) :: first_value
      real,intent(in) :: last_value
      integer,intent(in):: n
      real :: delta !step size between samples
      integer :: i
      real :: sum
     
      delta = (last_value-first_value)/real(n-1)
      sum = 0
      do i=1,n
	 sum = sum + func ( real(i-1) * delta ) 
      end do
      ave_value = sum / real(n)
      end function ave_value
c
      program test_ave_value
   
      implicit none
      real :: ave_value
      real, external :: my_function
      real :: ave
      ave = ave_value(my_function,0.,1.,101)
      write (*,1000) 'my_function', ave
1000  format (1x,'the average value of ',A,'between 0. and 1. is',
     <F16.6,'.')
      end program test_ave_value
c     
      real function my_function(x)
      implicit none
      real,intent(in) :: x
      my_function = 3. * x ** 3
      end function my_function
