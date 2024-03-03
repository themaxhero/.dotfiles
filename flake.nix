{
  # CEREAL REAL
  description = "Max Hero's Nix Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs";
    devenv.url = "github:cachix/devenv";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    nix-doom-emacs.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    devshell.url = "github:numtide/devshell";
  };

  outputs = { self, nixpkgs, home-manager, nix-doom-emacs, devenv, devshell, ... }@attrs:
    rec {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      mkHome = (import (self + /home/maxhero) attrs).mkHome;
      mkSystem = (import (self + /modules) attrs).mkSystem;
      nixosConfigurations = {
        maxhero-workstation = mkSystem {
          arch = "x86_64-linux";
          enableBareMetal = true;
          enableOpticalMediaGeneration = false;
          enableDevelopment = true;
          enableGraphicalInterface = true;
          enableGaming = true;
          enableNetworking = true;
          enableSound = true;
          enableVFIO = true;
          enableWireguard = true;
          home = mkHome {
            personal = true;
            enableDoomEmacs = false;
            enableDevelopment = true;
            enableUI = true;
            enableGaming = true;
          };
          extraModules = [
            (self + /systems/maxhero-workstation/configuration.nix)
            (self + /systems/maxhero-workstation/hardware-configuration.nix)
          ];
          specialArgs = attrs;
        };
        maxhero-pi4 = import (self + /systems/maxhero-pi4) attrs;
        uchigatana = mkSystem {
          arch = "x86_64-linux";
          enableBareMetal = true;
          enableOpticalMediaGeneration = false;
          enableDevelopment = true;
          enableGraphicalInterface = true;
          enableGaming = true;
          enableNetworking = true;
          enableSound = true;
          enableVFIO = true;
          enableWireguard = true;
          home = mkHome {
            personal = true;
            enableDoomEmacs = false;
            enableDevelopment = true;
            enableUI = true;
            enableGaming = true;
          };
          extraModules = [
            (self + /systems/uchigatana/configuration.nix)
            (self + /systems/uchigatana/hardware-configuration.nix)
          ];
          specialArgs = attrs;
        };
      };
      neovimHomeManagerConfig = import ./home/maxhero/development/nvim attrs;
      doomEmacsHomeManagerConfig = import ./home/maxhero/development/emacs attrs;
    };
}
