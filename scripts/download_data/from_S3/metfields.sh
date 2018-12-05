#!/bin/bash

DATA_ROOT=~/ExtData

# GEOSFP 4x5 CN field
aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/GEOS_4x5/GEOS_FP/2011/01/ $DATA_ROOT/GEOS_4x5/GEOS_FP/2011/01/

# GEOSFP 4x5 1-month (~2.5GB)
aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/GEOS_4x5/GEOS_FP/2016/07/ $DATA_ROOT/GEOS_4x5/GEOS_FP/2016/07/


# GEOSFP 2x2.5 CN field
aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/GEOS_2x2.5/GEOS_FP/2011/01/ $DATA_ROOT/GEOS_2x2.5/GEOS_FP/2011/01/

# GEOSFP 2x2.5 1-month (~2.5GB)
aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/GEOS_2x2.5/GEOS_FP/2016/07/ $DATA_ROOT/GEOS_2x2.5/GEOS_FP/2016/07/
