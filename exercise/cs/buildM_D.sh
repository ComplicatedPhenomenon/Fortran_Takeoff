#!/bin/sh
rm -rf *.mod
rm -rf *.o
rm -rf ./calc
rm DATAqq.txt

gfortran -g -fbacktrace -fcheck=all -Wall -c CT14Pdf.for
gfortran -g -fbacktrace -fcheck=all -Wall -c FXNqq.f90
gfortran -g -fbacktrace -fcheck=all -Wall -c vegasset.for
gfortran -g -fbacktrace -fcheck=all -Wall -c randa.for
gfortran -g -fbacktrace -fcheck=all -Wall -c vegas.for
gfortran -g -fbacktrace -fcheck=all -Wall -c MAINqq.f90

gfortran  -g -fbacktrace -fcheck=all -Wall -o calc MAINqq.o CT14Pdf.o FXNqq.o vegasset.o randa.o vegas.o
./calc
rm -rf *.mod
rm -rf *.o
rm -rf ./calc
