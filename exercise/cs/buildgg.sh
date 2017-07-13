#!/bin/sh
rm -rf *.mod
rm -rf *.o
rm -rf ./calc
rm DATAgg.txt

gfortran -c CT14Pdf.for
gfortran -c FXNgg.f90
gfortran -c MC_VEGAS.f90
gfortran -c MAINgg.f90

gfortran -time -o calc MAINgg.o CT14Pdf.o FXNgg.o MC_VEGAS.o
./calc
rm -rf *.mod
rm -rf *.o
rm -rf ./calc
