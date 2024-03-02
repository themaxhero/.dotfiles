{
  # CEREAL REAL
  description = "Max Hero's Nix Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs";
    hardware.url = "github:NixOS/nixos-hardware";
    devenv.url = "github:cachix/devenv";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    nix-doom-emacs.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
  };

  outputs = { self, nixpkgs, home-manager, nix-doom-emacs, flake-utils, devenv, devshell, ... }@attrs:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations = {
        maxhero-workstation = import (self + /systems/maxhero-workstation) attrs;
        maxhero-pi4 = import (self + /systems/maxhero-pi4) attrs;
        maxhero-vps = import (self + /systems/maxhero-vps) attrs;
        uchigatana = import (self + /systems/uchigatana) attrs;
      };
      neovimHomeManagerConfig = import ./home/maxhero/development/nvim attrs;
      doomEmacsHomeManagerConfig = import ./home/maxhero/development/emacs attrs;
    };
}
