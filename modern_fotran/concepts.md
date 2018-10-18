#### Attributes
Attributes are:

parameter, constant, dimension, allocatable, intent, pointer, target, optional, private, public, value, bind, etc.

#### File extensions
The extensions .f90, .f95, and .f03 are used for modern, free form source code conforming to the ... standards. Some choose to use .f90 to denote free-form source code, for example, including Fortran 2003 code.
#### Allocatable arrays
In the old days :smile:, the maximum size arrays had to be declared when the code is written. This was a great disadvantages,(**?**), as it result in wasted RAM(are you kidding me, Displaying you the space exactly you need wastes RAM?)(Array size has to be the maximum possible)or in frequent recompilations.
#### Public, Private Subroutine
Default is *public*: all public content can be **used** from the outside of the mdule. *Private* items are only accessible from within the module.\
#### Public, Private Variables
```fortran
module mad_science
real, paraeter :: pi = 3.  &
                  c  = 3.e8&
		  e  = 2.7
private
real, dimension(100) :: scratch
real, public         :: p_var
contins
subroutime swap(x,y)
real, dimension(100) :: x, y
scratch(1:100) = x(1:100)
x(1:100)       = y(1:100)
y(1:100)       = scratch(1:100)
```
private arrat scratch not accessible from outside of the module.

Keywords private and public can stand alone, or be an attribute

**The position is the only information avaliable.**
```fortran
subroutine s(a,b,c,n,...)
...
call       s(x,y,z,m,...)
```
#### Stuctures and Derived Types
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
####Why do we use subprograms?
subroutine and functions serve mainly 3 purposes, while one of them is not familiar with me.

**Hide Local variables**, so that the name can be re-used
####Modules are another, more flexible too to hide contents
