## Parallel computing
* [Threads and processes](http://www.mathcs.emory.edu/~cheung/Courses/561/Syllabus/91-pthreads/intro-threads.html)

It involves dividing up the work among multiple CPUs and possibly combining the results of the multiple computations to produce the final outcome

## Coarrays in Fortran
[Coarrays in fortran 95/03](http://www.admin-magazine.com/HPC/Articles/Modern-Fortran-Part-3)
[Coarrays in the next Fortran standard](http://caf.rice.edu/documentation/John-Reid-N1824-2010-04-21.pdf)

Coarrays provide a simple extension to Fortran for parallel programming on distributed-memory and shared-memory architectures. The program is treated as if it were replicated a fixed number of times and each replication is called an image. An additional set of subscripts provides access from any image to
data on another image. Care has been taken to allow compilers to optimize both execution on an image and communication between images.

* [HPC with Fortran 2008 and 2018 coarrays](https://cgpack.sourceforge.io/201711/cppc_talk2017.pdf)
* [coarrays.sourceforge.io](https://coarrays.sourceforge.io/doc.html)
* [Coarry implementation](http://charm.cs.uiuc.edu/kale/teaching/cs320/CAFfromupcsc01CarlsonB.pdf)

## Array in Fortran
Array indices in Fortran by default begin at **1** !!!

Types of array?

## Allocatable arrays
In the old days :smile:, the maximum size arrays had to be declared when the code is written. This was a great disadvantages, as it result in wasted RAM(Array size has to be the maximum possible)or in frequent recompilations.

[Dynamic Arrays](http://www.pcc.qub.ac.uk/tec/courses/f90/stu-notes/F90_notesMIF_11.html)

During program execution, the allocation status of an allocatable array is one one the following:
* Not currently allocated. Such an array must not be referenced or defined.
* Currently allocated.


## Fortran for symbolic calculation?
Why Fortran doesn't become a generic language to make symbolic calculation.

>  I think that Fortran is better for numeric scientific computing, for algorithms that can be expressed using arrays and don't need other sophisticated data structures, so in fields like finite differences/elements, PDE solvers, electronic structure calculations. Fortran is a domain specific language.

> Fortran is so optimizable because its arrays are not fundamentally just a memory layout with pointer math. n Fortran, arrays are abstract entities, which allows the compiler to lay them out in the best possible way to take advantage of vectorization for the current code.

> Automatically using the heap for array storage adds a layer of transparency for the programmer, and for novice programmers that’s a good thing because it reduces their cognitive load and allows them to concentrate on the problem, rather then get bogged down in syntax.
