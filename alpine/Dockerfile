# Catenae Link base image
# Copyright (C) 2017 Rodrigo Martínez <dev@brunneis.com>
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

FROM catenae/aerospike-client-python:2.2.3

ARG CATENAE_VERSION
ARG LIBRDKAFKA_VERSION
ARG CONFLUENT_KAFKA_VERSION
ENV LIBRDKAFKA_BASE_URL=https://github.com/edenhill/librdkafka/archive

RUN \
    apk update && apk upgrade \
    && apk add \
    bash \
    build-base \
    curl \
    && curl -L $LIBRDKAFKA_BASE_URL/v$LIBRDKAFKA_VERSION.tar.gz -o librdkafka.tar.gz -s \
    && tar xf librdkafka.tar.gz \
    && cd librdkafka-$LIBRDKAFKA_VERSION \
    && ./configure --prefix=/usr \
    && make -j \
    && make install \
    && cd .. \
    && rm -r librdkafka-$LIBRDKAFKA_VERSION \
    && rm librdkafka.tar.gz

RUN \
    pip install --upgrade pip \
    && pip install \
    deprecated \
    web3 \
    pymongo \
    confluent-kafka==$CONFLUENT_KAFKA_VERSION \
    orderedset \
    lxml \
    pyyaml \
    dateutils \
    pickle5 \
    flask \
    flask-restful \
    flask_cors \
    gunicorn \
    eventlet \
    catenae==$CATENAE_VERSION \
    && apk del --purge build-base \
    && rm -rf /var/cache/apk/* /root/.cache/pip \
    && find / -type d -name __pycache__ -exec rm -r {} \+ \
    && echo "tcp 6 TCP\nudp 17 UDP" >> /etc/protocols   

ENV \
    CATENAE_DOCKER=true \
    JSONRPC_PORT=9494 \
    JSONRPC_HOST=localhost \
    JSONRPC_SCHEME=http

WORKDIR /opt/catenae
ENTRYPOINT ["python"]
