{ self, nixpkgs, home-manager, nix-doom-emacs, ... }@attrs:
let
  lib = nixpkgs.lib;
in
{
  # TODO: Create all systems through this abstraction
  mkSystem = { ... }@opts:
    let
      home-manager-modules = [
        home-manager.nixosModules.home-manager
        ({ config, ... }: {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.maxhero = opts.home;
            extraSpecialArgs = attrs // {
              inherit nix-doom-emacs;
              nixosConfig = config;
            };
          };
        })
      ];
      modules =
        (lib.optionals opts.enableOpticalMediaGeneration [
          (nixpkgs + /nixos/modules/installer/cd-dvd/installation-cd-minimal.nix)
          (nixpkgs + /nixos/modules/installer/cd-dvd/channel.nix)
        ])
        ++ [ (self + /modules/common) ]
        ++ (lib.optionals opts.enableDevelopment [
          (self + /modules/development)
        ])
        ++ (lib.optionals opts.enableGraphicalInterface [
          (self + /modules/graphical-interface)
        ])
        ++ (lib.optionals opts.enableGaming [
          (self + /modules/gaming)
        ])
        ++ (lib.optionals opts.enableNetworking [
          (self + /modules/networking)
        ])
        ++ (lib.optionals opts.enableSound [
          (self + /modules/sound)
        ])
        ++ (lib.optionals opts.enableVFIO [
          (self + /modules/vfio)
        ])
        ++ (lib.optionals opts.enableWireguard [
          (self + /modules/wireguard-client.nix)
        ])
        ++ (lib.optionals opts.enableBareMetal [
          (self + /modules/bare-metal)
        ])
        ++ opts.extraModules
        ++ home-manager-modules;
    in
    lib.nixosSystem {
      system = opts.arch;
      specialArgs = opts.specialArgs;
      modules = modules;
    };
}
