FROM continuumio/miniconda3
RUN conda update conda
RUN apt-get install -y gcc
COPY environment.yml .
RUN conda env update
COPY config.yaml ~/.dask/
ENV DASK_CONFIG=~/.dask/config.yaml
