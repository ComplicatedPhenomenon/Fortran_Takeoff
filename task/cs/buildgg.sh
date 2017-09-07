#!/bin/sh
rm -rf *.mod
rm -rf *.o
rm -rf ./calc
#rm DATAgg.txt

gfortran -g -fbacktrace -fcheck=all -Wall -c CT14Pdf.for
gfortran -g -fbacktrace -fcheck=all -Wall -c FXNgg.f90
gfortran -g -fbacktrace -fcheck=all -Wall -c MC_VEGAS.f90
gfortran -g -fbacktrace -fcheck=all -Wall -c MAINgg.f90

gfortran  -g -fbacktrace -fcheck=all -Wall -o calc MAINgg.o CT14Pdf.o FXNgg.o MC_VEGAS.o
rm -rf *.mod
rm -rf *.o
