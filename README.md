# nixos-test-setup

Testing nixos setup

## Setup

Run this command to setup nixos on your drive. 
Replace `/dev/disk/by-id/ata-SanDisk_SSD_PLUS_240GB_191386466003` with your drive to format it with disko and install nixos on the drive.

```bash
# one-liner after cloning the repo
sudo nix run --experimental-features "nix-command flakes" 'github:nix-community/disko#disko-install' --  --write-efi-boot-entries --disk main /dev/disk/by-id/ata-SanDisk_SSD_PLUS_240GB_191386466003 --flake .#default

# one-liner without cloning the repo
sudo nix run --experimental-features "nix-command flakes" 'github:nix-community/disko#disko-install' --  --write-efi-boot-entries --disk main /dev/disk/by-id/ata-SanDisk_SSD_PLUS_240GB_191386466003 --flake github:deepanchal/nixos-test-setup#default

# step-by-step

## format disk
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disk-config.nix
## install nixos
sudo nixos-install --root /mnt --no-root-password --show-trace --verbose --flake .#default
```


## Commands

```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disko.nix --arg device '"/dev/disk/by-id/ata-SanDisk_SSD_PLUS_240GB_191386466003"'
nix flake check
sudo nixos-generate-config --no-filesystems --root /mnt
sudo cp configuration.nix disko.nix flake.lock flake.nix hardware-configuration.nix home.nix README.md /mnt/etc/nixos 
sudo cp -rv /mnt/etc/nixos /mnt/persist
sudo nixos-install --root /mnt --no-root-password --show-trace --verbose --flake .#default
```

## References

- https://grahamc.com/blog/erase-your-darlings/
- https://mt-caret.github.io/blog/posts/2020-06-29-optin-state.html
- https://elis.nu/blog/2020/06/nixos-tmpfs-as-home/
- https://github.com/talyz/presentations/blob/master/impermanence-nixcon-2023/impermanence.org
- https://github.com/vimjoyer/impermanent-setup/blob/main/final/disko.nix
- https://github.com/ryan4yin/nix-config/blob/783d61999cfbd31341f28d8531c544a77c570901/hosts/k8s/disko-config/README.md#2-partition-the-ssd--install-nixos-via-disko
- https://github.com/nix-community/impermanence
