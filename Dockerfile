FROM ubuntu:16.04

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y liblzo2-2 libvorbis0a libvorbisfile3 libvorbisenc2 libogg0

WORKDIR /app

COPY ./depbo/lib/* /usr/local/lib/
COPY ./depbo/* /usr/local/bin/

RUN chmod +rwx /usr/local/lib/libdepbo.so.0*
RUN chmod +rwx /usr/local/bin/*

RUN ldconfig
