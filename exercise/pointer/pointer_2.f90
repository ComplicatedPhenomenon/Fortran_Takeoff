PROGRAM TEST_POINTER_USAGE
      IMPLICIT NONE
      integer, pointer :: pt1, pt2
      ALLOCATE(pt1, pt2) 
      ! Allocating storage to pointers can provide a great degree of flexibility
      ! when programming, however care must be taken to avoid certain programming errors
      pt1 => pt2

      DELLOCATE(pt1)

END PROGRAM TEST_POINTER_USAGE
