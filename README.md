# What this repository is about?
This repository will cover the most features in Fortran.    

stick to 3 advices:
1. > To get good at anything you have to practice every day, and eventually it'll be easier and fun.

2. > If you break the problem down into small exercises and lessons, and do them every day, you can learn to do almost anything. If you focus on slowly improving and enjoying the learning process, then you will benefit no matter how good you are at it.
3. People hearing without listening.

# Strive to 3 standards
* Spend time on program design instead of getting a head start in coding first.
* Code with modern Fortran features and fix previous bugs.
* Polish this repository until it become well tested and useful subprograms.

# Learn from curly selected project
Search from the recently updated Fortran program for inspiration.
* OOP. Main newly added feature in Fortan 2003 standard
  - [FOSS](https://github.com/Fortran-FOSS-Programmers)
* Coarray. Main newly added feature in Fortan 2008 standard
    - UCY-parallel-fortran
    - fortran2018-examples
* Algorithms
  - [2acos0](https://github.com/wesbarnett/2acos0)
  - MonteCarlo
  
# Right way to begin with Fortran
## [Compilers in Fortran](http://fortranwiki.org/fortran/show/Compilers)
[gfortran](https://en.wikipedia.org/wiki/GNU_Fortran) is used in most times, nevertheless, Situation of using multiple compiler can also happen. As some Fortran features are not implemented in gfortran.

[gfortran compiler wiki](https://gcc.gnu.org/wiki/GFortran).

What's new in [gfortran 8](https://gcc.gnu.org/onlinedocs/gcc-8.1.0/gfortran/)?

* Fortran 2003
  * Parameterized derived types are now supported.
  * Transformational intrinsic are now fully supported in initialization expressions.
* Fortran 2008
  * The maximum rank for arrays has been increased to 15.
* Fortran 2018
  * TS18508: Partial support is provided for teams, which are hierarchical subsets of images that execute independently of other image subsets.
...
* A new flag `-std=f2018` is available.

## Debug method
* [Debugging tools](http://fortranwiki.org/fortran/show/Debugging+tools)
  * gdb
* Useful compiling options

  gfortran options

  ```f90
  -g -Wall -Wextra -Warray-temporaries -Wconversion -fimplicit-none -fbacktrace -ffree-line-length-0 -fcheck=all -ffpe-trap=zero,overflow,underflow -finit-real=nan
  ```


## Documentation for Fortran Project
[Ford ](https://github.com/Fortran-FOSS-Programmers/ford), which is written in Python, can be used to automatically generate documentation for Fortran projects.

## Recommendation of People
* https://milancurcic.com
* https://github.com/szaghi?tab=repositories
* [CS561 Syllabus & Progress](http://www.mathcs.emory.edu/~cheung/Courses/561/Syllabus/syl.html#CURRENT)
* books download from http://gen.lib.rus.ec/