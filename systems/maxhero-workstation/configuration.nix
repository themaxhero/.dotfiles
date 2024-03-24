{ self, pkgs, ... }:
{
  networking = {
    hostId = "cc1f83cb";
    hostName = "maxhero-workstation";
    firewall.checkReversePath = false;
  };
  services.minidlna.settings.friendly_name = "maxhero-workstation";
  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.100.0.2/24" "fdb7:2e96:8e57::2/64" ];
    privateKeyFile = "/home/maxhero/wireguard-keys/private";
  };
  services.xserver.serverFlagsSection = ''
    Option "BlankTime" "0"
    Option "StandbyTime" "0"
    Option "SuspendTime" "0"
    Option "OffTime" "0"
  '';
  development = {
    enable = true;
    languages = [
      "dotnet"
      "crystal"
      "f#"
      "ocaml"
      "elm"
      "elixir"
      "web"
      "zig"
      "node"
      "ruby"
      "scala"
      "haskell"
      "clojure"
      "rust"
      #"android"
      "aws"
      "clasp"
      "oracle-cloud"
      "devops"
      "kubernetes"
    ];
  };
  environment.systemPackages = with pkgs; [ qpwgraph ];
  services.xserver.windowManager.i3.extraSessionCommands = ''
    flameshot &
    uim-xim &
    qpwgraph -a &
  '';
  services.picom = {
    enable = true;
    vSync = true;
  };
  services.xserver.deviceSection = ''Option "TearFree" "true"'';
  gaming.enable = true;
  graphical-interface.enable = true;
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0
  '';

  boot.initrd.luks.devices.kyuukyoku = {
    device = "/dev/disk/by-uuid/0f2a2a67-04d5-4faa-8c26-d4fc82a0d62f";
    preLVM = true;
  };

  fileSystems = {
    "/home/maxhero/SteamLibrary" = {
      label = "Steam Library";
      device = "/dev/disk/by-uuid/483f5d2b-f4c1-44dc-827a-01df0c2bb80c";
      fsType = "ext4";
    };
    "/home/maxhero/data" = {
      label = "Kyuukyoku";
      device = "/dev/disk/by-uuid/eb36fe83-8308-4d42-a4cf-a5732924c686";
      fsType = "ext4";
    };
  };
  services.static-web-server = {
    enable = true;
    listen = "192.168.15.4:80";
    root = "/home/maxhero/hitobashira";
    configuration.general.directory-listing = true;
  };
  system.stateVersion = "22.11";
}
