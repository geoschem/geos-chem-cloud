#!/bin/bash
# Pull GCHP input data sample from S3
# Assume that data for GC-classic are already there (basic HEMCO data + metfield)

DATA_ROOT=~/ExtData

aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/GEOSCHEM_RESTARTS/ $DATA_ROOT/GEOSCHEM_RESTARTS  \
--exclude "*" \
--include "v2016-07/initial_GEOSChem_rst.c24_standard.nc"

mkdir -p $DATA_ROOT/GCHP/TileFiles/
aws s3 cp --request-payer=requester --recursive s3://gcgrid/GCHP/TileFiles/ $DATA_ROOT/GCHP/TileFiles/

aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/HEMCO/ $DATA_ROOT/HEMCO \
--exclude "*" \
--include "OFFLINE*" \
--exclude "OFFLINE/OFFLINE_LNOX/v2018-11/*"
