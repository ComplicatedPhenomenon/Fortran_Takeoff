! Lacks of user friendly interface
PROGRAM TEST_POINTER_TARGET
   IMPLICIT NONE
   INTEGER, POINTER :: pt
   INTEGER, TARGET  :: x, y
   INTEGER          :: a, b, tem

   x = 0
   y = 1
   write(*,*) ASSOCIATED(pt) !Associated - when pointing to a valid target.
   WRITE(*,*) 'x = ',  x, ' y = ', y
   pt => x
   write(*,*) ASSOCIATED(pt) 
   y = pt    !y equals x, pt is dereferenced
   WRITE(*,*) 'x = ',  x, ' y = ', y
 
   pt = 2
   WRITE(*,*) 'x = ',  x, ' y = ', y

   PRINT *, 'compare with none pointer type'
   a = 0
   b = 1
   WRITE(*,*)'a = ', a, 'b = ', b

   tem = a
   b = tem
   WRITE(*,*)'a = ', a, 'b = ', b

   tem =2
   WRITE(*,*)'a = ', a, 'b = ', b

END PROGRAM TEST_POINTER_TARGET

