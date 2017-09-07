#!/bin/sh
rm -rf *.mod
rm -rf *.o
rm -rf ./calc
rm DATAqq.txt

gfortran -g -fbacktrace -fcheck=all -Wall -c CT14Pdf.for
gfortran -g -fbacktrace -fcheck=all -Wall -c FXNqq.f90
gfortran -g -fbacktrace -fcheck=all -Wall -c MC_VEGAS.f90
gfortran -g -fbacktrace -fcheck=all -Wall -c MAINqq.f90

gfortran  -g -fbacktrace -fcheck=all -Wall -o calc MAINqq.o CT14Pdf.o FXNqq.o MC_VEGAS.o
./calc
rm -rf *.mod
rm -rf *.o
rm -rf ./calc
