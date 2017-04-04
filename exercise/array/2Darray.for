      program 2Darray
      implicit none

      real :: Total=0.0,Average=0.0
      real , dimension(1:12):: rainfall 
      integer :: month
      print *,'Type in yje rainfall values'
      print *,'one per line'
      do month=1,12
        read *,rainfall(month)
      enddo
      do month=1,12
        total=total+rainfall(month)
      enddo
      average=total/12
      print *,'Average monthly rainfall was'
      print *,Average
      
      end program 2Darray

