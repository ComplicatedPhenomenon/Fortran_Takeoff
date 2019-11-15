PROGRAM square_and_cube_roots
  IMPLICIT NONE
  INTEGER,PARAMETER :: max_size =10
  INTEGER :: j
  REAL, DIMENSION(max_size) :: value
  REAL, DIMENSION(max_size) :: square_root
  REAL, DIMENSION(max_size) :: cube_root

  DO j=1,max_size
     value(j) = REAL (j) !real 是内置函数
     square_root(j) = SQRT(value(j))
     cube_root(j) = value(j) ** (1.0/3.0)
  END DO
  WRITE(*,100)
100 FORMAT ('0',20x,'Table of square and cube roots',/,&
       4x,' Number Square Root Cube Root',&
       3x,' Number Square Root Cube Root',/,&
       4x,' ====== ========== ==========',&
       3x,' ====== ========== ==========')
  WRITE(*,110) (value(j),square_root(j),cube_root(j),j=1,max_size)
110 FORMAT (2(4x,F6.0,9x,F6.4,6x,F6.4))
  WRITE(*,*)3.*(1./3.)
END PROGRAM square_and_cube_roots
