#!/bin/bash
# HEMCO/GMI has some softlinks that are ignored by S3

DATA_ROOT=~/ExtData

cd $DATA_ROOT/HEMCO/GMI/v2015-02

ln -s gmi.clim.PMN.geos5.2x25.nc gmi.clim.IPMN.geos5.2x25.nc
ln -s gmi.clim.PMN.geos5.2x25.nc gmi.clim.NPMN.geos5.2x25.nc
ln -s gmi.clim.RIP.geos5.2x25.nc gmi.clim.RIPA.geos5.2x25.nc
ln -s gmi.clim.RIP.geos5.2x25.nc gmi.clim.RIPB.geos5.2x25.nc
ln -s gmi.clim.RIP.geos5.2x25.nc gmi.clim.RIPD.geos5.2x25.nc
