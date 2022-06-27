{ config, pkgs, lib, home-manager, nix-gaming, ... }:
let
  nowl = (import ../tools/nowl.nix) pkgs;
in {
  networking = {
    hostId = "cc1f83cb";
    hostName = "uchigatana";
  };
  services.minidlna.friendlyName = "uchigatana";
}
