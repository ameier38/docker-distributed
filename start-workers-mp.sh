#!/bin/bash
NCPUS=`python -c "import multiprocessing as mp; print(mp.cpu_count())"`
START_PORT=50800
echo "Detected $NCPUS cpus"
source activate py3
PORT=$START_PORT
for (( i=0;i<$NCPUS;i++ ))
do
    worker_port=$PORT
    ((PORT++))
    nanny_port=$PORT
    ((PORT++))
    worker="worker_$i"
    log_file=/$worker.log
    echo "Starting $worker on port $worker_port"
    (dask-worker tcp://scheduler:8786 --nthreads 1 --nprocs 1 --worker-port $worker_port --nanny-port $nanny_port) > $log_file 2>&1 &
done
