module ran001
  implicit none
  save

  integer :: n= 9876
end module ran001

!---------------------------------------------------
subroutine random0(ran)
  use ran001
  implicit none

  real,intent (out) :: ran
  !--------------------------------------------------
  n = mod (8121 * n + 28411,134456)
  ran = real (n) / 134456.
end subroutine random0

!===================================================
subroutine seed (iseed)
  use ran001
implicit none

integer, intent (in) :: iseed
  n = abs (iseed)
end subroutine
!===================================================

program test_random0
  implicit none
  real    :: ave
  integer :: i
  integer :: iseed
  integer :: iseq
  real    :: ran
  real    :: sum

  write (*,*) 'Enter seed: '
  read (*,*) iseed

  call seed(iseed)
  write (*,*) '10 random numbers '
  do i = 1, 10
    call random0(ran)
    write (*,'(3X,F16.6)') ran
  end do
  write (*,*) 'Average of 5 consecutive 1000-sample sequence'
  do iseq = 1, 5
    sum = 0.
    do i = 1, 1000
      call random0(ran)
      sum = sum + ran
    end do
    ave = sum / 1000.
    write (*,'(3X, F16.6)') ave
  end do
end program test_random0
