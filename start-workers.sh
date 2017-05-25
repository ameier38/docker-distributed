#!/bin/bash
WORKER_PORT=50800
NANNY_PORT=50801
source activate py3
dask-worker scheduler:8786 --worker-port $WORKER_PORT --nanny-port $NANNY_PORT
