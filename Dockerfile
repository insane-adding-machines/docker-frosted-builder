FROM ubuntu

MAINTAINER Mark Olsson <post@markolsson.se>

RUN apt-get update; \
		apt-get -y upgrade; \
		apt-get -y install build-essential git wget nano curl bzip2 libncurses5-dev python;

RUN mkdir -p /root/toolchains; \
	cd /root/toolchains; \
	wget https://github.com/insane-adding-machines/crosstool-ng/releases/download/v16.07.003/arm-frosted-eabi-5.3.0_16.07.003.tar.bz2; \
	bzip2 -d arm-frosted-eabi-5.3.0_16.07.003.tar.bz2; \
	tar xvf arm-frosted-eabi-5.3.0_16.07.003.tar;

ENV PATH /root/toolchains/arm-frosted-eabi/bin:$PATH

RUN mkdir -p /root/src; \
	cd /root/src; \
	git clone https://github.com/k0d/frosted.git /root/src/frosted; \
	cd /root/src/frosted; \
	git submodule init && git submodule update; \
	cd /root/src/frosted/frosted-userland; \
	git submodule init && git submodule update;

WORKDIR /root/src/frosted

CMD /bin/bash
