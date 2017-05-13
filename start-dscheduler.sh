#!/bin/bash
exec su $BASICUSER -c "env PATH=$PATH dask-scheduler --host dscheduler"
