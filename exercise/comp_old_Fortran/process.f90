module aa
   implicit none
   private
   public    :: NDIM,             &               
                k1, k2, p3, p4, k,&   
                S, sqrts,         &
                jacobian, fourvectordot, &
                sp, dp, qp          
   integer, parameter :: sp = selected_real_kind(6)             
   integer, parameter :: dp = selected_real_kind(15)             
   integer, parameter :: qp = selected_real_kind(33) 
   integer, parameter :: NDIM = 2
   integer   :: i
   real(dp), dimension(0:3) :: k1, k2, p3, p4, k 
   real(dp)                 :: S, sqrts
   contains
      double precision function fourvectordot(k1,k2)
      real(dp), dimension(0:3) :: k1, k2
!---------------------------------------------------------------------------
! why I have to declare the datatype of k1 and k2 not like in the test main
! program, if I don't, I get `Symbol ‘k1’ at (1) has no IMPLICIT type` 
!---------------------------------------------------------------------------
     fourvectordot = k1(0) * k2(0)
     do i = 1, 3
        fourvectordot = fourvectordot - k1(i) * k2(i)
     end do
     end function fourvectordot

     subroutine jacobian(jacobianfactor, upper, lower) 
!--------------------------------------------------------------------------
! upper, lower, jacobianfactor,these arguments are local 
!---------------------------------------------------------------------------
     real(dp), dimension(1:2) :: upper, lower
     real(dp) ::jacobianfactor
    
     jacobianfactor = 1d0
     do i = 1, NDIM
        jacobianfactor = jacobianfactor * (upper(i) - lower(i))
     end do
     end subroutine jacobian


end module aa
