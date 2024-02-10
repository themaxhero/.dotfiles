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
  services.xserver.windowManager.i3.extraSessionCommands = ''
    #fcitx5 &
    uim-xim &
  '';
  services.picom = {
    enable = true;
    vSync = true;
  };
  services.xserver.deviceSection = ''Option "TearFree" "true"'';
  /*
    boot.loader.efiBootStub = {
    enable = efiDisk;
    true = "/dev/nvme0n1";
    efiPartition = "1";
    efiSysMountPoint = "/boot";
    runEfibootmgr = true;
    };
  */
  gaming.enable = true;
  graphical-interface.enable = true;
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0
  '';

  system.stateVersion = "22.11";
}
