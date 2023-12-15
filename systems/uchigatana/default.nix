{ self, nixpkgs, home-manager, nix-doom-emacs, ... }@attrs:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = attrs;
  modules = [
    (self + /modules/common)
    (self + /modules/bare-metal)
    (self + /modules/graphical-interface)
    (self + /modules/gaming)
    (self + /modules/development)
    (self + /modules/networking)
    (self + /modules/sound)
    (self + /modules/wireguard-client.nix)
    (self + /systems/uchigatana/configuration.nix)
    (self + /systems/uchigatana/hardware-configuration.nix)
    home-manager.nixosModules.home-manager
    ({ config, ... }: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.maxhero = self + /home/maxhero;
        extraSpecialArgs = attrs // {
          inherit nix-doom-emacs;
          nixosConfig = config;
        };
      };
    })
  ];
}
