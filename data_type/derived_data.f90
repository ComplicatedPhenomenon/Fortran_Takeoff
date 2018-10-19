program test_derived_data
implicit none

type :: person
character (len = 12) :: first_name
character (len = 12) :: last_name
character (len = 6)  :: sex
integer              :: age
real                 :: height
end type person

type(person) :: anyone

print *,'Demonstrate how a defined type <person> works'      
print *,'Input first name, last name, sex, age, height by order.'
read (*,*) anyone

write (*,*) anyone
end program test_derived_data
