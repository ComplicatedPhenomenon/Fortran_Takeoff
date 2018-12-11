# [Awesome Fortan](https://github.com/rabbiabram/awesome-fortran)

Install a Library.
* First find the source code of the library.
  * datetime-fortran
  * [functional-fortran](https://wavebitscientific.github.io/functional-fortran/)
  * BLAS
  * Lapack
* Build

# Install [FoBiS.py](https://github.com/szaghi/FoBiS.git) first
Fortran Building System for poor people.

>  FoBiS.py is able to build almost automatically complex Fortran projects with cumbersome inter-modules dependency. This removes the necessity to write complex makefile.

* Manual Install

  Since the network speed is poor, I installed it at the same time, the Python installer behaves far better than manual install.
* PyPi Install
  * FoBiS.py can be installed by means of `pip`.

   Does it support `pip3`?

   Yes, it does!
   szaghi also kindly remind you that t you need root permissions if you are not using your `virtualenv` or you are trying to install FoBiS.py into your system space.

   I use `sudo -H pip3 install FoBiS.py`, It went well.  

## Use FoBis.py to install Fortran library [forbear](https://github.com/szaghi/forbear.git)

> An awesome package is one that is mature (not recently released), is well
maintained, has a good amount of users, has good documentation, follows the best
practices, and which latest release is less than 1 year old.

Following this standard to find some library.

# A very basic way using library
`FoBiS.py build -ext_libs datetime --lib_dir /path/to/datetime-fortran/build/lib --include /path/to/datetime-fortran/build/include`

# [Open Coarrays](https://github.com/sourceryinstitute/OpenCoarrays)
```sh
$ caf --show
/usr/local/bin/gfortran -I/usr/local/Cellar/opencoarrays/2.3.1/include/OpenCoarrays-2.3.1_GNU-8.2.0 -fcoarray=lib -Wl,-flat_namespace -Wl,-commons,use_dylibs -L/usr/local/Cellar/libevent/2.1.8/lib -L/usr/local/Cellar/open-mpi/3.1.2/lib ${@} /usr/local/Cellar/opencoarrays/2.3.1/lib/libcaf_mpi.a /usr/local/lib/libmpi_usempif08.dylib /usr/local/lib/libmpi_usempi_ignore_tkr.dylib /usr/local/lib/libmpi_mpifh.dylib /usr/local/lib/libmpi.dylib
$ cafrun -np 2 ./a.out
```
