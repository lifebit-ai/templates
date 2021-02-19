FROM continuumio/miniconda3@sha256:456e3196bf3ffb13fee7c9216db4b18b5e6f4d37090b31df3e0309926e98cfe2

LABEL description="Dockerfile containing all the requirements for - " \
      author="your_email@website.domain"

RUN apt-get update -y \
  && apt-get install procps -y \
  && rm -rf /var/lib/apt/lists/*

COPY environment.yml /
RUN conda env create -f environment.yml && conda clean -a
ENV PATH /opt/conda/envs/cromwell-env/bin:$PATH

USER root

WORKDIR /data/

CMD ["bash"]