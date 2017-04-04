      !  假设要计算100个不同实数的平方根，若数据存储为一个由100个
      ! 实型数值组成的数组元素，那么代码
      ! Do i=1,100
      !    a(i)=sqrt(a(i))
      ! end do
      !　将计算出每个实数的平方根，然后回存到它们原来的内存位置
      !what actually confuse me is if I didn't define a(i) as an array
      !instead I define it as real variable ,it can achieve the same result!

      !在使用数组之前，它包含的元素类型和个数必须用类型声明语句来向编译器声明
      !实型数组　　　　　　　字符型数组
      !real dimension(16) :: voltage
      !character (len=20) ,dimension(50) :: last_name
      ! 数组还可以用多个下标来声明，用来表示多个数组表示的复杂变量
      
      program squares
      implicit none 
      integer :: i
      integer, dimension(10) :: number, square

      do i=1,10
         number(i) = i 
         square(i) = number(i) ** 2
      end do
      do i=1,10
         write (*,100) number(i),square(i)
100      format (1x,'number = ',I6,'   ', 'square = ',I6)
      end do 
      end program squares
