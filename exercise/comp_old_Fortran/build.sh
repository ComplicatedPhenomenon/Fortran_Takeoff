#!/bin/sh
rm -rf *.mod
rm -rf *.o
rm DATA.txt
rm -rf ./calc

gfortran -c CT14Pdf.for
gfortran -c FXN.f90
gfortran -c MC_VEGAS.f90
gfortran -c MAIN.f90

gfortran -o calc MAIN.o CT14Pdf.o FXN.o MC_VEGAS.o
./calc