      function dot_vec(p,q) result(fourvectordot)
         implicit none
         integer :: i,j 
         real(kind(0d0)), dimension(0:3) :: p,q

         fourvectordot = p(0) * q(0)
         do i = 1, 3
            fourvectordot = fourvectordot - p(i) * q(2,i)
         end do
      end function fourvectordot
