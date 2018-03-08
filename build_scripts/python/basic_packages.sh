#!/bin/bash

# absolutely minimum requirement to analyze NetCDF data
# NOTE: Install older version of tornado to prevent Jupyter error
# https://stackoverflow.com/questions/49141525/install-jupyter-notebook-on-miniconda
conda install -y tornado=4.5.3 jupyter netcdf4 xarray cartopy

# Also install AWSCLI into conda root environment
pip install -y awscli