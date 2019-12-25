program arithmatic  
    use iso_fortran_env, only : i1 => int8, i2 => int16, r4 => real32, r8=> real64
    implicit none
    real :: x_r4
    real :: x_r8
    x_r4 = 7_r4/2
    print *, x_r4
    x_r8 = 7_r8/2
    print *, x_r8


    print *, 7/2, 7d0/2, (7+0.5)/2
    print *, 7_i1/2, 7_i2/2
    print *, 7_r4/2, 7_r8/2
    print *, 2_r4, 2_r8
end program arithmatic