program test
  implicit none
  integer,parameter :: seed = 86456
  real, dimension(1:5) :: a
  integer :: i
  print *, '---------------------test mod(a, b)--------------'
  print *, 'mod(12., 3.)',mod(12., 3.)
  print *, 'How computer calculate mod(12. ,mod(12., 7.))?', mod(12.,mod(12., 7.))
  print *, 'int(12.,7.)',int(12./7.)
  print *, '----------------------test rand()-----------------'

  call srand(seed)
  print *, rand(), rand(), rand(), rand()
  print *, rand(seed), rand(), rand(), rand()
  open(9,file = 'RandomNumber.dat', status='unknown')
  do i = 1, 10000
     write (9,*)i, rand()
  end do
  close(9)

  print *, '-----------------test random_number()-------------'
  call random_number(a)
  print *, a



end program test
