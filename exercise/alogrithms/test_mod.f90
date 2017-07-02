program test
  implicit none
  integer,parameter :: seed = 86456
  integer :: i
  print *, '--------------------------test mod--------------------'
  print *, 'mod(12., 3.)',mod(12., 3.)
  print *, 'How computer calculate mod(12,mod(12., 3.) 3)?'
  print *, 'mod(x,y) menas remainder x - INT(x/y)*y'
  print *, 'int(12.,3.)',int(12./3.)
  print *, '--------------------------test randa------------------'
    
  call srand(seed)
  print *, rand(), rand(), rand(), rand()
  print *, rand(seed), rand(), rand(), rand()
  open(9,file = 'RandomNumber.dat', status='unknown')
  do i = 1, 10000
     write (9,*)i, rand()
  end do
  close(9)


end program test
