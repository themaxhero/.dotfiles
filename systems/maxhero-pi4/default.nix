{ self, nixpkgs, home-manager, nix-doom-emacs, hardware, ... }@attrs:
nixpkgs.lib.nixosSystem {
  system = "aarch64-linux";
  specialArgs = attrs;
  modules = [
    hardware.raspberry-pi-4
    (self + /modules/common)
    (self + /modules/networking)
    (self + /modules/wireguard-client.nix)
    (self + /systems/maxhero-pi4/configuration.nix)
    (self + /systems/maxhero-pi4/hardware-configuration.nix)
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
