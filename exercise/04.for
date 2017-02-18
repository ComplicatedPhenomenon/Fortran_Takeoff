<<<<<<< HEAD
      PROGRAM ch0901
      IMPLICIT NONE
      real :: Total=0.0,Average=0.0
      real , dimension(1:12):: rainfall 
c rain fall is the name of the array
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
      end program ch0901

=======
      program ch0805
      implicit none 
      integer :: i
      real :: r
      logical :: l
      character :: c
      complex :: cp


      print *,'integer',kind(i)
      print *,'real',kind(r)
      print *,'logical',kind(l)
      print *,'character',kind(c)
      print *,'complex',kind(cp)
      print *,huge(i)
      print *,'2的30次方是',2**30
      end program ch0805



c KIND内置函数会输出系统默认real,integer,logical等变量
c 使用的种类值
>>>>>>> 854050ac0255a92e44494d18fa0a94b5ff4087e3
