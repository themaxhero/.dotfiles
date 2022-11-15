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
    ../../modules/wireguard-client
    ./configuration.nix
    ./hardware-configuration.nix
  ];
}
