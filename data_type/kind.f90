program kindCheck
  implicit none

  integer     :: i
  real        :: r
  complex     :: cp
  character   :: c
  logical     :: lg
  !***********************************************************
  !syntax SELECTED_REAL_KIND(P, R, RADIXI)I
  !A real data type with decimal precision at least P digits
  !a deciaml exponent range of at least R
  !and with the requested RADIX
  !***********************************************************

  integer, parameter :: p6 = selected_real_kind(6)
  integer, parameter :: p10r100 = selected_real_kind(10,100)
  integer, parameter :: r400 = selected_real_kind(r=400)
  real(kind=p6)      :: x
  real(kind=p10r100) :: y
  real(kind=r400)    :: z

  write(*,*)"________________________________________________"
  print *,'The default kind of different data type '
  print *,'Real     ', kind(r)
  print *,'Complex  ', kind(cp)
  print *,'Character', kind(c)
  print *,'Logical  ', kind(lg)
  write(*,*)"________________________________________________"
  print *, "precision & range ",precision(x),range(x)
  print *, "precision & range ",precision(y),range(y)
  print *, "precision & range ",precision(z),range(z)
  write(*,*)"________________________________________________"
  print *,41_p6
end program kindCheck
