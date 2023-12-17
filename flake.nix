{
  # CEREAL REAL
  description = "Max Hero's Nix Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs";
    hardware.url = "github:NixOS/nixos-hardware";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    nix-doom-emacs.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-doom-emacs, flake-utils, devshell, ... }@attrs:
    {
      #devShells = import (self + /shells) attrs;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations = nixpkgs.lib.trivial.pipe (self + /systems) [
        (dir: builtins.readDir dir)
        (pairs: nixpkgs.lib.attrsets.filterAttrs (key: value: value == "directory") pairs)
        (dirs: builtins.mapAttrs (system: _: import (self + "/systems/${system}") attrs) dirs)
      ];
      nixopsConfigurations.default = {
        vps-lab = import (self + /machines/oci-vps.nix);
      };
      homeConfigurations = {
        maxhero = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          modules = [
            nix-doom-emacs.hmModule
            (self + /home/maxhero/base)
            (self + /home/maxhero/development)
            (self + /home/maxhero/gaming)
            (self + /home/maxhero/graphical-interface)
          ];
          extraSpecialArgs = {
            inherit (attrs) nixpkgs home-manager;
            nixosConfig = {
              networking = { hostName = "maxhero-wsl"; };
              development.enable = true;
              graphical-interface.enable = false;
              gaming.enable = false;
            };
          };
        };
      };
    };
}
