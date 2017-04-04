c      module shared_data
c      implicit none
c      save
c
c      real :: pi
c      pi=3.141592653d0
c      end module shared_data

      program volume_of_ball

      use 'SharedData.mod'
      implicit none

      real :: v
      real :: r
      print *,*'r'
      read *,*,r
      v=4/3*pi*r**3
      print *,*'V is ',v
      end program volume_of_ball

