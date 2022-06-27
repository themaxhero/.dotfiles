{ pkgs, ... }:
{
  networking = {
    hostId = "cc1f83cb";
    hostName = "maxhero-workstation";
  };
  services.minidlna.friendlyName = "maxhero-workstation";
}
