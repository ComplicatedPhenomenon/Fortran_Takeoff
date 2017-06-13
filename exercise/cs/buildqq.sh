#!/bin/sh
rm -rf *.mod
rm -rf *.o
rm DATA.txt
rm -rf ./calc

gfortran -c CT14Pdf.for
gfortran -c FXNqq.f90
gfortran -c MC_VEGAS.f90
gfortran -c MAINqq.f90

gfortran -o calc MAINqq.o CT14Pdf.o FXNqq.o MC_VEGAS.o
./calc
