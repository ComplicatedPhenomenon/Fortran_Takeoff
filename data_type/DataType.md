## Why do we need initialize variable?
In order to make sure running on different machine won't produce mistakes
## When do we need `KIND`?
In Fortran 90 and later, intrinsic types such as `real` and `integer` have a
kind attribute which guarantees a specific precision and/or range.
```fortran
integer, parameter :: dp = selected_real_kind(15, 307)
real(kind=dp) :: a
real(dp)      :: b
```
## Module procedure
module can contain procedures

There are two types of procedures:
* functions
* subroutines

*procedures* contained in a module is compiled as part of module, and should be followed by module declaration with *CONTAINS* statement ahead of it.
## Data descriptors
* [Data descriptors given bt Fortran Wiki](http://fortranwiki.org/fortran/show/Edit+descriptors)

## Complex Data
```fortran
program complexarithmatic
  implicit none
  character(len=80) :: text
  integer           :: int_i
  complex :: x, y, z

  text = 'The intrinsic data type character stores characters and strings.'
  int_i = index(text, 'character')
  x = (7, 8)
  y = (5,-7)

  print *,"x = ", x, "y = ", y
  print *,"x * y = ",  x * y

  print *, 'Demonstrate how intrinsic function index work on characters'
  print *,'What in text is: ', text
  if(int_i /= 0)then
    print *,'How many characters in text',int_i
  end if
end program complexarithmatic
```
## Stuctures and Derived Types
* Declarations specifies a list of items (Derived Type)
* A Structure ( a variable of derived type) can hold
  * variable of simple types (real, integer, character, logical, complex)
  * arrays: static and allocatable
  * other derived types
  * a structure can be allocatable
```fortran
type personality
character(len = 10) :: hobby
character(len = 10) :: temper
real                :: eyesight
end type personality

type  people
integer    :: age
real       :: height
real, allocatable, dimension(:,:) :: food_intake
type(personality) :: adj_natured

allocatable type cat
character (len= 10) :: shape
type(personality)   :: mi
end type cat
end type people
```
