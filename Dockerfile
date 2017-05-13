FROM debian:jessie

RUN apt-get update -yqq  && apt-get install -yqq \
  wget \
  bzip2 \
  git \
  libglib2.0-0 \
  && rm -rf /var/lib/apt/lists/*

# Configure environment
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Folder to install non-system tools
RUN mkdir -p /work/bin

# Create a non-priviledge user that will run the services
#ENV BASICUSER basicuser
#ENV BASICUSER_UID 1000
#RUN useradd -m -d /work -s /bin/bash -N -u $BASICUSER_UID $BASICUSER
#RUN chown $BASICUSER /work
#USER $BASICUSER

# Deactivate basic user to make it easier to deal with volume permissions
ENV BASICUSER root
WORKDIR /work

# Install Python 3 from miniconda
RUN wget -O miniconda.sh \
  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
  && bash miniconda.sh -b -p /work/miniconda \
  && rm miniconda.sh

ENV PATH="/work/bin:/work/miniconda/bin:$PATH"

RUN conda install -y \
  pip \
  setuptools \
  numpy \
  pandas \
  && conda clean -tipsy

# Install the master branch of distributed and dask
COPY requirements.txt .
RUN pip install -r requirements.txt && rm -rf ~/.cache/pip/

# Add local files at the end of the Dockerfule to limit cache busting
COPY start-dworker.sh ./bin/
COPY start-dscheduler.sh ./bin/
