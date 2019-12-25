> You have to know the rules at first  then you can break it.

> Introduce new features to enhance

http://fortranwiki.org/fortran/show/HomePage

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
###  Why should subroutine and function be wrapped into module?
From my limited experience, I think it reduce reductant.



# [Derived types](http://people.ds.cam.ac.uk/nmm1/Fortran/paper_09.pdf)
* Fully support OOP in Fortran
* Semantic extension
* Polymorphism

# Some points in modern fortran
* `=>` acts like `alias` in bash
* Interface

  Another reason to use an interface body is to describe code to which you don't have Fortran source, such as C code that you are calling via the ISO C Binding.
* `use,intrinsic :: iso_c_binding,only:c_char,c_int`
  * [Using C/C++ and Fortran together](https://computing.llnl.gov/tutorials/bgq/mixedProgramming2.pdf)

  > All arguments in FORTRAN are passed by reference and not by value.

  Testify statement above!!!


The PSBLAS library is based on the Single Program Multiple Data (SPMD)
programming model: each process participating in the computation performs
the same actions on a chunk of data. Parallelism is thus data-driven.

Coarrays are intended for single program - multiple data (SPMD) type parallel programming

The runtime environment spawns a number of identical copies of the executable, called images. Hence coarray programs follow SPMD model.