      program test
      implicit none
      integer :: number

      do number=0,15
      if (number<10) then
         print *,number
      end if
      end do 
      end program test

      !用array(1),arr(2),...来访问，也可以指定数据范围
      ! real,dimension(lower_bound : upper_bound) :: array
      !real,dimension(-2,2) :: b1 数组b1用下标－２～２来访问
