program matrix
!  use ISO_FORTRAN_ENV, only : I8=>INT8, I16=>INT16, I32=>INT32, I64=>INT64
  use datetime_module, only:datetime

  implicit none

  type(datetime) :: a

  a = a % now()
  print *,'Returns an array of 3 integers: year, week number, and week day'
  print *,'datetime%isocalendar() is equivalent to Python’s datetime.datetime.isocalendar()'
  print *,'This programs is running at:', a % isoformat('')


  a = datetime() ! 0001-01-01 00:00:00
  write(*,*)'a = datetime(), a % isocalendar() :' , a % isocalendar()
  ! datetime%isocalendar() is equivalent to Python’s datetime.datetime.isocalendar().

  ! Components can be specified by position:
  a = datetime(1984, 12, 10) ! 1984-12-10 00:00:00
  write(*,*) 'a = datetime(1984, 12, 10), a % isocalendar():', a % isocalendar()

end program matrix
