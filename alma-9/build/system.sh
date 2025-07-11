#!/bin/bash

set -e

dnf install --nogpgcheck -y \
	epel-release \
	https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm \
	https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm \
	almalinux-release-devel
dnf config-manager --add-repo https://raw.githubusercontent.com/VirtualGL/repo/main/VirtualGL.repo
dnf config-manager --set-enabled crb

# install system
dnf update -y
dnf install -y --allowerasing --setopt=install_weak_deps=False --best \
	$(cat /tmp/lists/rhel.list) \
	fastfetch

# handle background
mv -v /usr/share/backgrounds/Alma-waves-sunset-2560x1600.jpg /tmp/background.png
rm -rfv /usr/share/backgrounds/*
mv -v /tmp/background.png /usr/share/backgrounds/

# install node
dnf module install nodejs:20/common -y

# remove screensaver and lock screen
rm -f /etc/xdg/autostart/xscreensaver.desktop

# configure vgl
/opt/VirtualGL/bin/vglserver_config +glx +s +f +t

# run clean up
dnf config-manager --set-disabled crb
dnf remove --nogpgcheck -y \
	epel-release \
	https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm \
	https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm \
	almalinux-release-devel
dnf clean all -y
