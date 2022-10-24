

FROM nfcore/base:1.13.3
LABEL authors="Barry Digby" \
    description="python 3 container for nf-core/circrna"

RUN apt-get update; apt-get clean all;

RUN apt-get install --yes build-essential \
                        gcc-multilib \
                        apt-utils \
                        zip \
                        unzip \
                        expat \
                        libexpat-dev \
                        libtbb-dev
                        
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt install python3.7

# Add 3.7 to the available alternatives
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.7

# Set python3.7 as the default python
RUN update-alternatives --set python /usr/bin/python3.7

WORKDIR /usr/src/app
RUN wget --no-check-certificate https://github.com/dieterich-lab/DCC/archive/v0.5.0.tar.gz
RUN tar -xvf v0.5.0.tar.gz
WORKDIR /usr/src/app/DCC-0.5.0
# remove --user or else scripts installed to /root/
RUN python setup.py install
