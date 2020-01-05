program main
    implicit none
    
    integer :: x(1:6) = (/ 3, 4, 5, 6, 7, 8 /)
    integer :: i  
    integer, dimension(size(x)) :: res
    res = [(square(x(i)), i = 1, size(x))]    
    
    write(*, *) res
    
    contains
    function square(x) result(res)
        implicit none
        integer, intent(in) :: x
        integer :: res
        !integer, intent(out) :: res
        res = x * x 
    end function square 

end program main


