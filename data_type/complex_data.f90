program complexarithmatic
  implicit none
  character(len=80) :: text
  integer           :: int_i
  complex :: x, y, z

  text = 'The intrinsic data type character stores characters and strings.'
  int_i = index(text, 'character')
  x = (7, 8)
  y = (5,-7)

  print *,"x = ", x, "y = ", y
  print *,"x * y = ",  x * y

  print *, 'Demonstrate how intrinsic function index work on characters'
  print *,'What in text is: ', text
  if(int_i /= 0)then
    print *,'How many characters in text',int_i
  end if
end program complexarithmatic
