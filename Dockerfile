FROM verdel/alpine-base:latest
MAINTAINER Vadim Aleksandrov <valeksandrov@me.com>

ENV GRAYLOG_VERSION 2.2.3
ENV JAVA_HOME /usr

RUN apk --no-cache --update add \
    bash \
    openjdk8-jre \
    py-pip \
    && pip install --upgrade pip \
    && pip install requests \
    # Clean up
    && rm -rf \
    /tmp/* \
    /var/cache/apk/*

ADD https://packages.graylog2.org/releases/graylog/graylog-$GRAYLOG_VERSION.tgz /opt/

RUN cd /opt/ \
    && tar xfz graylog-$GRAYLOG_VERSION.tgz \
    && mv graylog-$GRAYLOG_VERSION/ graylog/ \
    && rm graylog-$GRAYLOG_VERSION.tgz

COPY rootfs /

# gelf tcp/udp
EXPOSE 12201
EXPOSE 12201/udp

# rest api
EXPOSE 12900

# syslog
EXPOSE 514
EXPOSE 514/udp
