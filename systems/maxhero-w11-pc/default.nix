{ nixpkgs, home-manager, nix-doom-emacs, nixos-wsl, ... }@attrs:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = attrs;
  modules = [
    ../../modules/common
    ../../modules/development
    ../../modules/networking
    ../../modules/sound
    ../../modules/wireguard-client.nix
    ./configuration.nix
    "${nixpkgs}/nixos/modules/profiles/minimal.nix"
    nixos-wsl.nixosModules.wsl
    home-manager.nixosModules.home-manager
    ({
      home-manager.useGlobalPkgs = true;
      home-manager.users.maxhero = ../../home/maxhero;
      home-manager.users.maxhero.graphical-interface.enable = false;
      home-manager.users.maxhero.gaming.enable = false;
      home-manager.users.maxhero.development.enable = true;
    })
  ];
}