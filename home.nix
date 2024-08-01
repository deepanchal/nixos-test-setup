# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.hello
  ];

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home.stateVersion = "24.11";
  # programs.fuse.userAllowOther = true;
  # home.persistence."/persist/home" = {
  #   directories = [
  #     "Downloads"
  #     "Music"
  #     "Pictures"
  #     "Documents"
  #     "Videos"
  #     "VirtualBox VMs"
  #     "nixos"
  #     ".gnupg"
  #     ".ssh"
  #     ".local/share"
  #     ".local/state"
  #   ];
  #   files = [
  #     ".screenrc"
  #   ];
  #   allowOther = true;
  # };
}

