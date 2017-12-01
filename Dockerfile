FROM debian:stretch
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q && apt-get install -qy \
    less nano curl apticron gnupg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ADD apticron /usr/sbin/
ADD apticron.conf /etc/apticron
RUN gpg --keyserver pgp.mit.edu --receive-keys 30CD5E17BDA2FBC3
RUN sed -i '/^EMAIL=/s/root/matthias.baumgarten@web.de/' /etc/apticron/apticron.conf

WORKDIR /root
