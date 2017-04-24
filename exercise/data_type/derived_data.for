      program test_derived_data
      implicit none

      type :: person
      character (len = 12) :: first_name
      character (len = 12) :: middle_name
      character (len = 12) :: last_name
      character (len = 6) :: sex
      integer :: age
      real :: height
      end type person

      type(person) :: anyone
      
      print *,'Input first name, middle name, last name, sex, age, heigh
     >t by order.' 
      read (*,*) anyone
      
      write (*,*) anyone
      end program test_derived_data
