FROM debian:bullseye

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install \
        dnsutils \
        iptables \
        ndppd \
        openssl \
        strongswan \
        uuid-runtime \
        wget \
    && rm -rf /var/lib/apt/lists/*

RUN rm /etc/ipsec.secrets
RUN mkdir /config
RUN (cd /etc && ln -s /config/ipsec.secrets .)

ADD ./etc/* /etc/
ADD ./bin/* /usr/bin/

VOLUME /etc
VOLUME /config

EXPOSE 500/udp 4500/udp

CMD /usr/bin/start-vpn
