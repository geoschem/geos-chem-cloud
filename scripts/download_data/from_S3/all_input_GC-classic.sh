#/bin/bash

# Usage example:
# $ ./all_input_GC-classic.sh ~/ExtData

if [ "$1" ]; then
  DATA_ROOT=$1
else
  echo 'Must specify path to ExtData/ directory'
  exit 1
fi

./restart_file.sh $DATA_ROOT
./metfields.sh $DATA_ROOT
./CHEM_INPUTS.sh $DATA_ROOT
./HEMCO.sh $DATA_ROOT
./fix_GMI.sh $DATA_ROOT