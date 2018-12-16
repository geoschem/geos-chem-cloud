#!/bin/bash

if [ "$1" ]; then
  DATA_ROOT=$1
else
  echo 'Must specify path to ExtData/ directory'
  exit 1
fi

aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/GEOSCHEM_RESTARTS/ $DATA_ROOT/GEOSCHEM_RESTARTS  \
--exclude "*" \
--include "v2018-11/initial_GEOSChem_rst.4x5_standard.nc"
