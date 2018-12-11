> You have to know the rules at first  then you can break it.

> Introduce new features to enhance

## INTERFACE

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

## [Procedures and Modules](http://annefou.github.io/Fortran/modules/modules.html)
What it means that `structure programming` is a way to split your code in blocks.

### Procedures:

* Internal procedures. They must be defined at the end of program unit after adding `CONTAINS` statement.
* External procedures. DO NOT USE THEM: modules are much easier and more robust. They are needed when procedures with different programming language or when using external libraries.
    * When you want use them in another program unit, you need to refer them with the `EXTERNAL` keyword.
    * They are compiled separately and linked.

### Special attributes for procedures: Elemental

### Modules

Placing a procedure in a module helps the compiler to detect programming errors and
to optimize your code.

* It helps to hide  implementation details (and makes it close to OOP)
* Define generic procedures and custom operators.

## statement
Fortran statements supported by the gcc compiler.


associate
type

|  Statement      |   Origin        |         Description                  |    
|-----------------|-----------------|--------------------------------------|
| INTERFACE       |   F90           | Makes an implicit procedure an explicit procedure where the dummy parameters and procedure type are known to the calling module; Also overloads a procedure name.|
| PROCEDURE       |   F2003         | Makes an implicit procedure an explicit procedure where the dummy parameters and procedure type are known to the calling module; Also overloads a procedure name.|
| PURE            |   F95           |   Indicates that a function or subroutine has no side effects. |
| TYPE            |   F90           | Begins a derived type data specification or declares variables of a specified user-defined type.|
| ASSOCIATE       |                 | Associates a name either with a variable or with the value of an expression for the duration of a block. |          
| PROTECTED       |   F2003         | Protects a module variable against modification from outside the module in which it was declared.|
|      ...        |    ...          |          ...  | |
