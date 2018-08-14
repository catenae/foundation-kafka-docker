# Catenae Link base image
# Copyright (C) 2018 Rodrigo Martínez <dev@brunneis.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

FROM brunneis/python:3.7

ARG CATENAE_VERSION
ARG LIBRDKAFKA_VERSION
ARG CONFLUENT_KAFKA_VERSION
ENV LIBRDKAFKA_BASE_URL https://github.com/edenhill/librdkafka/archive

RUN \
    apt-get update && apt-get -y upgrade \
    && dpkg-query -Wf '${Package}\n' | sort > init_pkgs \
    && apt-get -y install \
        build-essential \
        curl \
        libssl-dev \
        zlib1g-dev \
    && dpkg-query -Wf '${Package}\n' | sort > new_pkgs \
    && curl -L $LIBRDKAFKA_BASE_URL/v$LIBRDKAFKA_VERSION.tar.gz -o librdkafka.tar.gz -s \
    && tar xf librdkafka.tar.gz \
    && cd librdkafka-$LIBRDKAFKA_VERSION \
    && ./configure --prefix=/usr \
    && make -j \
    && make install \
    && cd .. \
    && rm -r librdkafka-$LIBRDKAFKA_VERSION \
    && rm librdkafka.tar.gz \
    && pip install --upgrade pip \
    && pip install \
        aerospike \
        confluent-kafka==$CONFLUENT_KAFKA_VERSION \
	pymongo \
        orderedset \
        lxml \
        pyyaml \
        dateutils \
        catenae==$CATENAE_VERSION \
    && apt-get -y purge $(diff -u init_pkgs new_pkgs | grep -E "^\+" | cut -d + -f2- | sed -n '1!p') \
    && apt-get clean \
    && rm init_pkgs new_pkgs \
    && rm -rf \
        /root/.cache/pip \
    && find / -type d -name __pycache__ -exec rm -r {} \+

ENTRYPOINT ["bash", "--login", "-i"]
