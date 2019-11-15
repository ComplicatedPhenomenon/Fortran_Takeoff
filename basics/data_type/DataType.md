## Why do we need initialize variable?
In order to make sure running on different machine won't produce mistakes
## When do we need `KIND`?
In Fortran 90 and later, intrinsic types such as `real` and `integer` have a
`kind` attribute **which guarantees a specific precision and/or range**.
```fortran
integer, parameter :: dp = selected_real_kind(15, 307)
real(kind=dp) :: a
real(dp)      :: b
```

## Structures and Derived Types
* Declarations specifies a list of items (Derived Type)
* A Structure ( a variable of derived type) can hold
  * variable of simple types (real, integer, character, logical, complex)
  * arrays: static and allocatable
  * other derived types
  * a structure can be allocatable

  ```f90
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
