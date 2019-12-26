PROGRAM alloc_array
  IMPLICIT NONE

  CHARACTER(LEN = 4), ALLOCATABLE :: symbols(:)
  INTEGER, DIMENSION(:, :), ALLOCATABLE :: x_2d
  INTEGER, DIMENSION(:, :), ALLOCATABLE :: array
  INTEGER :: n, row, col

  symbols = ['AAPL', 'AMZN', 'CRAY', 'CSCO', 'HPQ ',&
  'IBM ', 'INTC', 'MSFT', 'NVDA', 'ORCL']

  DO n = 1, size(symbols)
   WRITE(*,*) 'Working on ' // symbols(n)
  END DO

  DEALLOCATE(symbols)

  ALLOCATE(x_2d(2,3))
  x_2d =RESHAPE([1,2,3,4,5,6], SHAPE(x_2d))
  PRINT *, ALLOCATED(x_2d)
  PRINT *, x_2d
  PRINT *, x_2d + 1
  PRINT *, SUM(x_2d)
  PRINT *, SUM(x_2d, mask = mod(x_2d, 2) == 1)
  DEALLOCATE(x_2d)

  ALLOCATE(array(2, 3))
  PRINT *, ALLOCATED(array)
  DO row = 1, 2
     DO col = 1, 3
        array(row, col) = row*col
     END DO
  END DO
  !array = [(row*col), row = 1, 2, col = 1, 3]
  PRINT *,array
  DEALLOCATE (array)
  PRINT *,ALLOCATED(array)
  PRINT *,array
END PROGRAM alloc_array
