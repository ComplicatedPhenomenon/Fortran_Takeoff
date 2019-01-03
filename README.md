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
[gfortran](https://en.wikipedia.org/wiki/GNU_Fortran) is used in most times, nevertheless, Situation of using multiple compiler can also happen. As some Fortan features are not implemented in gfortran.

```sh
$ gfortran -v
Using built-in specs.
COLLECT_GCC=gfortran
COLLECT_LTO_WRAPPER=/usr/local/Cellar/gcc/8.2.0/libexec/gcc/x86_64-apple-darwin18.0.0/8.2.0/lto-wrapper
Target: x86_64-apple-darwin18.0.0
Configured with: ../configure --build=x86_64-apple-darwin18.0.0 --prefix=/usr/local/Cellar/gcc/8.2.0 --libdir=/usr/local/Cellar/gcc/8.2.0/lib/gcc/8 --enable-languages=c,c++,objc,obj-c++,fortran --program-suffix=-8 --with-gmp=/usr/local/opt/gmp --with-mpfr=/usr/local/opt/mpfr --with-mpc=/usr/local/opt/libmpc --with-isl=/usr/local/opt/isl --with-system-zlib --enable-checking=release --with-pkgversion='Homebrew GCC 8.2.0' --with-bugurl=https://github.com/Homebrew/homebrew-core/issues --disable-nls --disable-multilib --with-native-system-header-dir=/usr/include --with-sysroot=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk
Thread model: posix
gcc version 8.2.0 (Homebrew GCC 8.2.0)
```
> GNU Fortran or GFortran is the name of the GNU Fortran compiler, which is part of the GNU Compiler Collection (GCC). It includes full support for the Fortran 95 language, and supports large parts of the Fortran 2003 and Fortran 2008 standards. It supports the OpenMP multi-platform shared memory multiprocessing, up to its latest version (4.5). GFortran is also compatible with most language extensions and compilation options supported by g77,and many other popular extensions of the Fortran language.

[gfortran compiler wiki](https://gcc.gnu.org/wiki/GFortran).

What's new in [gfortran 8](https://gcc.gnu.org/onlinedocs/gcc-8.1.0/gfortran/)?

* Fortran 2003
  * Parameterized derived types are now supported.
  * Transformational intrinsics are now fully supported in initialization expressions.
* Fortran 2008
  * The maximum rank for arrays has been increased to 15.
* Fortran 2018
  * TS18508: Partial support is provided for teams, which are hierarchical subsets of images that execute independently of other image subsets.
...
* A new flag `-std=f2018` is available.

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

## Recommendation of People
* [https://milancurcic.com/](https://milancurcic.com/)
* [https://github.com/szaghi?tab=repositories](https://github.com/szaghi?tab=repositories)
