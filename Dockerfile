FROM ubuntu:18.04

MAINTAINER <christoph.hahn@uni-graz.at>

RUN apt-get update && apt-get -y upgrade && apt-get install -y build-essential vim git wget \
#	python python-dev python-pip \
	libtbb-dev zlib1g-dev libncurses5-dev libbz2-dev liblzma-dev libcurl3-dev \
	python3 python3-pip && \
	apt-get clean && apt-get purge && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#python-numpy python-scipy python-biopython

WORKDIR /usr/src

#Samtools
RUN wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 && \
        tar jxf samtools-1.9.tar.bz2 && \
        rm samtools-1.9.tar.bz2 && \
        cd samtools-1.9 && \
        ./configure --prefix $(pwd) && \
        make

#blobtools
RUN wget https://github.com/DRL/blobtools/archive/blobtools_v1.1.1.tar.gz && \
	tar xvfz blobtools_v1.1.1.tar.gz && \
	rm blobtools_v1.1.1.tar.gz && \
	cd blobtools-blobtools_v1.1.1/ && \
	pip3 install docopt matplotlib tqdm wget pyyaml pysam
RUN cd blobtools-blobtools_v1.1.1/ && \
	wget ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz -P data/ && \
	tar zxf data/taxdump.tar.gz -C data/ nodes.dmp names.dmp && \
	./blobtools nodesdb --nodes data/nodes.dmp --names data/names.dmp

ENV PATH=${PATH}:/usr/src/blobtools-blobtools_v1.1.1
