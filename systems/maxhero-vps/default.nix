{ nixpkgs, nix-doom-emacs, ... }@attrs:
let inherit (nixpkgs.lib) mkMerge;
in
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
    #({
    #  home-manager.useGlobalPkgs = true;
    #  home-manager.users.maxhero = mkMerge [
    #    (import ../../home/maxhero { inherit nix-doom-emacs mkMerge; })
    #    ({ ... }: {
    #      graphical-interface.enable = false;
    #      development.enable = false;
    #      gaming.enable = false;
    #      home.stateVersion = "21.11";
    #    })
    #  ];
    #})
  ];
}
