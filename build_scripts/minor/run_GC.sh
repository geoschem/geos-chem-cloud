#!/bin/bash
# execute this within run directory
export OMP_NUM_THREADS=$(nproc) # OpenMP threads = number of CPUs
./geos.mp