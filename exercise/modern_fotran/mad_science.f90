module mad_science

real, parameter :: pi = 3.
type scientist
  character(len = 10) :: name
  real                :: height
  logical             :: mad
end type scientist

private :: reset

contains
subroutine set_mad(s)
implicit none
type(scientist) :: s
s%mad = .false.
end subroutine set_mad

subroutine set_crazy(s)
type(Scientist) :: s
call reset(s)
s%mad = .true.
end subroutine set_crazy

subroutine reset(s)
implicit none
type(scientist) :: s
s%name = 'undef'
s%mad = .false.
end subroutine reset
end module mad_science
