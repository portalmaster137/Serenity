#!/bin/sh

./install.sh
./build.sh
sudo nixos-rebuild switch
if ! cmp -s "./hosts/$(hostname)/flake.lock" /etc/nixos/flake.lock; then
    sudo cp /etc/nixos/flake.lock "./hosts/$(hostname)/flake.lock"
fi
