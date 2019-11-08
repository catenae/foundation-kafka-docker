# Catenae Link base image
# Copyright (C) 2017-2019 Rodrigo Martínez <dev@brunneis.com>
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

ARG LIBRDKAFKA_VERSION
ARG CONFLUENT_KAFKA_VERSION
ARG ROCKSDB_VERSION

# Build librdkafka
RUN \
    LIBRDKAFKA_BASE_URL=https://github.com/edenhill/librdkafka/archive \
    && apt-get update \
    && dpkg-query -Wf '${Package}\n' | sort > init_pkgs \
    && apt-get -y install \
    build-essential \
    curl \
    && dpkg-query -Wf '${Package}\n' | sort > current_pkgs \
    && apt-get -y install \
    libssl-dev \
    zlib1g-dev \
    && curl -L $LIBRDKAFKA_BASE_URL/v$LIBRDKAFKA_VERSION.tar.gz -o librdkafka.tar.gz -s \
    && tar xf librdkafka.tar.gz \
    && cd librdkafka-$LIBRDKAFKA_VERSION \
    && ./configure --prefix=/usr \
    && make -j \
    && make install \
    && cd .. \
    && rm -r librdkafka-$LIBRDKAFKA_VERSION \
    && rm librdkafka.tar.gz

# Build rocksdb
RUN \
    ROCKSDB_BASE_URL=https://github.com/facebook/rocksdb/archive \
    && apt-get install -y \
    libsnappy-dev \
    libbz2-dev \
    libgflags-dev \
    liblz4-dev \
    libzstd-dev \
    && curl -L $ROCKSDB_BASE_URL/v$ROCKSDB_VERSION.tar.gz -o rocksdb.tar.gz -s \
    && tar xf rocksdb.tar.gz \
    && cd rocksdb-$ROCKSDB_VERSION \
    && DEBUG_LEVEL=0 make shared_lib install-shared \
    && cd .. \
    && rm -r rocksdb-$ROCKSDB_VERSION \
    && rm rocksdb.tar.gz

RUN \
    pip install --upgrade pip \
    && pip install \
    confluent-kafka==$CONFLUENT_KAFKA_VERSION \
    easymongo \
    easyaerospike \
    easyrocks \
    synced \
    txlog \
    orderedset \
    lxml \
    pyyaml \
    dateutils \
    flask \
    flask-restful \
    flask_cors \
    gunicorn==19.9.0 \
    eventlet \
    web3==5.0.0 \
    pickle5 \
    && apt-get -y purge $(diff -u init_pkgs current_pkgs | grep -E "^\+" | cut -d + -f2- | sed -n '1!p' | uniq) \
    && apt-get clean \
    && rm -rf init_pkgs current_pkgs /root/.cache/pip \
    && find / -type d -name __pycache__ -exec rm -r {} \+ \
    && echo "tcp 6 TCP\nudp 17 UDP" >> /etc/protocols

ENV \
    LD_LIBRARY_PATH=/usr/local/lib \
    CATENAE_DOCKER=true \
    JSONRPC_PORT=9494 \
    JSONRPC_HOST=localhost \
    JSONRPC_SCHEME=http

WORKDIR /opt/catenae
ENTRYPOINT ["python"]
