#!/bin/bash

# absolutely minimum requirement to analyze NetCDF data
conda install -y jupyter netcdf4 xarray cartopy

# Also install AWSCLI into conda environment
pip install -y awscli