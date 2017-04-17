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

      type(person) :: wm
      type(person) :: anyone
      wm = person('Miao',' ','Wang','Female',25,157)
      write (*,*) 'Free format :', wm
      
      read (*,*) anyone
      write (*,*) anyone
      end program test_derived_data
