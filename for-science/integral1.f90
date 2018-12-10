program integral1
  implicit none
  
  ! constants
  real, parameter :: a = 2.D0

  !! variables
  real :: x = 0 ! x (1)
  integer :: n = 1
  ! s est la somme des f(xi)
  real :: s = 0
  ! i sert à garder la valeur de l'integrale justqu'à x(n) lorsqu'on est à l'étape x(n+1)
  real(kind=16) :: i 
  real :: y ! x'
  real :: r ! r (n)
  real :: rr
  real :: minim
  ! la precision
  real(kind=16)  :: p = 1
  ! l'integrale
  real(kind=16) :: integral
  
  ! integral au debut = 1/1 * s  
  integral = s

  !! tant que les f(xi) ne convergent pas ou que le nombre d iterations est petit 
  do while (p>0.0000000000000000001 .or. n<1500)
    ! incrementer n
    n = n + 1
    ! garder l'ancienne valeur de l integrale pour calcule de la precision
    i = integral

    ! generer r (n)
    call random_number(r)

    ! generer un nombre uniformement dans l interval x(n)-a , x(n)+a
    call random_number(rr)
    y = x - a + ( rr * 2 * a )

    ! calculer le minimum
    minim = MIN(1.0, EXP(-y**2)/EXP(-x**2))

    ! etape 4
    if ( r <= minim ) then
      x = y
      ! else x garde son ancienne valeur 
    end if
    
    ! calcule du cumul des f(xi)
    s =  s + abs(x) 
    ! diviser par n
    integral =  s*1/n
    
    ! calcule de la precision (difference entre l'ancienne valeur de l'integral et la nouvelle)
    p = abs(integral - i)
  
    end do

  ! le resultat est integrale * racine de pi
  integral = integral * SQRT(4.D0*DATAN(1.D0))

  print *, "La valeur de l'integrale est = ", integral 

end program Integral1

