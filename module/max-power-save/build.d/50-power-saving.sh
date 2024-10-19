#!/bin/bash

config_file=/boot/config.txt
if [ -f /boot/firmware/config.txt ]; then
    config_file=/boot/firmware/config.txt
    mount -o rw,remount /boot/firmware || true
fi

cat <<EOF >> $config_file

dtoverlay=disable-bt

# Disable Activity LED
dtparam=act_led_trigger=none
dtparam=act_led_activelow=off

# Disable Power LED
dtparam=pwr_led_trigger=none
dtparam=pwr_led_activelow=off

disable_camera_led=1
EOF

sed -i 's/dtparam=audio=on/dtparam=audio=off/g' $config_file

systemctl enable --no-block power-save.timer

# systemctl disable apt-daily.timer
# systemctl mask apt-daily.service
# systemctl disable apt-daily-upgrade.timer
# systemctl mask apt-daily-upgrade.service
