#!/bin/sh
rm -rf *.mod
rm -rf *.o
rm -rf ./calc
rm DATAqq.txt

gfortran -g -fbacktrace -fcheck=all -Wall -c CT14Pdf.for
gfortran -g -fbacktrace -fcheck=all -Wall -c FXNdiffqq.f90
gfortran -g -fbacktrace -fcheck=all -Wall -c MC_VEGAS.f90
gfortran -g -fbacktrace -fcheck=all -Wall -c MAINdiffqq.f90

gfortran  -g -fbacktrace -fcheck=all -Wall -o calc MAINdiffqq.o CT14Pdf.o FXNdiffqq.o MC_VEGAS.o
rm -rf *.mod
rm -rf *.o
