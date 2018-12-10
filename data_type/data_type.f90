program testingInt
implicit none

real(4) :: shortval
real(8) :: longval
real :: defval
integer :: i
!===============================================================!
! print out 2**127 always get the error "Arithematica overflow  !
! I know in Fortran the LHS is evaluated before assigning to the!
! RHS. so `real(kind=8) :: var = 2d0**127d0`is invalid          !
!===============================================================!

integer, parameter :: dp1 = kind(1.)
integer, parameter :: dp2 = kind(0.0d0)
real(kind = 4) :: mantissa1
real(kind = 8) :: mantissa2

mantissa1 = 0d0
mantissa2 = 0d0

do i = 0, 23
   mantissa1 = mantissa1 + 1./(2 ** i)
end do


do i = 0, 52
   mantissa2 = mantissa2 + 1d0/(2d0 ** i)
end do

write (*,*) 2d2,2e2, 2d2-2e2
write(*,*)"------------------------------------------------------------------------------"
print *,"KIND(1.)=",kind(1.)
print *,"kind(1d0)= ",kind(1d0)
print *,"kind of real = ",kind(defval)
write(*,*)"------------------------------------------------------------------------------"
write(*,*)"Ranges of floating point datatypei with kind = 4 in Fortran"
print *,"The lagest number : mantissa1 * 2d0 ** 127_dp1 = ",mantissa1 * 2d0 ** 127.
print *,"The smallest numer: mantissa1 * 2d0 ** 127_dp1 = ",mantissa1 * 2d0 ** (-127.)

write(*,*)"------------------------------------------------------------------------------"
write(*,*)"Ranges of floating point datatypei with kind = 8 in Fortran"
print *,"The lagest number : mantissa2 * 2d0 ** 1023_dp2 = ",mantissa2 * 2d0 ** 1023_dp2
print *,"The smallest numer: mantissa2 * 2d0 ** 1023_dp2 = ",mantissa2 * 2d0 ** (-1023_dp2)

write(*,*)"------------------------------------------------------------------------------"
write(*,*)"Fetch the parameters by intrinsic functions"
print *,"The largest number of real with kind=4 is  :",huge(shortval)
print *,"The tinest number of real with kind=4 is  : ",tiny(shortval)
print *,"The largest number of real with kind=8 is  :",huge(longval)
print *,"The tinest number of real with kind=8 is  :",tiny(longval)
print *,"The largest number of real with default kind is :",huge(defval)
write(*,*)"------------------------------------------------------------------------------"
end program testingInt
