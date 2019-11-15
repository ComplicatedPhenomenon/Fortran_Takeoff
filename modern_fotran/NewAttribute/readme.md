## Attributes
Attributes are:

parameter, constant, dimension, allocatable, intent, pointer, target, optional, private, public, value, bind, etc.

If the ELEMENTAL prefix specifier is used, the RECURSIVE specifier cannot be used. An elemental subprogram is a pure subprogram. However subprograms  are not
necessarily elemental subprograms. 

Elemental procedures must conform to the following rule:

* The result if an elemental function must be a scalar, and must not have the `ALLOCATABLE`  or `POINTER` attribute.
* The following apply to dummy arguments used in elemental subprograms:
  *  All dummy arguments must be scalar, and must not have the `ALLOCATABLE`  or `POINTER` attribute.
  *  A dummy argument cannot be used in a specification expression, except ()
  * A dummy argument cannot be an asterisk or a dummy procedure.

## File extensions
The extensions .f90, .f95, and .f03 are used for modern, free form source code conforming to the ... standards. Some choose to use .f90 to denote free-form source code, for example, including Fortran 2003 code.

## `private` and `public
Default is *public*: all public content can be **used** from the outside of the module. *Private* items are only accessible from within the module.

Keywords `private` and `public` can stand alone, or be an attribute.


## Why do we use subprograms?
subroutine and functions serve mainly 3 purposes, while one of them is not familiar with me.

**Hide Local variables**, so that the name can be re-used
## Modules are another, more flexible structure to hide contents
