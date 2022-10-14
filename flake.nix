{
  # CEREAL REAL
  description = "Max Hero's Nix Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    nix-doom-emacs.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell";
  };

  outputs = { self, lib, nixpkgs, home-manager, nix-doom-emacs, flake-utils, devshell, ... }@attrs:
  {
    devShells = import ./shells attrs;
    nixosConfigurations = lib.trivial.pipe ./systems [
      builtins.readDir
      lib.attrsets.filterAttrs (key: value: value == "directory")
      builtins.mapAttrs (key: value: import (./. + "./system/${system}") attrs)
    ];
  };
}
