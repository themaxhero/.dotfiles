{ self, pkgs, ... }:
{
  networking = {
    hostId = "cc1f83cb";
    hostName = "maxhero-workstation";
  };
  services.minidlna.settings.friendly_name = "maxhero-workstation";
  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.100.0.2/24" "fdb7:2e96:8e57::2/64" ];
    privateKeyFile = "/home/maxhero/wireguard-keys/private";
  };
  environment.systemPackages = [ (pkgs.callPackage (self + /pkgs/reboot-to-windows.nix) {}) ];
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
     "android"
     "aws"
     "clasp"
     "oracle-cloud"
     "devops"
     "kubernetes"
    ];
  };
  gaming.enable = true;
  graphical-interface.enable = true;
  system.stateVersion = "22.11";
}
