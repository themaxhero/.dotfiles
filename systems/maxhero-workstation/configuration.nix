{ pkgs, hostName, ... }:
{
  networking = {
    hostId = "cc1f83cb";
    inherit hostName;
  };
  services.minidlna.friendlyName = hostName;
  vpn = {
    enable = true;
    ips = [ "10.100.0.2/24" "fdb7:2e96:8e57::2/64" ];
  };

  system.stateVersion = "21.11";
}
