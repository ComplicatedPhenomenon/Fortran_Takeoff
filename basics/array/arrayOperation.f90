module test_mod
   implicit none
 contains
   elemental real function square(x)
     real, intent(in) :: x
     square = x*x
   end function
 end module

program functional_test
   use test_mod

   implicit none
   real, dimension(3) :: x = (/ 1.0, 2.0, 3.0 /)
   real, dimension(3) :: y = [1.0, 2.0, 3.0]
   character(len = 30) :: s = "ComplicatedPhenomenon"


   print *, square(x)
   print *, square(y)
   print *, s(1:)

end program functional_test
