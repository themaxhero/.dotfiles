{ config, pkgs, lib, home-manager, nix-gaming, ... }: {
  networking = {
    hostId = "cc1f83cb";
    hostName = "uchigatana";
  };
  services.minidlna.friendlyName = "uchigatana";
  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.100.0.4/24" "fdb7:2e96:8e57::4/64" ];
    privateKeyFile = "/home/maxhero/wireguard-keys/private";
  };

  environment.systemPackages = with pkgs; [ waynergy ];

  system.stateVersion = "21.11";
}
