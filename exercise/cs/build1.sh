#!/bin/sh
rm -rf *.mod
rm -rf *.o
rm -rf ./calc

gfortran -c CT14Pdf.for
gfortran -c FXN1.f90
gfortran -c MC_VEGAS.f90
gfortran -c MAIN1.f90

gfortran -o calc MAIN1.o CT14Pdf.o FXN1.o MC_VEGAS.o
./calc
