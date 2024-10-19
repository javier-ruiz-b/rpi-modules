#!/bin/sh
set -eu

apt-get install -yq \
    libcamera0 \
    libfreetype6

cd /tmp

version=v1.5.1
case "$(dpkg --print-architecture)" in
amd64)  wget https://github.com/bluenviron/mediamtx/releases/download/${version}/mediamtx_${version}_linux_amd64.tar.gz ;;
arm64)  wget https://github.com/bluenviron/mediamtx/releases/download/${version}/mediamtx_${version}_linux_arm64v8.tar.gz ;;
armhf)  wget https://github.com/bluenviron/mediamtx/releases/download/${version}/mediamtx_${version}_linux_armv6.tar.gz ;;
esac

tar xfz mediamtx_*tar.gz

mkdir -p /etc/mediamtx /usr/local/bin
mv mediamtx.yml /etc/mediamtx
chmod +x mediamtx
mv mediamtx /usr/local/bin/

systemctl enable mediamtx.service

rm /tmp/mediamtx*