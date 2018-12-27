! Define Pauli matrix.
! Define the operations on Pauli matrix or use the library for manipulation of matrix
! update. Give them a name space. sigma is repeated. sigma[3]
program PauliMatrix

   implicit none

   integer, dimension(1:2,1:2):: sigma_1, sigma_3
   complex, dimension(1:2,1:2):: sigma_2
   integer :: i, j

   sigma_1 = reshape ((/ 0, 1, 1, 0 /), (/ 2, 2 /))
   sigma_2 = reshape ((/ (0,0), (0,-1), (0,1), (0,0)/), (/ 2, 2 /))
   sigma_3 = reshape ((/ 1, 0, 0, -1 /), (/ 2, 2 /))

   do i = 1, 2
     do j = 1, 2
      print *, sigma_2(i, j)
     end do
   end do
end program PauliMatrix
