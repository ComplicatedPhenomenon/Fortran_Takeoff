> You have to know the rules at first  then you can break it.

> Introduce new features to enhance 

### INTERFACE

If module are the way to go(and they are), what are interfaces for at all?

For module procedures (or function and subroutines in modules), anything that 
`USE`s that module can automatically see these interfaces. The interfaces are 
generated when the module is compiled, so you don't need to write it yourself.
Similarly, when you `CONTAINS` subprogram, the main program can see the interface
explicitly and it doesn't need you to write for it.

Interface blocks are for when the compiler isn't able to generate the explicit 
interface for you, or when you want something different than what is given, 
like using `C-Fortran interoperability` in Fortran 2003. In that case, the 
Fortran code is linking against some C library and has no way if generating a 
correct interface to the C routine.

[### Procedures and Modules](http://annefou.github.io/Fortran/modules/modules.html)
What we can '"structure programming` is a way to split your code in blocks.

#### Procedures:

* Internal procedures. They must be defined at the end of program unit after adding `CONTAINS` statement.
* External procedures. DO NOT USE THEM: modules are much easier and more robust. They are needed when procedures with different programming language or when using external libraries. 
    * When you want use them in another program unit, you need to refer them with the `EXTERNAL` keyword.
    * They are compiled separately and linked.

#### Special attributes for procedures: Elemental

#### Modules

Placing a procedure in a module helps the compiler to detect programming errors and 
to optimize your code.

* It helps to hide  implementation details (and makes it close to OOP)
* Define generic procedures and custom operators.

