{ self, home-manager, nixpkgs, nix-doom-emacs, ... }@attrs:
nixpkgs.lib.nixosSystem {
  system = "aarch64-linux";
  specialArgs = attrs;
  modules = [
    (nixpkgs + "/nixos/modules/profiles/qemu-guest.nix")
    (self + /modules/common)
    (self + /modules/graphical-interface)
    (self + /modules/gaming)
    (self + /modules/development)
    (self + /systems/maxhero-vps/core-configuration.nix)
    (self + /systems/maxhero-vps/configuration.nix)
    (self + /servers/adguard.nix)
    (self + /servers/postgres.nix)
    (self + /servers/firefly.nix)
    (self + /servers/journal-remote.nix)
    (self + /servers/nginx.nix)
    (self + /servers/wireguard.nix)
    (self + /shared/oci-options.nix)
    (self + /shared/oci-common.nix)
    home-manager.nixosModules.home-manager
    ({ config, ... }: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.maxhero = (self + /home/maxhero);
        extraSpecialArgs = attrs // {
          inherit nix-doom-emacs;
          nixosConfig = config;
        };
      };
    })
  ];
}
