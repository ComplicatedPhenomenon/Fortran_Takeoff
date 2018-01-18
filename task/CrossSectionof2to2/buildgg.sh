#!/bin/sh
rm -rf *.mod
rm -rf *.o
rm -rf ./calc
#rm DATAgg.txt

gfortran -g -fbacktrace -fcheck=all -Wall -c CT14Pdf.for
gfortran -g -fbacktrace -fcheck=all -Wall -c FXNdiffgg.f90
gfortran -g -fbacktrace -fcheck=all -Wall -c MC_VEGAS.f90
gfortran -g -fbacktrace -fcheck=all -Wall -c MAINdiffgg.f90

gfortran  -g -fbacktrace -fcheck=all -Wall -o calc MAINdiffgg.o CT14Pdf.o FXNdiffgg.o MC_VEGAS.o
rm -rf *.mod
rm -rf *.o
