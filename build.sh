#!/bin/sh

trap "git rm -f flake.lock" EXIT
ln -s ./hosts/$(hostname)/flake.lock flake.lock
git add flake.lock
nom build ".#nixosConfigurations.$(hostname).config.system.build.toplevel"
