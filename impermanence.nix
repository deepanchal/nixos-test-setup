{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  fileSystems."/persist".neededForBoot = true;

  # There are two ways to clear the root filesystem on every boot:
  ##  1. use tmpfs for /
  ##  2. (btrfs/zfs only)take a blank snapshot of the root filesystem and revert to it on every boot via:
  ##     boot.initrd.postDeviceCommands = ''
  ##       mkdir -p /run/mymount
  ##       mount -o subvol=/ /dev/disk/by-uuid/UUID /run/mymount
  ##       btrfs subvolume delete /run/mymount
  ##       btrfs subvolume snapshot / /run/mymount
  ##     '';
  #
  #  See also https://grahamc.com/blog/erase-your-darlings/

  # NOTE: impermanence only mounts the directory/file list below to /persist
  # If the directory/file already exists in the root filesystem, you should
  # move those files/directories to /persist first!
  environment.persistence."/persist" = {
    # sets the mount option x-gvfs-hide on all the bind mounts
    # to hide them from the file manager
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/etc/ssh"
      "/etc/nix/inputs"
      "/var/log"
      "/var/lib"
    ];
    files = [
      "/etc/machine-id"
    ];

    # the following directories will be passed to /persist/home/$USER
    users.deep = {
      directories = [
        {
          directory = ".ssh";
          mode = "0700";
        }

        # neovim / remmina / flatpak / ...
        ".local/share"
        ".local/state"

        # language package managers
        ".npm"
      ];
      files = [
      ];
    };
  };
}
