**GNU FORTRAN compier** is part of the **GNU Compiler Collection**, it has replaced the **g77** compiler. It includes full support for the Fortran 95 language and is compatible with most language extensions supported by g77 , large part of Fortran 2003 and Fortran 2008 have also been implemented.

Source code (programming language high-level language) to object code (assembly language or machine code low-level language)

Compilers enabled the development of programs that are machine-independent.

[Fortran](https://en.wikipedia.org/wiki/Fortran#Fortran_2008)
#### Intrinsic procedures
The intrinsic procedures provided by GNU Fortran included all of the procedures required by the Fortran 95 standard, and a selection of intrinsic procedures from the Fortran 2003 and Fortran 2008 standards.
For example :
##### BIT_SIZE -Bit size inquiry function

*Description*:

    BIT_SIZE(I) returns the number of bits (integer precision plus sign bit) represented by type *I*.

*Standard*:

    Fortran 95 and later

*Class*:

    Iquiry funcion
 
*Syntax*:

    result = BIT_SIZE(I)

*Example*:
```f95
program test_bit_size
integer :: i = 123
integer :: size
size =  bit_size(i)
print *,size
end program test_bit_size
```
