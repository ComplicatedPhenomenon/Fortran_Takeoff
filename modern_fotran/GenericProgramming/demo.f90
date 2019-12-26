module mod_functional
    use iso_fortran_env, only : i1 => int8, i2 => int16
    implicit none
    private 
    public :: f_i1, f_i2
interface
    pure integer(kind = i1) function f_i1(x)
        import :: i1
        integer(i1), intent(in) :: x 
    end function f_i1 

    pure integer(kind = i2) function f_i2(x)
    import :: i2
    integer(i2), intent(in) :: x 

    end function f_i2 

end interface
end module mod_functional

module mod_interfaces
    use iso_fortran_env, only : i1 => int8, i2 => int16, i4 => int32
    use mod_functional
    implicit none

interface map 
    module procedure :: map_i1, map_i2
end interface map

contains
    pure function map_i1(f, x) result(map)
        procedure(f_i1) :: f
        integer(i1), dimension(:), intent(in) :: x 
        integer(i1), dimension(size(x)) :: map
        integer(i4) :: i
        map = [(f(x(i)), i = 1, size(x))]
    end function map_i1

    pure function map_i2(f, x) result(map)
        procedure(f_i2) :: f
        integer(i2), dimension(:), intent(in) :: x 
        integer(i2), dimension(size(x)) :: map
        integer(i4) :: i
        map = [(f(x(i)), i = 1, size(x))]
    end function map_i2
end module mod_interfaces

program test_map
    use iso_fortran_env, only : i1 => int8, i2 => int16, i4 => int32
    use mod_interfaces
    implicit none 
    integer(i1), dimension(1:3):: x_i1 = (/ 3_i1, 4_i1, 5_i1 /)
    integer(i2), dimension(1:3):: x_i2 = (/ 3_i2, 4_i2, 5_i2 /)
    integer(i1), dimension(size(x_i1)) :: res_i1
    integer(i2), dimension(size(x_i2)) :: res_i2
    res_i1 =  map_i1(xpowx_i1, x_i1)
    print *, res_i1

    res_i2 =  map_i2(xpowx_i2, x_i2)
    print *, res_i2

    contains
    pure integer(i1) function xpowx_i1(x) result(res)
        integer(i1), intent(in) :: x
        res = x * x + 5_i1
    end function xpowx_i1

    pure integer(i2) function xpowx_i2(x) result(res)
        integer(i2), intent(in) :: x
        res = x * x + 3_i2
    end function xpowx_i2   
end program test_map