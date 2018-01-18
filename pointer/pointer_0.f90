PROGRAM ptr_1
IMPLICIT NONE

INTEGER, TARGET     ::  i, istat
INTEGER, DIMENSION(:), POINTER    :: ptr1, ptr2
!check associated status of ptrs
WRITE(*,'(A,2L5)') 'ARE ptr1, ptr2 associated? ', &
        ASSOCIATED(ptr1),ASSOCIATED(ptr2)
!allocate and initialize memery
ALLOCATE(ptr1(1:10), STAT = istat)
print *,'After Allocating ptr1(1:10) is istat =',istat 
ALLOCATE(ptr2(1:10), STAT = istat)
print *,'After Allocating ptr2(1:10) is istat =',istat 
ptr1  = [ (i, i = 1, 10) ]
ptr2  = [ (i, i = 11, 20) ]
!check associated status of ptrs
WRITE(*,'(A,2L5)') 'ARE ptr1, ptr2 associated? ', &
        ASSOCIATED(ptr1),ASSOCIATED(ptr2)
WRITE(*, '(A,10I3)') 'ptr1 = ', ptr1
WRITE(*, '(A,10I3)') 'ptr2 = ', ptr2
ptr2 => ptr1
WRITE(*, '(A,10I3)') 'ptr1 = ', ptr1
WRITE(*, '(A,10I3)') 'ptr2 = ', ptr2

NULLIFY(ptr1)
DEALLOCATE(ptr2, STAT = istat)
END PROGRAM ptr_1
