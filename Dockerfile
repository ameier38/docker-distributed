FROM continuumio/miniconda3

RUN apt-get install -y gcc

COPY environment.yml .
RUN conda env update -n=py3 && source activate py3