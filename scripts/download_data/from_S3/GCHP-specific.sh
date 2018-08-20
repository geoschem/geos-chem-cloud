#!/bin/bash
# Pull GCHP input data sample from S3
# Assume that data for GC-classic are already there (basic HEMCO data + metfield)

aws s3 cp --request-payer=requester s3://gcgrid/SPC_RESTARTS/initial_GEOSChem_rst.c24_standard.nc ~/gcdata/ExtData/SPC_RESTARTS/

mkdir -p ~/gcdata/ExtData/GCHP/TileFiles/
aws s3 cp --request-payer=requester --recursive s3://gcgrid/GCHP/TileFiles/ ~/gcdata/ExtData/GCHP/TileFiles/
