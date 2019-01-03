MODULE length_interval
  ! indepENDent of other MODULE
  IMPLICIT NONE
  PRIVATE
  PUBLIC :: flatten_method
CONTAINS
  FUNCTION flatten_method(first_point_coord, second_point_coord) RESULT(interval)
    IMPLICIT NONE
    REAL, DIMENSION (1:3) :: first_point_coord, second_point_coord
    REAL :: interval
    INTEGER :: i
    interval = 0d0
    DO i = 1, 3
      interval = (first_point_coord(i) - second_point_coord(i)) ** 2 + interval
    END DO
  END FUNCTION flatten_method
END MODULE length_interval

PROGRAM test_length_interval
  USE length_interval
  IMPLICIT NONE
  REAL, DIMENSION (1:3) :: x, y
  PRINT *, 'This program is used to calculated the interval between two points'
  PRINT *,'Input the first vector'
  READ (*,*) x(1),x(2),x(3)
  PRINT *,'Input the second vector'
  READ (*,*) y(1),y(2),y(3)
  PRINT *,'The length interval is :', flatten_method(x,y)
END PROGRAM test_length_interval
