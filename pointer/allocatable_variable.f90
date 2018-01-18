type, public :: start_conds_t
   real, dimension(3) :: coods, dir_cosines
end type start_conds_t

function Comp_disp (no_of_particles) result (return_value)
   implicit none
   
   integer, intent (in) :: no_of_particles
   real  :: reyurn_value

   type (start_conds_t), allocabele :: particles (:)
   integer :: alloc_stat
   integer, parameter :: RAND_NUMS_PER_TYPE = 6


   allocate (start_conds_t :: particles(no_of_particles), stat = alloc_stat)
   alloc1 : if (alloc_stat = 0) then  
      allocate
