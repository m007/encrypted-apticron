FROM debian:stretch
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q && apt-get install -qy \
    less nano curl apticron gnupg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ADD alfreds-keys/alfreds-gpg-key.pub /root/
ADD alfreds-keys/alfreds-gpg-key.sec /root/
RUN gpg --batch --import /root/alfreds-gpg-key.sec && \
    gpg --import /root/alfreds-gpg-key.pub

RUN gpg --keyserver pgp.mit.edu --receive-keys 30CD5E17BDA2FBC3
ADD apticron /usr/sbin/
ADD apticron.conf /etc/apticron/
RUN sed -i '/^NOTIFY_NO_UPDATES/c\NOTIFY_NO_UPDATES="1"' /etc/apticron/apticron.conf && \
    sed -i '/^EMAIL=/s/root/alfred.j.kwak@ducks.nl/' /etc/apticron/apticron.conf

WORKDIR /root
