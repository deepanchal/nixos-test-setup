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
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    # Any one of these commands should work
    # sudo nixos-rebuild switch --flake ~/nixos/#zephyrion
    # nh os switch ~/nixos -H zephyrion
    # nh os switch
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        inputs.disko.nixosModules.default
        (import ./disk-config.nix {device = "/dev/disk/by-id/ata-SanDisk_SSD_PLUS_240GB_191386466003";})

        ./configuration.nix
        ./impermanence.nix
      ];
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # Any one of these commands should work
      # home-manager switch --flake ~/nixos/.#deep@zephyrion --show-trace
      # nh home switch ~/nixos -c deep@zephyrion
      # nh home switch
      "deep@zephyrion" = home-manager.lib.homeManagerConfiguration {
        # pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home manager requires 'pkgs' instance
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
        modules = [./home.nix];
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };
  };
}
