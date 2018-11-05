# Why do we need initialize variable?
In order to make sure running on different machine won't produce mistakes
# When do we need `KIND`?
In Fortran 90 and later, intrinsic types such as `real` and `integer` have a
kind attribute which guarantees a specific precision and/or range.
```fortran
integer, parameter :: dp = selected_real_kind(15, 307)
real(kind=dp) :: a
real(dp)      :: b
```
# Module procedure
module can contain procedures

There are two types of procedures:
* functions
* subroutines

*procedures* contained in a module is compiled as part of module, and should be followed by module declaration with *CONTAINS* statement ahead of it.
