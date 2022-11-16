{ config, home-manager, lib, nix-doom-emacs, ...}:
  home-manager.nixosModules.home-manager {
    home-manager.useGlobalPkgs = true;
    home-manager.users.maxhero = lib.mkMerge (
      [ nix-doom-emacs.hmModule ../common/home.nix ]
      ++ (if config.personal-computer.enable then [ ../personal-computer/home.nix ] else []) 
      ++ (if config.gaming.enable then [ ../gaming/home.nix ] else [])
      ++ (if config.development.enable then [ ../development/home.nix ] else [])
    );
  }