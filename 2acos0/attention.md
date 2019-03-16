```sh
$ brew install opencoarrays
Updating Homebrew...
Warning: opencoarrays 2.3.1_1 is already installed and up-to-date
To reinstall 2.3.1_1, run `brew reinstall opencoarrays`
$ make
gfortran -o serial serial.f90 -Wall -O3
gfortran -o omp omp.f90 -fopenmp -Wall -O3
mpifort -o mpi mpi.f90 -Wall -O3
mpifort -o coarray coarray.f90 -lcaf_mpi -fcoarray=lib -Wall -O3
coarray.f90:9:12:

         use opencoarrays, only: co_sum
            1
Fatal Error: Can't open module file 'opencoarrays.mod' for reading at (1): No such file or directory
compilation terminated.
make: *** [all] Error 1
```

> Users must make sure that openmpi is correctly installed and configured on their system. After confirming that openmpi is correctly installed and configures, make sure that the shell's PATH environment variable includes the path to your openmpi installation before compiling.

Yet I have installed `OpenCoarrays` under `/Users/wangmiao/Playground/GH/awesome_fortran/SI/OpenCoarrays/prerequisites/installations/`


`error stop` was introduced in Fortran 2008 together with coarrays and is useful for stopping all running images (processes) while `stop` just stops execution of the current image.
