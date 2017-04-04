      program task_2
      implicit none

      integer :: a
      real :: pi = 3.1415926
      
      write (*,110) pi
110   format(E12.5)
      write (*,100) pi
100   format(E12.3)
      write (*,90) pi
90    format(E12.3E4)
      write (*,80) pi
80    format(ES12.3E4)
      write (*,70) pi
70    format(ES12.4E4)
      write (*,'("please input an integer?")')
      read(*,*),a
      print *,a
      print *,'hello,WangMiao.'
      write (*,'("How are you?")')
      write (*,*)'How are you?'
      print *
      print *, ' Flavor ID  :   1    2    3    4      5     6'
      print *, ' flavour    :   u    d    s    c      b     t'
      end program task_2


c 这里把一个用户自定义函数当作参数传递给子程序，所有的这些外部过程
c(external procedure)都可以被独立编译。
c 一个程 序单元 是fortran程序中的一个独立编译部分，主程序，子程序，函数子程序
c都可以看做是程序单元，fortunately,Fortran has provide a specific mechanism ,
c可以在构建最终程序前较容易开发和调试子任务
