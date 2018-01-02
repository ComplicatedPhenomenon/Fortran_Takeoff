#!/bin/bash

for (( i = 0; i <=100; i++ ))
do 
    ./calc $i
done

rm calc
