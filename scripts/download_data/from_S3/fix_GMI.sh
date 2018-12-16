#!/bin/bash
# HEMCO/GMI has some softlinks that are ignored by S3

if [ "$1" ]; then
  DATA_ROOT=$1
else
  echo 'Must specify path to ExtData/ directory'
  exit 1
fi

cd $DATA_ROOT/HEMCO/GMI/v2015-02

ln -s gmi.clim.PMN.geos5.2x25.nc gmi.clim.IPMN.geos5.2x25.nc
ln -s gmi.clim.PMN.geos5.2x25.nc gmi.clim.NPMN.geos5.2x25.nc
ln -s gmi.clim.RIP.geos5.2x25.nc gmi.clim.RIPA.geos5.2x25.nc
ln -s gmi.clim.RIP.geos5.2x25.nc gmi.clim.RIPB.geos5.2x25.nc
ln -s gmi.clim.RIP.geos5.2x25.nc gmi.clim.RIPD.geos5.2x25.nc
