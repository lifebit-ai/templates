FROM continuumio/miniconda3@sha256:456e3196bf3ffb13fee7c9216db4b18b5e6f4d37090b31df3e0309926e98cfe2
LABEL description="Dockerfile containing all the requirements for the report of - " \
      author="your_email@website.domain"

ARG ENV_NAME="base"

RUN apt-get update -y \
  && apt-get install -y \
     procps \
     libxt-dev \
  && rm -rf /var/lib/apt/lists/*

COPY environment.yml /
RUN conda env update -n ${ENV_NAME} -f environment.yml && conda clean -a

# Add conda installation dir to PATH (instead of doing 'conda activate')
ENV PATH /opt/conda/envs/${ENV_NAME}/bin:$PATH

# Dump the details of the installed packages to a file for posterity
RUN conda env export --name ${ENV_NAME} > ${ENV_NAME}_exported.yml

# Initialise bash for conda
RUN conda init bash
