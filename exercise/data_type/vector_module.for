      module vector_module
      type :: vector
      real :: x
      real :: y
      real :: z
      end type vector
      
      contains
      type(vector) function add_vector(var1,var2)
      implicit none
      type(vector), intent(in) :: var1, var2
      add_vector%x = var1%x + var2%x
      add_vector%y = var1%y + var2%y
      add_vector%z = var1%z + var2%z
      end function add_vector

      end module vector_module
