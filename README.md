# nixos-test-setup

Testing nixos setup

## Setup

Run this command to setup nixos on your drive. 
Replace `/dev/disk/by-id/ata-SanDisk_SSD_PLUS_240GB_191386466003` with your drive to format it with disko and install nixos on the drive.

```bash
sudo nix run --experimental-features "nix-command flakes" 'github:nix-community/disko#disko-install' --  --write-efi-boot-entries --disk main /dev/disk/by-id/ata-SanDisk_SSD_PLUS_240GB_191386466003 --flake .#default
```

## References

- https://github.com/vimjoyer/impermanent-setup/blob/main/final/disko.nix
- https://github.com/ryan4yin/nix-config/blob/783d61999cfbd31341f28d8531c544a77c570901/hosts/k8s/disko-config/README.md#2-partition-the-ssd--install-nixos-via-disko
- https://github.com/nix-community/impermanence
