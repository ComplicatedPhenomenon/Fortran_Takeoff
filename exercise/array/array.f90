!  假设要计算100个不同实数的平方根，若数据存储为一个由100个
! 实型数值组成的数组元素，那么代码
! Do i=1,100
!    a(i)=sqrt(a(i))
! end do
!　将计算出每个实数的平方根，然后回存到它们原来的内存位置
!what actually confuse me is if I didn't define a(i) as an array
!instead I define it as real variable ,it can achieve the same result!

!在使用数组之前，它包含的元素类型和个数必须用类型声明语句来向编译器声明
!实型数组　　　　　　　
!real dimension(16) :: voltage
!字符型数组
!character (len=20) ,dimension(50) :: last_name
! 数组还可以用多个下标来声明，用来表示多个数组表示的复杂变量
      
program squares
implicit none 
integer :: i
integer, dimension(-1:9) :: number, square
character(len=10), dimension(4) :: lyrics0
character(len=12), dimension(11) :: lyrics1

do i = -1 , 9
   number(i) = i 
   square(i) = number(i) ** 2
end do
lyrics0 = (/ 'Shots     ', '__________', 'Imagine   ' , 'Dragons   ' /)
print *,'Input your favorate lyrics in Shots'
do i = 1, 11
   read(*,*) lyrics1(i)
end do

do i = -1, 9
   write (*,100) number(i),square(i)
100    format (1x,'number = ',I6,'   ', 'square = ',I6)
end do

do i = 1, 4
   print *,lyrics0(i)
end do

print *,'your favorate lyrics in Shots is'
do i = 1, 11
   print *, lyrics1(i)
end do
print *,'I shot shot shot a hole through everything that I love'
end program squares

!All the entities must have the same length when you initialise a character
!so I have to pad each short entry with enough spaces to make them all equally long.
!The alternative would be to insert the entries when program execution starts. if you write something like lyrics = 'a' then
!the additional characters will be set to spaces, the compiler will take care of that for you.
