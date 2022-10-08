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
  };

  outputs = { self, nixpkgs, home-manager, nix-doom-emacs, ... }@attrs: {
    nixosConfigurations = {
      "maxhero-workstation" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          ./modules/common
          ./modules/development
          ./modules/gaming
          ./modules/networking
          ./modules/sound
          ./modules/vfio
          ./maxhero-workstation/configuration.nix
          ./maxhero-workstation/hardware-configuration.nix
          home-manager.nixosModules.home-manager ({
            home-manager.useGlobalPkgs = true;
            home-manager.users.maxhero = lib.mkMerge [
              nix-doom-emacs.hmModule
              (import ./home/maxhero { seat = true; })
            ];
          })
        ];
      };
      "uchigatana" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          ./modules/common
          ./modules/development
          ./modules/networking
          ./modules/sound
          ./uchigatana/configuration.nix
          ./uchigatana/hardware-configuration.nix
          home-manager.nixosModules.home-manager ({
            home-manager.useGlobalPkgs = true;
            home-manager.users.maxhero = nixpkgs.lib.mkMerge [
              nix-doom-emacs.hmModule
              (import ./home/maxhero { seat = true; })
            ];
          })
        ];
      };
      "maxhero-vps" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = attrs;
        modules = [
          (nixpkgs + "/nixos/modules/profiles/qemu-guest.nix")
          ./shared/oci-options.nix
          ./shared/oci-common.nix
          ./maxhero-vps/core-configuration.nix
          ./maxhero-vps/configuration.nix
          ./maxhero-vps/servers/adguard.nix
          ./maxhero-vps/servers/journal-remote.nix
          ./maxhero-vps/servers/nginx.nix
          ./maxhero-vps/servers/wireguard.nix
          # home-manager
          home-manager.nixosModules.home-manager ({
            home-manager.useGlobalPkgs = true;
            home-manager.users.maxhero = nixpkgs.lib.mkMerge [
              nix-doom-emacs.hmModule
              (import ./home/maxhero { seat = false; })
            ];
          })
        ];
      };
    };
  };
}
