      module shared_data
      implicit none

      real, parameter :: pi = 3.141592653d0
      complex, dimension(2,2) :: sigmaz =
     <reshape((/(0,0),(0,1),(0,-1),(0,0) /), shape(sigmaz))
      real, dimension(2,2) :: sigmay =
     <reshape((/0,-1,1,0/), shape(sigmay))
      end module shared_data
