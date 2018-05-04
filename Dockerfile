FROM resin/rpi-raspbian:stretch
MAINTAINER yamaryoxxxx@gmail.com

# apt-get
RUN apt-get update
RUN apt-get install wget

# install nodejs
# https://github.com/audstanley/NodeJs-Raspberry-Pi
RUN wget -O - https://raw.githubusercontent.com/audstanley/NodeJs-Raspberry-Pi/master/Install-Node.sh | sudo bash

# install nodemon
RUN npm install -g nodemon

# install cloud9
RUN git clone https://github.com/c9/core.git /cloud9 && \
    cd /cloud9 && \
    ./scripts/install-sdk.sh


# entry
WORKDIR /cloud9
EXPOSE 8181
VOLUME /workspace
CMD nodemon ./server.sh -p 8181 -l 0.0.0.0 -w /workspace

