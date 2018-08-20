#!/bin/#!/usr/bin/env bash

# GEOSFP 4x5 CN field
aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/GEOS_4x5/GEOS_FP/2011/01/ ./GEOS_4x5/GEOS_FP/2011/01/

# GEOSFP 4x5 1-month (~2.5GB)
aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/GEOS_4x5/GEOS_FP/2016/07/ ./GEOS_4x5/GEOS_FP/2016/07/
