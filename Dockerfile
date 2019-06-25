FROM node:latest

LABEL maintainer="Roger Pence"

RUN apt-get update \
    && apt-get install -y vim \
    && apt-get install -y --no-install-recommends apt-utils \
    && apt-get install apt-transport-https \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
    



WORKDIR /opt    

