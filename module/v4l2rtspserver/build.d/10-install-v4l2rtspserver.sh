#!/bin/sh
set -eu

apt-get install -yq \
    cmake \
    gcc \
    g++ \
    git \
    libcamera-apps-lite \
    make \
    pkg-config \
    v4l-utils 

cd /tmp
git clone https://github.com/mpromonet/v4l2rtspserver.git
cd v4l2rtspserver
cmake .
make -j"$(nproc)"
make install

systemctl enable v4l2rtspserver

yes | WANT_32BIT=1 WANT_64BIT=1 WANT_PI4=1 rpi-update 
echo /opt/vc/lib/ | sudo tee /etc/ld.so.conf.d/vc.conf
ldconfig

echo "start_x=1" >> /boot/config.txt