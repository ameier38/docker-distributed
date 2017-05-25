#!/bin/bash
NCPUS=`python -c "import multiprocessing as mp; print(mp.cpu_count())"`
START_PORT = 50800
echo "Detected $NCPUS cpus"
source activate py3
for (( port=START_PORT;i<$NCPUS;port++ ))
do
    dask-worker scheduler:8786 --nthreads 1 --nprocs 1 --worker-port $port
done
