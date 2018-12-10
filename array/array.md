## Resources
[Coarrays in fortran 95/03](http://www.admin-magazine.com/HPC/Articles/Modern-Fortran-Part-3)
[Coarrays in the next Fortran standard](http://caf.rice.edu/documentation/John-Reid-N1824-2010-04-21.pdf)
## Allocatable arrays
In the old days :smile:, the maximum size arrays had to be declared when the code is written. This was a great disadvantages,(**?**), as it result in wasted RAM(are you kidding me, Displaying you the space exactly you need wastes RAM?)(Array size has to be the maximum possible)or in frequent recompilations.

So far, we only learn about static variables, that is they have had a fix memory requirement, which is specified when the variable is declared.
[Dynamic Arrays](http://www.pcc.qub.ac.uk/tec/courses/f90/stu-notes/F90_notesMIF_11.html)

During program execution, the allocation status of an allocatable array is one one the following:
* Not currently allocated. Such an array must not be referenced or defined.
* Currently allocated.

```
$ valgrind ./array

==4335== Memcheck, a memory error detector
==4335== Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et al.
==4335== Using Valgrind-3.12.0 and LibVEX; rerun with -h for copyright info
==4335== Command: ./a.out
==4335==
 F
 T
            1           2           3           4           5           6           5           4           3           2           1
 F
 T
            1           2           3           4           5           6
 T
            1           2           2           4           3           6
 F

==4335==
==4335== HEAP SUMMARY:
==4335==     in use at exit: 68 bytes in 2 blocks
==4335==   total heap usage: 28 allocs, 26 frees, 12,656 bytes allocated
==4335==
==4335== LEAK SUMMARY:
==4335==    definitely lost: 68 bytes in 2 blocks
==4335==    indirectly lost: 0 bytes in 0 blocks
==4335==      possibly lost: 0 bytes in 0 blocks
==4335==    still reachable: 0 bytes in 0 blocks
==4335==         suppressed: 0 bytes in 0 blocks
==4335== Rerun with --leak-check=full to see details of leaked memory
==4335==
==4335== For counts of detected and suppressed errors, rerun with: -v
==4335== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
```

After adding `deallocate(x_1d)` and `deallocate(x_2d)`

```
==4347== Memcheck, a memory error detector
==4347== Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et al.
==4347== Using Valgrind-3.12.0 and LibVEX; rerun with -h for copyright info
==4347== Command: ./a.out
==4347==
 F
 T
            1           2           3           4           5           6           5           4           3           2           1
 F
 T
            1           2           3           4           5           6
 T
```
