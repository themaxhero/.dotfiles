{
  # CEREAL REAL
  description = "Max Hero's Nix Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-doom-emacs.url = "github:vlaci/nix-doom-emacs";
    home-manager.url = "github:rycee/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, ... }@attrs: {
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
        ];
      };
    };
  };
}
