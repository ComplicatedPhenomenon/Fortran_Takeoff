## Attributes
Attributes are:

parameter, constant, dimension, allocatable, intent, pointer, target, optional, private, public, value, bind, etc.

## File extensions
The extensions .f90, .f95, and .f03 are used for modern, free form source code conforming to the ... standards. Some choose to use .f90 to denote free-form source code, for example, including Fortran 2003 code.

## Public, Private Subroutine
Default is *public*: all public content can be **used** from the outside of the module. *Private* items are only accessible from within the module.
## Public, Private Variables
```fortran
module mad_science
real, parameter :: pi = 3.  &
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
The private array `scratch`  is not accessible from outside of the module.

Keywords private and public can stand alone, or be an attribute

**The position is the only information avaliable.**
```fortran
subroutine s(a,b,c,n,...)
...
call       s(x,y,z,m,...)
```
## Why do we use subprograms?
subroutine and functions serve mainly 3 purposes, while one of them is not familiar with me.

**Hide Local variables**, so that the name can be re-used
## Modules are another, more flexible structure to hide contents
