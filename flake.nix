{
  # CEREAL REAL
  description = "Max Hero's Nix Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    computador-do-brother.url = "github:TheCodeTherapy/Hephaestus";
    computador-do-brother.inputs.nixpkgs.follows = "nixpkgs";
    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-gaming.inputs.nixpkgs.follows = "nixpkgs";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    nix-doom-emacs.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    emacs-overlay.url  = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };

  outputs = { self, nixpkgs, chaotic, home-manager, nix-doom-emacs, devenv, devshell, ... }@attrs:
    rec {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      mkHome = (import (self + /home/maxhero) attrs).mkHome;
      mkSystem = (import (self + /modules) attrs).mkSystem;
      nixosConfigurations = {
        pc-do-brother = attrs.computador-do-brother.nixosConfigurations.threadripper;
        maxhero-workstation = mkSystem {
          enableBareMetal = true;
          enableEmacs = true;
          enableDevelopment = true;
          enableGraphicalInterface = true;
          enableGaming = true;
          enableNetworking = true;
          enableSound = true;
          enableVFIO = true;
          enableWireguard = false;
          home = mkHome {
            personal = true;
            enableDoomEmacs = false;
            enableDevelopment = true;
            enableVSCode = false;
            enableUI = true;
            enableGaming = true;
          };
          extraModules = [
            chaotic.nixosModules.default
            (self + /systems/maxhero-workstation/configuration.nix)
            (self + /systems/maxhero-workstation/hardware-configuration.nix)
            ({...}: { chaotic.mesa-git.enable = true; })
          ];
          specialArgs = attrs;
        };
        uchigatana = mkSystem {
          enableBareMetal = true;
          enableDevelopment = true;
          enableGraphicalInterface = true;
          enableGaming = true;
          enableNetworking = true;
          enableSound = true;
          enableVFIO = true;
          enableWireguard = true;
          home = mkHome {
            personal = true;
            enableVSCode = true;
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
    };
}
