#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

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
	neofetch

# backwards compat for neofetch
ln -sf /bin/neofetch /bin/fastfetch

rm -rfv /usr/share/backgrounds/*

# remove duplicate sources
rm -f /etc/apt/sources.list

# remove screensaver and lock screen
rm -f /etc/xdg/autostart/xscreensaver.desktop

# configure vgl
/opt/VirtualGL/bin/vglserver_config +glx +s +f +t
# remove duplicate sources
rm -f /etc/apt/sources.list
# install font
mkdir -pv /usr/share/fonts/cascadia-code
cd /tmp
wget https://github.com/microsoft/cascadia-code/releases/download/v2407.24/CascadiaCode-2407.24.zip
unzip CascadiaCode-2407.24.zip
mv -v otf/static/* /usr/share/fonts/cascadia-code/
rm -rfv /tmp/*
fc-cache -f -v

# run clean up
apt clean -y
apt autoclean -y
apt autoremove --purge -y
rm -rfv /var/lib/{apt,cache,log}/ /tmp/* /etc/systemd /var/lib/apt/lists/* /var/tmp/* /tmp/*
