#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

# add srcs for deb
sed -Ei 's/^Components: main /Components: main contrib non-free non-free-firmware /' /etc/apt/sources.list.d/debian.sources
cat >/etc/apt/sources.list <<EOL
deb http://deb.debian.org/debian/ sid main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ sid main contrib non-free non-free-firmware
EOL

apt update
apt upgrade -y
apt install -y gnupg curl wget
wget -q -O- https://packagecloud.io/dcommander/virtualgl/gpgkey |
	gpg --dearmor >/etc/apt/trusted.gpg.d/VirtualGL.gpg
echo "deb [signed-by=/etc/apt/trusted.gpg.d/VirtualGL.gpg] https://packagecloud.io/dcommander/virtualgl/any/ any main" >/etc/apt/sources.list.d/virtualgl.list
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt update

apt install --no-install-recommends -y \
	$(cat /tmp/lists/debian.list) \
	fastfetch \
	gcc \
	g++ \
	python3-dev \
	python3-pip

rm -rfv /usr/share/backgrounds/*

# backwards compat for password generation
pip install crypt-r --break-system-packages

# package clean up
apt remove --purge -y \
	gcc \
	g++ \
	python3-dev \
	python3-pip

# remove duplicate sources
rm -f /etc/apt/sources.list

# remove screensaver and lock screen
rm -f /etc/xdg/autostart/xscreensaver.desktop

# configure vgl
/opt/VirtualGL/bin/vglserver_config +glx +s +f +t

# run clean up
apt clean -y
apt autoclean -y
apt autoremove --purge -y
rm -rfv /var/lib/{apt,cache,log}/ /tmp/* /etc/systemd /var/lib/apt/lists/* /var/tmp/* /tmp/*
