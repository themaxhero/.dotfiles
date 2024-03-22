{ self, nixpkgs, home-manager, nix-doom-emacs, nur, ... }@attrs:
let
  lib = nixpkgs.lib;
in
{
  # TODO: Create all systems through this abstraction
  mkSystem =
    { enableOpticalMediaGeneration ? false
    , enableDevelopment ? false
    , enableGraphicalInterface ? false
    , enableGaming ? false
    , enableNetworking ? false
    , enableSound ? false
    , enableVFIO ? false
    , enableWireguard ? false
    , enableBareMetal ? false
    , extraModules ? [ ]
    , arch ? "x86_64-linux"
    , specialArgs ? { }
    , username ? "maxhero"
    , home
    , ...
    }:
    let
      home-manager-modules = [
        home-manager.nixosModules.home-manager
        ({ config, ... }: {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."${username}" = home;
            extraSpecialArgs = attrs // {
              inherit nix-doom-emacs;
              nixosConfig = config;
            };
          };
        })
      ];
      modules =
        [ { nixpkgs.overlays = [nur.overlay]; } ]
        ++ (lib.optionals enableOpticalMediaGeneration [
          (nixpkgs + /nixos/modules/installer/cd-dvd/installation-cd-minimal.nix)
          (nixpkgs + /nixos/modules/installer/cd-dvd/channel.nix)
        ])
        ++ [ (self + /modules/common) ]
        ++ (lib.optionals enableDevelopment [
          (self + /modules/development)
        ])
        ++ (lib.optionals enableGraphicalInterface [
          (self + /modules/graphical-interface)
        ])
        ++ (lib.optionals enableGaming [
          (self + /modules/gaming)
        ])
        ++ (lib.optionals enableNetworking [
          (self + /modules/networking)
        ])
        ++ (lib.optionals enableSound [
          (self + /modules/sound)
        ])
        ++ (lib.optionals enableVFIO [
          (self + /modules/vfio)
        ])
        ++ (lib.optionals enableWireguard [
          (self + /modules/wireguard-client.nix)
        ])
        ++ (lib.optionals enableBareMetal [
          (self + /modules/bare-metal)
        ])
        ++ extraModules
        ++ home-manager-modules;
    in
    lib.nixosSystem {
      system = arch;
      specialArgs = specialArgs;
      modules = modules;
    };
}
