#!/bin/sh
rm -rf *.mod
rm -rf *.o
rm -rf ./calc
rm DATA.txt

gfortran -c CT14Pdf.for
gfortran -c FXN.f90
gfortran -c MC_VEGAS.f90
gfortran -c MAIN.f90

gfortran -o calc MAIN.o CT14Pdf.o FXN.o MC_VEGAS.o
./calc
rm -rf *.mod
rm -rf *.o
rm -rf ./calc
