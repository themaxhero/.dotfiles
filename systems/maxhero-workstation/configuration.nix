{ self, pkgs, ... }:
{
  networking = {
    hostId = "cc1f83cb";
    hostName = "maxhero-workstation";
    firewall.checkReversePath = false;
  };
  services.minidlna.settings = {
    friendly_name = "maxhero-workstation";
    media_dir = [
      "V,/home/maxhero/data/Items/Videos"
      "A,/home/maxhero/data/Items/Music"
    ];
  };
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
  /*
  # at some point create a nix container or something to host this server
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    extraConfig = ''
      workgroup = AIZONE
      server string = smbnix
      netbios name = smbnix
      security = user 
      #use sendfile = yes
      #max protocol = smb2
      # note: localhost is the ipv6 localhost ::1
      hosts allow = 192.168.15.4 127.0.0.1 localhost
      hosts allow = 192.168.15.2
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      hitobashira-ro = {
        path = "/home/maxhero/Public/hitobashira-ro";
        browseable = "yes";
        "read only" = "yes";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "hitobashira";
        #"force group" = "groupname";
      };
      hitobashira-w = {
        path = "/home/maxhero/Public/hitobashira-w";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "hitobashira";
        #"force group" = "groupname";
      };
    };
  };

  */
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smbnix
      netbios name = smbnix
      security = user 
      #use sendfile = yes
      #max protocol = smb2
      # note: localhost is the ipv6 localhost ::1
      hosts allow = 192.168.15.4 127.0.0.1 localhost
      hosts allow = 192.168.15.100
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      data = {
        path = "/home/maxhero/data";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "maxhero";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  system.stateVersion = "22.11";
}
