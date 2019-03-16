> Fortran supports four types of arrays: explicit-shape arrays, assumed-shape arrays, deferred-shape arrays and assumed-size arrays. Both explicit-shape arrays and deferred shape arrays are valid in a main program. Assumed shape arrays and assumed size arrays are only valid for arrays used as dummy arguments. Deferred shape arrays, where the storage for the array is allocated during execution, must be declared with either the ALLOCATABLE or POINTER attributes.
## Co-arrays Fortran
[Coarrays in fortran 95/03](http://www.admin-magazine.com/HPC/Articles/Modern-Fortran-Part-3)
[Coarrays in the next Fortran standard](http://caf.rice.edu/documentation/John-Reid-N1824-2010-04-21.pdf)

Coarrays provide a simple extension to Fortran for parallel programming on distributed-memory
and shared-memory architectures. The program is treated as if it were replicated a fixed number
of times and each replication is called an image. An additional set of subscripts provides access
from any image to data on another image. Care has been taken to allow compilers to optimize
both execution on an image and communication between images.

[HPC with Fortran 2008 and 2018 coarrays](https://cgpack.sourceforge.io/201711/cppc_talk2017.pdf)
A variety of parallel technologies can be used - MPI, OpenMP, SHMEM, GASNet, ARMCI, DMAPP, etc. As always,
performance depends on a multitude of factors
[](https://coarrays.sourceforge.io/doc.html)
[Coarry implementation](http://charm.cs.uiuc.edu/kale/teaching/cs320/CAFfromupcsc01CarlsonB.pdf)


## Allocatable arrays
In the old days :smile:, the maximum size arrays had to be declared when the code is written. This was a great disadvantages,(**????**), as it result in wasted RAM(Are you kidding me? Declaring the space exactly you need is a waste of RAM?)(Array size has to be the maximum possible)or in frequent recompilations.

So far, I only learn about static variables, that is they have had a fix memory requirement, which is specified when the variable is declared.
[Dynamic Arrays](http://www.pcc.qub.ac.uk/tec/courses/f90/stu-notes/F90_notesMIF_11.html)

During program execution, the allocation status of an allocatable array is one one the following:
* Not currently allocated. Such an array must not be referenced or defined.
* Currently allocated.

When it comes to memory management, Valgrind can't be missed.

Yet the newest `valgrind` for mac is available to Mac OS X 10.12.

Mine is 10.14.3, Error occur when installing Valgrind 3.14.0
```sh
$ ./configure
...
configure: error: Valgrind works on Darwin 10.x, 11.x, 12.x, 13.x, 14.x, 15.x, 16.x and 17.x (Mac OS X 10.6/7/8/9/10/11 and macOS 10.12/13)
```
