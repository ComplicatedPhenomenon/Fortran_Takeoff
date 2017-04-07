      subroutine length_interval(x1,y1,z1,x2,y2,z2,l_interval)
      implicit none

      real :: x1, x2
      real :: y1, y2
      real :: z1, z2
      real :: l_interval

      l_interval = sqrt((x1 - x2) ** 2 + (y2 - y1) ** 2 +
     <(z2-z1 ) ** 2 )

      end subroutine length_interval

      program test_length_interval
      implicit none
      real :: x1, x2, x3, y1, y2, y3, l

      print *,'input the components of vec1'
      read (*,*) x1,x2,x3
      print *,'input the components of vec2'
      read (*,*) y1,y2,y3
      call length_interval(x1,x2,x3,y1,y2,y3,l)
      print *,'The length interval is :', l
      end program test_length_interval
