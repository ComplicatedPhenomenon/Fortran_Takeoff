! Define Pauli matrix.
! Define the operations on Pauli matrix or use the library for manipulation of matrix
! update. Give them a name space. sigma is repeated. sigma[3]
PROGRAM PauliMatrix

  IMPLICIT NONE

  INTEGER, DIMENSION(1:2,1:2):: sigma_1, sigma_3
  COMPLEX, DIMENSION(1:2,1:2):: sigma_2
  INTEGER :: i, j

  sigma_1 = RESHAPE ((/ 0, 1, 1, 0 /), (/ 2, 2 /))
  sigma_2 = RESHAPE ((/ (0,0), (0,-1), (0,1), (0,0)/), (/ 2, 2 /))
  sigma_3 = RESHAPE ((/ 1, 0, 0, -1 /), (/ 2, 2 /))
  WRITE (*,*) "Fortran array is column-contigious"
  DO i = 1,2 
    PRINT *, LOC(sigma_3(1, i))
  END DO
  WRITE (*,*) sigma_2
END PROGRAM PauliMatrix
