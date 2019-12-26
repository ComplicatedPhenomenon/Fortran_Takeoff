PROGRAM testHowToPassParameter
  IMPLICIT NONE
  INTEGER :: z = 0, res
  PRINT *, "Before addOneBR z = ", z
  PRINT *, "Add one to z by addOneBR, we get ", addOneBR(z)
  PRINT *, "After addOneBR  z has been changed, z = ", z
  z = 0
  PRINT *, "Before addOneBR z = ", z
  res = pure_addOneBR(z)
  PRINT *, "Add one to z by pure_addOneBR, we get ", res
  PRINT *, "After pure_addOneBR  z has been changed, z = ", z
  z = 0
  PRINT *, "Before addOneBV z = ", z
  PRINT *, "Add one to z by addOneBV, we get ", addOneBV(z)
  PRINT *, "After addOneBV  z doesn't change as it was protected, from being modified z = ", z

CONTAINS
  FUNCTION addOneBR(x) RESULT(y)
    IMPLICIT NONE
    INTEGER :: x, y
    x = 8
    y = x + 1
  END FUNCTION addOneBR

  PURE FUNCTION pure_addOneBR(x) RESULT(y)
    IMPLICIT NONE
    INTEGER, INTENT(IN) :: x
    INTEGER :: y
    
    y = x + 1
  END FUNCTION pure_addOneBR

  FUNCTION addOneBV(x) RESULT(y)
    IMPLICIT NONE
    INTEGER, VALUE :: x
    INTEGER :: y
    x = 8
    y = x + 1
  END FUNCTION addOneBV
END PROGRAM testHowToPassParameter
