#!/bin/bash
# Pull GCHP input data sample from S3
# Assume that data for GC-classic are already there (basic HEMCO data + metfield)

if [ "$1" ]; then
  DATA_ROOT=$1
else
  echo 'Must specify path to ExtData/ directory'
  exit 1
fi

aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/GEOSCHEM_RESTARTS/ $DATA_ROOT/GEOSCHEM_RESTARTS  \
--exclude "*" \
--include "v2016-07/initial_GEOSChem_rst.c24_standard.nc" \
--include "v2018-11/initial_GEOSChem_rst.c24_standard.nc"

mkdir -p $DATA_ROOT/GCHP/TileFiles/
aws s3 cp --request-payer=requester --recursive s3://gcgrid/GCHP/TileFiles/ $DATA_ROOT/GCHP/TileFiles/

aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/HEMCO/ $DATA_ROOT/HEMCO \
--exclude "*" \
--include "OFFLINE*" \
--exclude "OFFLINE/OFFLINE_LNOX/v2018-11/*"
