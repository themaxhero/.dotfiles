{ nixpkgs, home-manager, nix-doom-emacs, ... }@attrs:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = attrs;
  modules = [
    ../../modules/common
    ../../modules/bare-metal
    ../../modules/graphical-interface
    ../../modules/gaming
    ../../modules/development
    ../../modules/networking
    ../../modules/sound
    ../../modules/wireguard-client.nix
    ./configuration.nix
    ./hardware-configuration.nix
    home-manager.nixosModules.home-manager
    ({ config, ... }:
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.maxhero = ../../home/maxhero;
          extraSpecialArgs = attrs // {
            inherit nix-doom-emacs;
            nixosConfig = config;
          };
        };
      }
    ) 
  ];
}
