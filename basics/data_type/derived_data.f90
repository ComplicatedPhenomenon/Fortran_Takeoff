program test_derived_data
  implicit none

  type :: people
    character (len = 12) :: first_name
    character (len = 12) :: last_name
    character (len = 6)  :: sex
    integer              :: age
    real                 :: height
  end type people

  

  type(people) :: anyone

  print *,'Demonstrate how a defined type <people> works'
  print *,'Input first name, last name, sex, age, height by order.'
  read (*,*) anyone

  write (*,*) anyone
  print  *, anyone%sex ! Access one element.
end program test_derived_data
