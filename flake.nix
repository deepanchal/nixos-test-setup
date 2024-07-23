# Ref: https://github.com/vimjoyer/impermanent-setup/blob/main/final/flake.nix
{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    # Any one of these commands should work
    # sudo nixos-rebuild switch --flake ~/nixos/#zephyrion
    # nh os switch ~/nixos -H zephyrion
    # nh os switch
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        # inputs.disko.nixosModules.default
        # (import ./disko.nix {device = "/dev/vda";})

        ./configuration.nix

        # inputs.home-manager.nixosModules.default
        # inputs.impermanence.nixosModules.impermanence
      ];
    };
  };
}
