{nixpkgs, home-manager, nix-doom-emacs, ...}@attrs:
nixpkgs.lib.nixosSystem {
  system = "aarch64-linux";
  specialArgs = attrs;
  modules = [
    (nixpkgs + "/nixos/modules/profiles/qemu-guest.nix")
    ./core-configuration.nix
    ./configuration.nix
    ../../servers/adguard.nix
    ../../servers/postgres.nix
    ../../servers/firefly.nix
    ../../servers/journal-remote.nix
    ../../servers/nginx.nix
    ../../servers/wireguard.nix
    ../../shared/oci-options.nix
    ../../shared/oci-common.nix
    # home-manager
    home-manager.nixosModules.home-manager
    ({
      home-manager.useGlobalPkgs = true;
      home-manager.users.maxhero = nixpkgs.lib.mkMerge [
        nix-doom-emacs.hmModule
        (import ../../home/maxhero { seat = false; })
      ];
    })
  ];
}