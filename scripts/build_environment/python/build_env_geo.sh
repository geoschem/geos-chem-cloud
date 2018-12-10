#!/bin/bash
conda env create -vv -f ./geo.yml
conda clean -tipsy # clean up cache. Saves ~600 MB space