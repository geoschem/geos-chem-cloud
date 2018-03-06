#!/bin/bash
# execute this within run directory

# Set OpenMP threads to the number of CPUs
# NOTE: nproc only works if OMP_NUM_THREADS is unset! If OMP_NUM_THREADS is already set, then nproc will just return OMP_NUM_THREADS. Ref: https://www.gnu.org/software/coreutils/manual/html_node/nproc-invocation.html
unset OMP_NUM_THREADS
export OMP_NUM_THREADS=$(nproc) 

./geos.mp