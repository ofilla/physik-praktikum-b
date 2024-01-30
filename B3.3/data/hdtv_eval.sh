#!/bin/bash

file="$1"

echo "### with tail left free" | tee "${file%.spa}.log"
hdtv -e "spectrum get $file; calibration position enter 0 0 10450.4 5486; fit parameter tl free" 2>&1 | tee -a "${file%.spa}.log"

echo >> "${file%.spa}.log"
echo >> "${file%.spa}.log"
echo "### without tail left free" | tee -a "${file%.spa}.log"
hdtv -e "spectrum get $file; calibration position enter 0 0 10450.4 5486" 2>&1 | tee -a "${file%.spa}.log"
