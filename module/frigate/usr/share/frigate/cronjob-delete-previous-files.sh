#!/bin/bash
set -euo pipefail

TARGET_DIR="$1"  # Specify the folder you want to monitor
THRESHOLD=80  # Disk usage threshold percentage

current_usage() {
    df "$TARGET_DIR" | awk 'NR==2 {print $5}' | sed 's/%//'
}

is_partition_full() {
    # Get the current disk usage percentage of the partition
    [ "$(current_usage)" -ge "$THRESHOLD" ]
}

# Find and delete the oldest files in the folder until the usage goes below the threshold
find "$TARGET_DIR" -type f -printf '%T+ %p\n' | sort | awk '{print $2}' | while read -r file; do
    is_partition_full || break
    
    echo "Purging $file..."
    rm "$file"
done

echo "Disk usage is now $(current_usage)%."


