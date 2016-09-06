FROM debian:jessie


## Prereq
RUN echo "deb http://ftp.debian.org/debian/ jessie main" > /etc/apt/sources.list
RUN echo "deb http://ftp.debian.org/debian/ jessie-backports main" >> /etc/apt/sources.list

RUN apt-get --quiet update && apt-get --quiet install --yes --no-install-recommends \
			make python-jinja2 ninja-build bzip2 rsync openjdk-8-jdk zip vim ssh \ 
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

WORKDIR /

