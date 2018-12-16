#!/bin/bash

if [ "$1" ]; then
  DATA_ROOT=$1
else
  echo 'Must specify path to ExtData/ directory'
  exit 1
fi

# exclude huge data directories that are not in use by default
# for CEDS, only get the most recent year
time aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/HEMCO/ $DATA_ROOT/HEMCO \
--exclude "NEI2011/v2015-03/*" \
--exclude "NEI2011ek/v2018-04/*" \
--exclude "NEI2008/*" \
--exclude "CH4/*" \
--exclude "QFED/*" \
--exclude "GFAS/*" \
--exclude "OFFLINE*" \
--exclude "CEDS/*" \
--include "CEDS/v2018-08/2014/*" \

# TODO: if there are too many big directories to exclude, consider using --include instead.
# They are many directories, so shoud probably read from HEMCO_Config.rc?