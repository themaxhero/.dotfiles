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
      home-manager.users.maxhero = nixpkgs.lib.mkMerge [
        (import ../../home/maxhero {
          inherit nix-doom-emacs;
          pkgs = nixpkgs;
          lib = nixpkgs.lib;
        })
        ({ ... }: {
          graphical-interface.enable = false;
          development.enable = true;
          gaming.enable = false;
          home.stateVersion = "21.11";
        })
      ];
    })
  ];
}
