> Fortran supports four types of arrays: explicit-shape arrays, assumed-shape arrays, deferred-shape arrays and assumed-size arrays. Both explicit-shape arrays and deferred shape arrays are valid in a main program. Assumed shape arrays and assumed size arrays are only valid for arrays used as dummy arguments. Deferred shape arrays, where the storage for the array is allocated during execution, must be declared with either the ALLOCATABLE or POINTER attributes.
## Resources
[Coarrays in fortran 95/03](http://www.admin-magazine.com/HPC/Articles/Modern-Fortran-Part-3)
[Coarrays in the next Fortran standard](http://caf.rice.edu/documentation/John-Reid-N1824-2010-04-21.pdf)
## Allocatable arrays
In the old days :smile:, the maximum size arrays had to be declared when the code is written. This was a great disadvantages,(**?**), as it result in wasted RAM(are you kidding me, Displaying you the space exactly you need wastes RAM?)(Array size has to be the maximum possible)or in frequent recompilations.

So far, I only learn about static variables, that is they have had a fix memory requirement, which is specified when the variable is declared.
[Dynamic Arrays](http://www.pcc.qub.ac.uk/tec/courses/f90/stu-notes/F90_notesMIF_11.html)

During program execution, the allocation status of an allocatable array is one one the following:
* Not currently allocated. Such an array must not be referenced or defined.
* Currently allocated.
