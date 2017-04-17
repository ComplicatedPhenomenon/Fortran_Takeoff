program alloc_array
implicit none

integer :: nparticles, i, j, IERR4
integer, parameter                        :: dim = 3
!real, allocatable, dimension(:)           :: charge
integer, allocatable, dimension(:,:)      :: xyz
print *,"Input n"
read(*,*) nparticles
!allocate(charge(Nparticles), xyz(dim, Nparticles))
do 
   allocate(xyz(i,j),stat = IERR4)
   if (IERR4 == 0) exit
   I = i/2; j= j/2
end do
end program alloc_array





!The ALLOCATR statement creats space for allocatable arrays and variables with the pointer attribute. 
!Thre DELLOCATE statements frees space previously  allocated for allocatable arrays and pointer taget.
!These statements give the user ability to manage space dynamically on executation time.
