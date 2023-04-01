{ self, nixpkgs, home-manager, nix-doom-emacs, ... }@attrs:
nixpkgs.lib.nixosSystem {
  system = "aarch64-linux";
  specialArgs = attrs;
  modules = [
    (self + /modules/common)
    (self + /modules/networking)
    (self + /modules/wireguard-client.nix)
    ./configuration.nix
    ./hardware-configuration.nix
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
