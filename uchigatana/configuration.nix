{ config, pkgs, lib, home-manager, nix-gaming, ... }:
let
  nowl = (import ../tools/nowl.nix) pkgs;
in {
  networking = {
    hostId = "cc1f83cb";
    hostName = "uchigatana";
  };
  services.minidlna.friendlyName = "uchigatana";

  users.users = {
    maxhero = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [
        "wheel"
        "video"
        "audio"
        "realtime"
        "libvirt"
        "kvm"
        "input"
        "networkmanager"
        "rtkit"
        "podman"
      ];
      shell = pkgs.bash;
    };
  };
}
