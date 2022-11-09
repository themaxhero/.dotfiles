{ nixpkgs, home-manager, nix-doom-emacs, ... }@attrs:
let inherit (nixpkgs.lib) mkMerge;
in nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = attrs;
  modules = [
    ../../modules/common
    ../../modules/bare-metal
    ../../modules/graphical-interface
    ../../modules/development
    ../../modules/networking
    ../../modules/sound
    ../../modules/wireguard-client.nix
    ./configuration.nix
    ./hardware-configuration.nix
    home-manager.nixosModules.home-manager
    ({
      home-manager.useGlobalPkgs = true;
      home-manager.users.maxhero = mkMerge [
        (import ../../home/maxhero { inherit nix-doom-emacs mkMerge; })
        ({ ... }: {
          graphical-interface.enable = true;
          graphical-interface.battery-widget.enable = true;
          development.enable = true;
          home.stateVersion = "21.11";
        })
      ];
    })
  ];
}
