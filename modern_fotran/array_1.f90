! 2017 /9 /10 version : 1.0
! Automatic Deallocation of Local Variable.
!
! An allocatable variable is automatically deallocated when the program exits the subprogram.
! unless the variable possess the save attribute. This prevents "memory leakage".
program Test_allocatable_variable

end program Test_allocatable_variable
