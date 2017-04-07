      program outputdata
      implicit none
      
      real, dimension(100) :: x, y
      integer :: i
      character (len=200) :: text
      text = 'WANGMIAO, I HOPE U CAN UNDERSTAND, THE SPACE IS VERY LIMIT
     <ED, SO U NRRD TO BE MAKE GOOD USE OF IT'
      open(9, file = 'secrets.txt', status = 'old')
      write (9,*) text
      close(9)

      do i = 1, 100
      x(i) = 0.1 * i
      y(i) = sin(x(i)) 
      end do

      !output data into a file
      open(1, file = 'data1.dat',status = 'old')
      do i = 1, 100
      write (1,*) x(i), y(i)
      end do 

      close(1)

      end program outputdata

