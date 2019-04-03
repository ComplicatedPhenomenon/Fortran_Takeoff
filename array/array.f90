PROGRAM alloc_array
  IMPLICIT NONE

  INTEGER, DIMENSION(:),   ALLOCATABLE :: x_1d
  INTEGER, DIMENSION(:,:), ALLOCATABLE :: x_2d
  INTEGER, DIMENSION(:, :), ALLOCATABLE :: array
  INTEGER :: row, col

  PRINT *,ALLOCATED(x_1d)
  PRINT *,x_1d

  x_1d = [1,2,3,4,5,6,5,4,3,2,1]
  PRINT *,ALLOCATED(x_1d)
  PRINT *,x_1d
  DEALLOCATE(x_1d)

  PRINT *,ALLOCATED(x_2d)
  ALLOCATE(x_2d(2,3))
  x_2d =RESHAPE([1,2,3,4,5,6], SHAPE(x_2d))
  PRINT *,ALLOCATED(x_2d)
  PRINT *,x_2d
  DEALLOCATE(x_2d)

  ALLOCATE(array(2, 3))
  PRINT *,ALLOCATED(array)
  DO row = 1, 2
     DO col = 1, 3
        array(row, col) = row*col
     END DO
  END DO
  PRINT *,array
  DEALLOCATE (array)
  PRINT *,ALLOCATED(array)
  PRINT *,array
END PROGRAM alloc_array
