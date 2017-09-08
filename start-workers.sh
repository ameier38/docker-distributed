#!/bin/bash
NCPUS=`python -c "import multiprocessing as mp; print(mp.cpu_count())"`
echo "Detected $NCPUS cpus"
source activate py3
dask-worker scheduler:8786 --nprocs $NCPUS --memory-limit=auto
