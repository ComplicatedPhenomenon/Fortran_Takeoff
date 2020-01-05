program arithmatic  
    use iso_fortran_env, only : i1 => int8, i2 => int16, r4 => real32, r8=> real64
    implicit none
    real(r4) :: x_r4
    real(r8) :: x_r8
    x_r4 = 7_r4 / 2_r4
    print *, x_r4
    x_r8 = 7_r8 / 2_r8
    print *, x_r8
    print *, 7_i1 / 2_i1
    print *, 7_i2 / 2_i2

end program arithmatic