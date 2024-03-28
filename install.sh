#!/bin/sh

sudo rsync -rla --delete --exclude=".*" . /etc/nixos
sudo ln -s /etc/nixos/hosts/$(hostname)/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
sudo ln -s /etc/nixos/hosts/$(hostname)/flake.lock /etc/nixos/flake.lock
if [ "$(hostname)" = "wyvern" ]; then
    sudo chown syncoid:syncoid /etc/nixos/secrets/turtle-backup.key
    sudo chown nebula-bbs:nebula-bbs /etc/nixos/secrets/ca.crt
    sudo chown nebula-bbs:nebula-bbs /etc/nixos/secrets/wyvern.bbs.lan.crt
    sudo chown nebula-bbs:nebula-bbs /etc/nixos/secrets/wyvern.bbs.lan.key
fi

mkdir -p ~/.ssh
rsync -p --chmod=600 ./secrets/id_yubikey1_fido2 ~/.ssh/
rsync -p --chmod=600 ./secrets/id_yubikey2_fido2 ~/.ssh/
rsync -p --chmod=600 ./secrets/fallback ~/.ssh/

mkdir -p ~/.config/sops/age
rsync -p --chmod=600 ./secrets/sops-age-keys.txt ~/.config/sops/age/keys.txt

sudo cp ./media/pfp.png /var/lib/AccountsService/icons/sasha
