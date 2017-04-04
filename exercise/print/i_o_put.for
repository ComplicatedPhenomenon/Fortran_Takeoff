      program square_and_cube_roots
      implicit none
      integer,parameter :: max_size =10
      integer :: j
      real, dimension(max_size) :: value 
      real, dimension(max_size) :: square_root
      real, dimension(max_size) :: cube_root
 
      do j=1,max_size
         value(j) = real (j) !real 是内置函数
         square_root(j) = sqrt(value(j))
         cube_root(j) = value(j) ** (1.0/3.0)
      end do
      write(*,100)
100   format ('0',20x,'Table of square and cube roots',/,
     <4x,' Number Square Root Cube Root',
     <3x,' Number Square Root Cube Root',/,
     <4x,' ====== ========== ==========',
     <3x,' ====== ========== ==========')
      write(*,110) (value(j),square_root(j),cube_root(j),j=1,max_size)
110   format (2(4x,F6.0,9x,F6.4,6x,F6.4))
      write(*,*)3.*(1./3.)
      end program square_and_cube_roots

