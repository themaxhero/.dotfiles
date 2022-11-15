{ pkgs, hostName, ... }: {
  networking = {
    hostId = "cc1f83cb";
    inherit "uchigatana";
  };
  services.minidlna.friendlyName = "uchigatana";
  vpn = {
    enable = true;
    ips = [ "10.100.0.4/24" "fdb7:2e96:8e57::4/64" ];
  };
  bare-metal.enable = true;
  development.enable = true;
  gaming.enable = false;
  personal-computer = {
    enable = true;
    widgets.battery.enable = true;
    desktop-environments = ["sway"];
  };
  username = "maxhero";
  environment.systemPackages = with pkgs; [ waynergy ];
  system.stateVersion = "21.11";
  home-manager.users.maxhero.home.stateVersion = "21.11";
}
