#!/bin/bash

apt-get update -y
apt-get install -y \
        bash \
        coreutils \
        grep \
        iproute2 \
        iputils-ping \
        traceroute \
        tcpdump \
        bind9-dnsutils \
        dnsmasq-base \
        netcat-openbsd \
        python3 \
        curl \
        wget \
        iptables \
        procps \
        isc-dhcp-client

timedatectl set-timezone Asia/Tokyo
