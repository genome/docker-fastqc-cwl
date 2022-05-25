FROM ubuntu:focal

# NOTE- at the time of writing, ubuntu:jammy is latest LTS, but using it
# causes java to throw an error that prevents fastqc from running
# originally based on https://github.com/StaPH-B/docker-builds/blob/master/fastqc/0.11.9/Dockerfile

ENV DEBIAN_FRONTEND=noninteractive

# install dependencies; cleanup apt garbage
RUN apt-get update && apt-get install -y \
 unzip \
 wget \
 locales \
 perl \
 default-jre && \
 apt-get autoclean && rm -rf /var/lib/apt/lists/*

# quiet perl locale warnings
RUN locale-gen en_US.UTF-8

WORKDIR /usr/local/bin

# install fastqc
RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip && \
    unzip fastqc_v0.11.9.zip && \
    rm fastqc_v0.11.9.zip && \
    chmod +x FastQC/fastqc

