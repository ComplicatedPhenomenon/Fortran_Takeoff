# What this repository about?
This repository will cover the most features in Fortran. Can be used as tutorial for a beginner.  

> To get good at anything you have to practice every day, and eventually it'll be easier and fun.

> If you break the problem down into small exercises and lessons, and do them every day, you can learn to do almost anything. If you focus on slowly improving and enjoying the learning process, then you will benefit no matter how good you are at it.

> People hearing without listening.

# Strive to 3 standards
* Code with modern Fortran features and fix previous bugs.

* Spend time on program design instead of getting a head start in coding first.

* Polish this repository until it become well tested and useful subprograms.

# Learn from curly selected project
* OOP. Main newly added feature in Fortan 2003 standard
  - [FOSS](https://github.com/Fortran-FOSS-Programmers)
* Coarray. Main newly added feature in Fortan 2008 standard
    - UCY-parallel-fortran
    - fortran2018-examples
* Algorithms
  - 2acos0
  - DiffusionMonteCarlo
  - for-science

They all can be found on Github.


# Right way to begin with Fortran
## [Compilers in Fortran](http://fortranwiki.org/fortran/show/Compilers)
gfortran is used in most times, nevertheless, Situation of using multiple compiler can also happen. As some Fortan features are not implemented in gfortran.
## Configure text editor
* Tab length
* Auto

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
