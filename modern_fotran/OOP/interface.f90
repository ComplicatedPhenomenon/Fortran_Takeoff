! http://fortranwiki.org/fortran/show/interface_mod
! A module containing function interfaces
module mod_interfaces
  use iso_fortran_env, only: i1 => int8, i2 => int16, i4 => int32, i8 => int64, &
                          r4 => real32, r8 => real64, r16 => real128
  implicit none
  private
  public :: square 
  
  interface square
      module procedure :: square_i1, square_i2, square_i4, square_i8
      module procedure :: square_r4, square_r8, square_r16 
      module procedure :: square_c4, square_c8, square_c16
  end interface square
  
  contains

  pure function square_i1(x) result(res)
    integer(i1), intent(in) :: x 
    integer(i1) :: res
    res = x * x
  end function square_i1

  pure function square_i2(x) result(res)
    integer(i2), intent(in) :: x 
    integer(i2) :: res
    res = x * x
  end function square_i2

  pure function square_i4(x) result(res)
    integer(i4), intent(in) :: x 
    integer(i4) :: res
    res = x * x
  end function square_i4

  pure function square_i8(x) result(res)
    integer(i8), intent(in) :: x 
    integer(i8) :: res
    res = x * x
  end function square_i8

  pure function square_r4(x) result(res)
    real(r4), intent(in) :: x 
    real(r4) :: res
    res = x * x
  end function square_r4

  pure function square_r8(x) result(res)
    real(r8), intent(in) :: x 
    real(r8) :: res
    res = x * x
  end function square_r8

  pure function square_r16(x) result(res)
    real(r16), intent(in) :: x 
    real(r16) :: res
    res = x * x
  end function square_r16 

  pure function square_c4(x) result(res)
    complex(r4), intent(in) :: x 
    complex(r4) :: res
    res = x * x
  end function square_c4

  pure function square_c8(x) result(res)
    complex(r8), intent(in) :: x 
    complex(r8) :: res
    res = x * x
  end function square_c8

  pure function square_c16(x) result(res)
    complex(r16), intent(in) :: x 
    complex(r16) :: res
    res = x * x
  end function square_c16
end module mod_interfaces
  
  
! A simple control program showing how to use the func interface
program main
  use mod_interfaces, only: square
  use iso_fortran_env, only: i1 => int8, i2 => int16, i4 => int32, i8 => int64, &
                          r4 => real32, r8 => real64, r16 => real128
  implicit none

  write (*, *)  square(1_i1)
  print *, square(1_i2)
  print *, square(1_i4)
  print *, square(1_i8)
  print *, square(1_r4)
  print *, square(1_r8)

end program main