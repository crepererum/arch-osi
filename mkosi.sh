#!/usr/bin/env bash

set -euo pipefail

readonly NAME='arch_osi'

# clean up
rm -rf "$NAME".*

# build
sudo mkosi build

# expand image
# This is so the systemd-repart has enough space to create the stateful partitions (root, swap, etc.)
mv "$NAME.raw" "$NAME.raw.backup"
truncate -s 2G "$NAME.raw"
dd if="$NAME.raw.backup" of="$NAME.raw" conv=notrunc
rm "$NAME.raw.backup"

# run
mkosi qemu
