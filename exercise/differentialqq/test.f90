program test
   use, intrinsic :: iso_fortran_env, only : R4P=>real32, R8P=>real64, R16P=>real128 
   implicit none
   integer      :: i
   real(R4P)    :: j,n
   real         :: j0,n0
   real(kind(0d0))  :: j1, n1
   real(R8P)    :: j2, n2
   real(R16P)   :: j3, n3
   j =  1._R4P
   j0 = 1./50
   j1 = 1.d0/50
   j2 = 1._R16P/50
   j3 = 1._R8P/50
   print *,'------- ----R4P---------------'
   loop:do i = 0, 10
      n = 1. + j * i  
      print *, n
   end do loop
   print *,'-----------default--------------'
   loop1:do i = 0, 10
      n0 = 1. + j0 * i  
      print *, n0
   end do loop1
   print *,'--------kind(0d0)------------'
   loop2:do i = 0, 10
      n1 = 1. + j1 * i  
      print *, n1
   end do loop2
   print *,'----------R8P---------'
   loop3:do i = 0, 10
      n2 = 1. + j2 * i  
      print *, n2
   end do loop3
   print *,'----------R16P---------'
   loop4:do i = 0, 10
      n3 = 1. + j3 * i  
      print *, n3
   end do loop4
  
end program test
