program calcule_pi
  implicit none

  ! constants
    real, parameter :: n = 10000

    ! vars
    real, dimension(10000) :: x
    real, dimension(10000) :: y
    integer :: compteur = 0
    integer :: i = 1, j = 1
    real :: resultat
    real :: surface
    real :: a, b
    ! generate a range of n values
    call random_number(x)
    call random_number(y)
    print *, "i = ", x(i)    
    do while (i <= n)
      a = x (i)
      do while (j <= n)
        b = y (j)
        if ((a**2 + b**2) < 1.0) then
          compteur = compteur + 1
        end if
      j = j+1
      end do
      j = 1
      i = i + 1
    end do
    
    ! surface = pi / 4
    surface = compteur / (n*n)
    resultat = surface * 4

    print *, "pi = ", resultat
end program calcule_pi
