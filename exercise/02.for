<<<<<<< HEAD
      program task_2
      print *,'hello,WangMiao.'
      write (*,'("How are you?")')
      write (*,*)'How are you?'
      print *
      print *,
     > ' Flavor ID  :   1    2    3    4      5     6'
      print *,
     > ' flavour    :   u    d    s    c      b     t'
      end
=======
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

c 这里把一个用户自定义函数当作参数传递给子程序，所有的这些外部过程
c(external procedure)都可以被独立编译。
c 一个程 序单元 是fortran程序中的一个独立编译部分，主程序，子程序，函数子程序
c都可以看做是程序单元，fortunately,Fortran has provide a specific mechanism ,
c可以在构建最终程序前较容易开发和调试子任务
>>>>>>> 854050ac0255a92e44494d18fa0a94b5ff4087e3
