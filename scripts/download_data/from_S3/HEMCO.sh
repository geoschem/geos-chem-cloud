#!/bin/bash
# exclude huge data directories that are in use by default
# ~210 GB in total, CEDS takes 140 GB. To reduce data size for quick testing,
# can disable CEDS in HEMCO_Config.rc and use EDGAR instead

time aws s3 cp --request-payer=requester --recursive \
s3://gcgrid/HEMCO/ ./HEMCO \
--exclude "NEI2011/v2015-03/*" \
--exclude "NEI2011ek/v2018-04/*" \
--exclude "CEDS/*" \
--exclude "QFED/*" \
--exclude "OFFLINE*"
