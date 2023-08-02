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
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/858f7daa-36ea-4d5c-9bce-01d85b77053f";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/6784-CFF4";
    fsType = "vfat";
  };
  system.stateVersion = "22.11";
}
