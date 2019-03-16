FFLAGS = -Wall -O3  --include /Users/wangmiao/Playground/GH/awesome_fortran/SI/OpenCoarrays/prerequisites/installations/opencoarrays/2.3.1/lib 
all:
	gfortran -o serial serial.f90 ${FFLAGS}
	gfortran -o omp omp.f90 -fopenmp ${FFLAGS}
	mpifort -o mpi mpi.f90 ${FFLAGS}
	mpifort -o coarray coarray.f90 -lcaf_mpi -fcoarray=lib ${FFLAGS}
clean:
	rm -v *.mod serial omp mpi coarray
