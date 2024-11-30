#!/bin/bash
set -eux

dir=/data/frigate

mkdir -p $dir/media/clips
mkdir -p $dir/media/recordings

mount -t tmpfs tmpfs -o size=5% $dir/media/clips
mount -t tmpfs tmpfs -o size=55% $dir/media/recordings

mkdir -p $dir/config

if [ -f $dir/config.yml ]; then
    mv $dir/config.yml $dir/config
fi

if [ ! -f $dir/config/config.yml ]; then
    cp /usr/share/frigate/sample-config.yml $dir/config/config.yml
fi

cp $dir/config/config.yml $dir/media/config.yml.backup
