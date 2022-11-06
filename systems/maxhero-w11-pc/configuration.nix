{ config, pkgs, lib, home-manager, nix-gaming, ... }:
{
  networking = {
    hostId = "7ee3a466";
    hostName = "maxhero-w11-pc";
  };
  
  wsl = {
    enable = true;
    automountPath = "/mnt";
    defaultUser = "maxhero";
    startMenuLaunchers = true;
  };

  # Enable nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "22.05";
}