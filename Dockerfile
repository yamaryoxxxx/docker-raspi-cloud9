FROM resin/rpi-raspbian:stretch
MAINTAINER yamaryoxxxx@gmail.com

# initialization
RUN apt-get update

# install nodejs
# https://github.com/audstanley/NodeJs-Raspberry-Pi
RUN apt-get install -y wget
RUN wget -O - https://raw.githubusercontent.com/audstanley/NodeJs-Raspberry-Pi/master/Install-Node.sh | sudo bash

# install nodemon
RUN npm install -g nodemon

# install cloud9
RUN apt-get install -y git python-setuptools python-dev
RUN apt-get install -y make gcc g++ build-essential libc6-dev
RUN git clone https://github.com/c9/core.git /cloud9 && \
    cd /cloud9 && \
    ./scripts/install-sdk.sh

# entry point
WORKDIR /cloud9
EXPOSE 8181
VOLUME /workspace
CMD while true; do node ./server.js -p 8181 -l 0.0.0.0 -a : -w /workspace; sleep 5; done
