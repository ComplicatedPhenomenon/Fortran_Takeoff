module module_functions
   ! Define functions.
   use, intrinsic :: iso_fortran_env, only : R8P=>real64
   implicit none
   private
   public :: my_function
   public :: my_cos
   public :: my_sin
   public :: my_exp
   public :: my_comply

   abstract interface
      ! Define the function prototype. Define as many interfaces as you need.
      function my_function(x) result(my_result)
         ! Define the interface of my function prototype.
         import :: R8P
         real(R8P), intent(in) :: x         ! The independent abscissa.
         real(R8P)             :: my_result ! The result of my function.
      endfunction my_function                                                                                                
   endinterface                                                                                                              
                                                                                                                             
   contains                                                                                                                  
      function my_cos(x) result(my_result)
         ! Just a function of mine: this could be complicated as you want.
         real(R8P), intent(in) :: x         ! The independent abscissa.
         real(R8P)             :: my_result ! The result of my function.

         my_result = cos(x)
      endfunction my_cos

      function my_sin(x) result(my_result)
         ! Just a function of mine: this could be complicated as you want.
         real(R8P), intent(in) :: x         ! The independent abscissa.
         real(R8P)             :: my_result ! The result of my function.

         my_result = sin(x)
      endfunction my_sin

      function my_exp(x) result(my_result)
         ! Just a function of mine: this could be complicated as you want.
         real(R8P), intent(in) :: x         ! The independent abscissa.
         real(R8P)             :: my_result ! The result of my function.

         my_result = exp(x)
      endfunction my_exp

      function my_comply(x) result(my_result)
         ! Just a complicated function handled by external preprocessor.
         real(R8P), intent(in) :: x         ! The independent abscissa.
         real(R8P)             :: my_result ! The result of my function.

         include 'comply_expression.inc'
      endfunction my_comply
endmodule module_functions

module module_worker
   ! Define worker.
   use, intrinsic :: iso_fortran_env, only : R8P=>real64
   use module_functions
   implicit none
   private
   public :: worker

   contains
      subroutine worker(selection, x, work, function_a, function_b, function_c)
         ! Work dispatcher. This is unnecessary complicated, only to show some features.
         character(len=*),       intent(in)  :: selection  ! User selection.
         real(R8P),              intent(in)  :: x          ! The independent abscissa.
         real(R8P),              intent(out) :: work       ! Work result.
         procedure(my_function), optional    :: function_a ! Function "a".
         procedure(my_function), optional    :: function_b ! Function "b".
         procedure(my_function), optional    :: function_c ! Function "c".

         select case(trim(adjustl(selection)))
         case('a')
            if (present(function_a)) then
               work = function_a(x=x)
            else
               error stop 'error: "function_a" has been selected but not passed'
            endif
         case('b')
            if (present(function_b)) then
               work = function_b(x=x)
            else
               error stop 'error: "function_b" has been selected but not passed'
            endif
         case('c')
            if (present(function_c)) then
               work = function_c(x=x)
            else
               error stop 'error: "function_c" has been selected but not passed'
            endif
         case default
            ! use the first passed function
            if (present(function_a)) then
               work = function_a(x=x)
            elseif (present(function_b)) then
               work = function_b(x=x)
            elseif (present(function_c)) then
               work = function_c(x=x)
            else
               error stop 'error: no selection neither function have been passed'
            endif
         endselect
      endsubroutine worker
endmodule module_worker

program dispatcher
   ! Test work dispatcher.
   use, intrinsic :: iso_fortran_env, only : R8P=>real64
   use module_functions
   use module_worker
   implicit none

   real(R8P) :: work

   call worker(selection='a', function_a=my_sin, function_c=my_cos, x=0._R8P, work=work)
   print*, 'sin(0) = ', work

   call worker(selection='c', function_a=my_sin, function_c=my_cos, x=0._R8P, work=work)
   print*, 'cos(0) = ', work

   call worker(selection='exp', function_b=my_exp, x=0._R8P, work=work)
   print*, 'exp(0) = ', work

   call worker(selection='a', function_a=my_comply, x=0._R8P, work=work)
   print*, 'comply(0) = ', work

endprogram dispatcher
