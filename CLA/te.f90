program print_
   integer :: i, j
   character(len = 32) :: arg
   i = 1   ! if affetct arg, i - 2 arg is the second CLA 
   Do 
      call get_command_argument(i, arg)
      if ( len_trim(arg) == 0) exit
  !        write(*,*) trim(arg)
          read(arg, *) j
          write(*,*) j**2
          i = i + 1
   end do
!write(*,*) arg, "hello"
end program print_
