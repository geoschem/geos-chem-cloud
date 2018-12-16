#/bin/bash

# Usage example:
# $ ./all_input_GCHP.sh ~/ExtData

if [ "$1" ]; then
  DATA_ROOT=$1
else
  echo 'Must specify path to ExtData/ directory'
  exit 1
fi

./all_input_GC-classic.sh $DATA_ROOT
./GCHP-specific.sh $DATA_ROOT