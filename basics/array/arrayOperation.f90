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
   integer :: c(3,3)=reshape([0,3,2,4,3,2,5,1,2], shape(c))
   integer :: cc(8)=-1

   print *, square(x)
   print *, square(y)
   print *, s(1:)


   write(*,'(3i3)') c        ! writes 0 3 2
                             !        4 3 2
                             !        5 1 2
   write(*,*) pack(c,mask=(c > 2))
                             ! writes 3 4 3 5
   write(*,*) pack(c,mask=(c > 2),vector=cc)
                             ! writes 3 4 3 5 -1 -1 -1 -1 -1
   write(*,*) pack(c,.true.) ! writes 0 3 2 4 3 2 5 1 2

end program functional_test
