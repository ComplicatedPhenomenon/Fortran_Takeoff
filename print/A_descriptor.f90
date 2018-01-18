PROGRAM A_descriptor
IMPLICIT NONE

CHARACTER(LEN = 5) :: a = "12345"
CHARACTER          :: b = "*"
LOGICAL            :: t = .TRUE., f= .FALSE.
WRITE(*,'(A5)') a
WRITE(*,'(A6)') a
WRITE(*,'(A7)') a
WRITE(*,'(A3)') b
WRITE(*,'(A4)') b

WRITE(*,'(L1,L2)') t, f
END PROGRAM A_descriptor 

!---------------------------------------------------
!rAw
!A is for CHARACTER
!w is the width of field, which indicates that a character string should be 
!printed with w positions. 
