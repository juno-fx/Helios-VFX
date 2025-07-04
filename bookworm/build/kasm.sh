#!/bin/bash

set -e

# get initial sources list
apt-get update

# add srcs for deb
sed -Ei 's/^Components: main /Components: main contrib non-free non-free-firmware /' /etc/apt/sources.list.d/debian.sources
cat >/etc/apt/sources.list <<EOL
deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware

deb http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware

deb http://deb.debian.org/debian/ bookworm-backports main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm-backports main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware
EOL

# install deps
apt-get update
apt-get build-dep -y \
	libxfont-dev \
	xorg-server
apt-get install -y \
	curl \
	wget \
	autoconf \
	automake \
	cmake \
	git \
	grep \
	libavcodec-dev \
	libdrm-dev \
	libepoxy-dev \
	libgbm-dev \
	libgif-dev \
	libgnutls28-dev \
	libgnutls28-dev \
	libjpeg-dev \
	libjpeg62-turbo-dev \
	libpciaccess-dev \
	libpng-dev \
	libssl-dev \
	libtiff-dev \
	libtool \
	libx11-dev \
	libxau-dev \
	libxcursor-dev \
	libxcursor-dev \
	libxcvt-dev \
	libxdmcp-dev \
	libxext-dev \
	libxkbfile-dev \
	libxrandr-dev \
	libxrandr-dev \
	libxshmfence-dev \
	libxtst-dev \
	libavformat-dev \
	libswscale-dev \
	meson \
	nettle-dev \
	tar \
	tightvncserver \
	wget \
	wayland-protocols \
	xinit \
	xserver-xorg-dev

# handle sharpyuv deps for downstream X build
# pulled from here: https://launchpad.net/~savoury1/+archive/ubuntu/scribus/+sourcepub/16967838/+listing-archive-extra
wget -O sharpyuv.deb https://launchpad.net/~savoury1/+archive/ubuntu/scribus/+files/libsharpyuv-dev_1.5.0-0.1~22.04.sav0_amd64.deb
wget -O libsharpyuv0_1.deb https://launchpad.net/~savoury1/+archive/ubuntu/scribus/+files/libsharpyuv0_1.5.0-0.1~22.04.sav0_amd64.deb
wget -O libwebp-dev.deb https://launchpad.net/~savoury1/+archive/ubuntu/scribus/+files/libwebp-dev_1.5.0-0.1~22.04.sav0_amd64.deb
wget -O libwebp.deb https://launchpad.net/~savoury1/+archive/ubuntu/scribus/+files/libwebp7_1.5.0-0.1~22.04.sav0_amd64.deb
wget -O libwebpdecoder.deb https://launchpad.net/~savoury1/+archive/ubuntu/scribus/+files/libwebpdecoder3_1.5.0-0.1~22.04.sav0_amd64.deb
wget -O libwebpdemux.deb https://launchpad.net/~savoury1/+archive/ubuntu/scribus/+files/libwebpdemux2_1.5.0-0.1~22.04.sav0_amd64.deb
wget -O libwebpmux3.deb https://launchpad.net/~savoury1/+archive/ubuntu/scribus/+files/libwebpmux3_1.5.0-0.1~22.04.sav0_amd64.deb
apt-get install ./*.deb -y
