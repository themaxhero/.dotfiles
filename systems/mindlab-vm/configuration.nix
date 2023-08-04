{ self, pkgs, ... }:
{
  networking = {
    hostId = "cc1f83cc";
    hostName = "mindlab-vm";
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
     # "elm"
     "elixir"
     "web"
     "zig"
     "node"
     "ruby"
     "scala"
     "haskell"
     "clojure"
     "rust"
     "android"
     "aws"
     "clasp"
     "oracle-cloud"
     "devops"
     "kubernetes"
    ];
  };
  services.xserver.windowManager.i3.extraSessionCommands = ''
  fcitx5 &
  '';
  gaming.enable = false;
  graphical-interface.enable = true;
  virtualisation.hyperVGuest.enable = true;
  virtualisation.hyperVGuest.videoMode = "1920x1080";
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e9a7670f-96bb-41c9-9bd5-11f9f9b2b00e";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F2D1-87AD";
    fsType = "vfat";
  };
  system.stateVersion = "22.11";
}
