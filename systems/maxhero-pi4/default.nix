{ self, nixpkgs, home-manager, nix-doom-emacs, hardware, ... }@attrs:
nixpkgs.lib.nixosSystem {
  system = "aarch64-linux";
  specialArgs = attrs;
  modules = [
    (nixpkgs + /nixos/modules/installer/sd-card/sd-image-aarch64.nix)
    (self + /modules/common)
    (self + /modules/graphical-interface)
    (self + /modules/gaming)
    (self + /modules/development)
    (self + /modules/networking)
    (self + /systems/maxhero-pi4/configuration.nix)
    (self + /systems/maxhero-pi4/hardware-configuration.nix)
    (self + /systems/maxhero-pi4/nginx.nix)
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
