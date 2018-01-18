program loop
   integer :: i
   character :: arg
   i = 0
   do
   call get_command_argument(i,arg) ! first it will receive the 0th argument arg=./ex1.sh 
                                    ! then it will receive the  1th argument arg = 1
                                    ! then ,,,                  2th argument arg = none
                                    ! so do once again the loop within the control of ex1.sh
   if( len_trim(arg) == 0 )  exit
      write(*,*) trim(arg)
      i = i + 1
   end do
end program loop
