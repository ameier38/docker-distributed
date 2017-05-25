FROM continuumio/miniconda3
RUN conda update conda
RUN apt-get install -y gcc

# Create conda environment
COPY cluster-environment.yml .
RUN conda env update -f cluster-environment.yml

# Configure Dask
COPY config.yaml ./.dask/
ENV DASK_CONFIG=/.dask/config.yaml

# Copy scheduler and worker scripts
COPY start-scheduler.sh ./bin
COPY start-workers.sh ./bin
ENV ENV PATH="/bin:$PATH"
