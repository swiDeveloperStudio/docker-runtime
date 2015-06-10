FROM ubuntu:trusty

## UTF8 support
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

## Prereq
ADD sources.list /etc/apt/
RUN apt-get -q update
RUN apt-get -q -y install \
	build-essential python-jinja2 inetutils-ping \
	vim git-core ninja-build \
	&& apt-get clean

## DS specific
ENV LEGATO_ROOT /legato
ENV PATH $LEGATO_ROOT/bin:$PATH
ENV LEGATO_LOCALHOST_LIB_PATH $LEGATO_ROOT/build/localhost/bin/lib/
ENV TOOLCHAIN_PROFILES /opt/swi/profiles.d

## Legato env
ADD legatoenv /legatoenv
RUN echo "source /legatoenv" >> /etc/bash.bashrc 
ENV BASH_ENV /legatoenv

#ENTRYPOINT  ["/bin/bash"]
#CMD         ["-l"]
WORKDIR     /

