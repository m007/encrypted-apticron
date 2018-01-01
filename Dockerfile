# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
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
