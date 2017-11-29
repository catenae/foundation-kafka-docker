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

ENV LIBRDKAFKA_VERSION=0.11.1 \
LIBRDKAFKA_BASE_URL=https://github.com/edenhill/librdkafka/archive

RUN \
    apk update && apk upgrade \
    && apk add \
        bash \
        build-base \
    && wget $LIBRDKAFKA_BASE_URL/v$LIBRDKAFKA_VERSION.tar.gz \
    && tar xf v$LIBRDKAFKA_VERSION.tar.gz \
    && cd librdkafka-$LIBRDKAFKA_VERSION \
    && ./configure --prefix=/usr \
    && make -j \
    && make install \
    && cd .. \
    && rm -r librdkafka-$LIBRDKAFKA_VERSION \
    && rm v$LIBRDKAFKA_VERSION.tar.gz \
    && cd /opt \
    && pip install --upgrade pip \
    && pip install \
        confluent-kafka \
        orderedset \
        lxml \
        pyyaml \
        dateutils \
        catenae \
    && apk del --purge \
        bash \
        build-base \
    && rm -rf \
        /root/.cache/pip \
        /var/cache/apk/* \
    && find / -type d -name __pycache__ -exec rm -r {} \+
