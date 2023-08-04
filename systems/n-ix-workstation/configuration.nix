{ self, pkgs, ... }:
{
  networking = {
    hostId = "cc1f83c4";
    hostName = "n-ix-workstation";
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
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-uuid/240f6901-3677-4024-8905-e13eceb642ca";
      preLVM = true;
    };
  };

  graphical-interface.enable = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d9e63ed5-d194-43e2-8c82-4d521356086f";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/245E-CF52";
    fsType = "vfat";
  };
  system.stateVersion = "22.11";
}
