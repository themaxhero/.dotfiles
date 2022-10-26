{ nixpkgs, home-manager, nix-doom-emacs, ... }@attrs:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = attrs;
  modules = [
    ../../modules/common
    ../../modules/linux-only
    ../../modules/development
    ../../modules/networking
    ../../modules/sound
    ../../modules/wireguard-client.nix
    ./configuration.nix
    ./hardware-configuration.nix
    home-manager.nixosModules.home-manager
    ({
        home-manager.useGlobalPkgs = true;
        home-manager.users.maxhero = nixpkgs.lib.mkMerge [
        nix-doom-emacs.hmModule
        (import ../../home/maxhero { seat = true; })
        ];
    })
  ];
}