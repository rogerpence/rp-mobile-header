FROM node:latest

LABEL maintainer="Roger Pence"

RUN apt-get update \
    && apt-get install -y vim \
    && apt-get install -y --no-install-recommends apt-utils \
    && apt-get install apt-transport-https \
    # Yarn stuff. 
    # && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg |  apt-key add - \
    # && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

WORKDIR /opt    

# RUN cd /opt \
#     && npm install gulp-cli -g \
#     && npm init -y \
#     && npm install --save-dev gulp \
#     && npm install --save-dev tailwindcss \
#     && mkdir root

RUN echo 'npm-do() { (PATH=$(npm bin):$PATH; eval $@;) }' >> /root/.bashrc

# WORKDIR /opt/root
