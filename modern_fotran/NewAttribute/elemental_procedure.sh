#!/bin/sh

rm -rf *.mod
rm -rf *.o
gfortran -g -fbacktrace -fcheck=all -Wall -c elemental_procedure.f90
gfortran -g -fbacktrace -fcheck=all -Wall -o calc elemental_procedure.o
./calc
rm -rf *.mod
rm -rf *.o
rm -rf calc
