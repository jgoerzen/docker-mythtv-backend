#!/bin/bash

set -e
set -x

cd /tmp/setup
wget http://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb
wget http://ftp.osuosl.org/pub/mythtv/3rdParty/jwplayer.zip
sha256sum -c < sums
dpkg -i deb-multimedia-keyring_2016.8.1_all.deb
echo 'deb http://deb.debian.org/debian bullseye-backports main contrib non-free' >> /etc/apt/sources.list
echo 'deb http://www.deb-multimedia.org bullseye main non-free' >> /etc/apt/sources.list
echo 'deb http://www.deb-multimedia.org bullseye-backports main' >> /etc/apt/sources.list
rm deb-multimedia-keyring_2016.8.1_all.deb

