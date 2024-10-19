#!/bin/bash
. "$(dirname "$(realpath "$0")")/src/common.sh"

if [  $# -eq 0 ]; then
    echo "Usage: $0 <module1> <module2>..."
    echo ""
    echo "Available: $(ls "$modules_dir" | tr '\n' ' ')"
    exit 1
fi

set -euo pipefail

cd "$root_dir"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

for module in "$@"; do
    if [ ! -d "$modules_dir/$module" ]; then
        error "Module $module not found"
    fi

    rsync -av --exclude 'configpaths.txt' "$modules_dir/$module/" "$tmp_dir/"
done

correct-permissions "$tmp_dir/"
rsync -av --update --exclude 'build.d' "$tmp_dir/" /

for script in "$tmp_dir/build.d/"*.sh; do
    echo " * Running $script"
    bash -euxo pipefail "$script"
done

systemctl daemon-reload

for service in "$tmp_dir"/*/systemd/system/*.service; do
    if [ ! -e "$service" ]; then
        continue
    fi
    servicename="$(basename "$service")"
    
    echo "Enabling $servicename"
    systemctl enable "$servicename"
    
    echo "Restarting $servicename"
    systemctl restart "$servicename"
done