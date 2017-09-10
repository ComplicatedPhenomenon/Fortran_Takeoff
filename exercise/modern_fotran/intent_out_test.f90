! 2017/9 /10  version :: 1.0
module Equity_mod
   implicit none
   private
   public :: Calculate , Get_active , Get_quote , Print
   type , public :: equity_t
   ! active : indicate if stock is volatile
      logical :: active = .false.
      real    :: current_price = 1.0
      integer :: no_of_shares = 0
   end type equity_t
  
   interface Calculate
      module procedure Calc_equity
   end interface Calculate
   interface Print
      module procedure Print_equity
   end interface Print
   contains

      elemental function Calc_equity(this) result (return_val)
         type(equity_t), intent(in) :: this
         real :: return_val

         return_val = this%current_price * this%no_of_shares
      end function Calc_equity

      elemental function Get_active(this) result(return_val)
         type(equity_t), intent(in) :: this
         logical :: return_val

         return_val = this%active
      end function Get_active

      subroutine Get_quote(this)
         type(equity_t), intent(out) :: this

         this%active = .true.
         this%current_price = 10.0
      end subroutine Get_quote

      subroutine Print_equity(this)
         type(equity_t), intent(in) :: this
         write (*,"(A,L1)")"Active is ", this%active
      end subroutine Print_equity
end module Equity_mod

module Account_mod
   use equity_mod, only : Calculate , equity_t, Get_quote 
   implicit none
   private
   public :: Calc_account, Get_quotes

   integer, parameter :: MAX_EQUITIES = 3
   type, public :: account_t
      type(equity_t) :: equities(MAX_EQUITIES)
      end type account_t

   contains
      subroutine Calc_account(this)
         type(account_t), intent(out) :: this
         real :: temp_value
         integer :: i_equity

         do i_equity = 1, size(this%equities)
            temp_value = Calculate(this%equities(i_equity))
         end do
      end subroutine Calc_account

      subroutine Get_quotes(this)
         type(account_t), intent(in out) :: this
         real :: temp_value
         integer :: i_equity
         do i_equity = 1, size(this%equities)
            temp_value = Calculate(this%equities(i_equity))
         end do
      end subroutine Get_quotes
end module Account_mod
   
program intent_out_test
   use account_mod, only : account_t, Calc_account, Get_quotes 
   use Equity_mod, only: Get_active, Print

   type(account_t) :: account
   integer :: i_equity

   call Get_quotes(account)
   do i_equity = 1, size(account%equities)
      if(Get_active(account%equities(i_equity))) call Print(account%equities(i_equity))
   end do

   call Calc_account(account)
   do i_equity = 1, size(account%equities)
      if(Get_active(account%equities(i_equity))) call Print(account%equities(i_equity))
   end do

end program intent_out_test
     

