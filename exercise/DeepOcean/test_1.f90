module mad_science
   real, parameter  :: pi = 3.
end module mad_science
! real, parameter, parameter(inout)  :: pi = 3.
! symbol at (1) is not a DUMMY variable
program t
   use mad_science, mad_pi => pi ! change the name of pi(so you can declare your own correct pi ) 
                                 ! mad_pi => pi : refer to pi from the module as mad_pi
! [ implicit none ] works well if everything is correct, won't prompt error if some var declaration is missing 
   real, parameter :: pi = 3.1415

   print *, 'mad_pi = ', mad_pi
   print *, '    pi = ', pi
end program t

! Intent : In, Out, InOut
! You would put this information in the comment anyway
! Improve maintainability
! compiler will check for misuse
!   subroutine calc(result, a, b, c, d)
!   ! This routine calculates ...
!   ! Input : a, b, c
!   ! Output : result
!   ! d is scratch datta : Input and Output
