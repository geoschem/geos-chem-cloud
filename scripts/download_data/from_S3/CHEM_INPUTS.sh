#!/bin/bash

if [ "$1" ]; then
  DATA_ROOT=$1
else
  echo 'Must specify path to ExtData/ directory'
  exit 1
fi

time aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/GEOS_NATIVE $DATA_ROOT/CHEM_INPUTS  \
--exclude "*" \
--include "FastJ_201204/*" \
--include "Linoz_200910/*" \
--include "MODIS_LAI_201204/*" \
--include "Olson_Land_Map_201203/*" \
--include "TOMAS_201402/*" \
--include "UCX_201403/*"

aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/CHEM_INPUTS $DATA_ROOT/CHEM_INPUTS  \
--exclude "*" \
--include "MODIS_LAI_201707/*" \
--include "FAST_JX/*"
