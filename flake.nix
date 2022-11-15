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
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
  };

  outputs = { self, nixpkgs, home-manager, nix-doom-emacs, flake-utils, devshell, ... }@attrs:
  {
    devShells = import ./shells attrs;
    nixosConfigurations = import ./systems attrs;
    nixosModules = import ./modules attrs;
  };
}
