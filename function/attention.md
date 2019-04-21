## Ways to produce random number
* `random_number()`
* `rand()`
`RANDOM_NUMBER()` is preferable to `RAND()`. `RANDOM_NUMBER()` offers better statistical properties, a long period, and good performance.

The intrinsic `random_number(u)` returns a real number u (or an array of such) from the uniform distribution over the interval [0,1). [That is, it includes 0 but not 1.]

## the defined behavior of  `do`  
```sh
$ gfortran  -g -fbacktrace -fcheck=all -Wall DoLoop.f90
DoLoop.f90:5:13:

   do i = 3, 1
             1
Warning: DO loop at (1) will be executed zero times [-Wzerotrip]
```
## Function argument
> In general, Fortran routines pass arguments by reference. In a call, if you enclose an argument with the nonstandard function %VAL(), the calling routine passes it by value.

> The standard Fortran 95 way to pass arguments by value is the VALUE attribute and through INTERFACE blocks.

[Cite from oracle](https://docs.oracle.com/cd/E19205-01/819-5262/auto42/index.html)

[Parameter passing mechanisms in Fortran](http://www.mathcs.emory.edu/~cheung/Courses/561/Syllabus/5-Fortran/param-passing.html)
