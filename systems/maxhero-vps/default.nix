{ nixpkgs, nix-doom-emacs, ... }@attrs:
nixpkgs.lib.nixosSystem {
  system = "aarch64-linux";
  specialArgs = attrs;
  modules = [
    (nixpkgs + "/nixos/modules/profiles/qemu-guest.nix")
    ../../modules/common
    ../../modules/graphical-interface
    ../../modules/gaming
    ../../modules/development
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
    home-manager.nixosModules.home-manager
    ({ config, ... }: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.maxhero = ../../home/maxhero;
        extraSpecialArgs = attrs // {
          inherit nix-doom-emacs;
          nixosConfig = config;
        };
      };
    })
  ];
}
