program matrix
   use ISO_FORTRAN_ENV, only : I8=>INT8, I16=>INT16, I32=>INT32, I64=>INT64
   implicit none
   integer(I8)   :: a1
   integer(I16)  :: a2
   integer(I32)  :: a3
   integer(I64)  :: a4
   real(kind=4), dimension(1:4) :: r1
   real(kind=4), dimension(4,2) :: r2
   real, allocatable, dimension( :,:) :: b
   a1 = 3
   print *,'**********HUGE returns the largest number of a kind**********'
   print *, huge(a1), huge(a2), huge(a3), huge(a4)
   print *,'**********REAL converts a type to real type *****************'
   print *, real(a1), real(a1,kind = 8)
   print *,'**************Array manipulation *****************************'
   ! initialize a 
   r1 = [2,3,4,5]
   print *,r1

end program matrix
