{ self, config, pkgs, lib, home-manager, nix-gaming, ... }:
{
  networking = {
    hostId = "cc1f83cb";
    hostName = "uchigatana";
  };
  services.minidlna.settings.friendly_name = "uchigatana";
  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.100.0.4/24" "fdb7:2e96:8e57::4/64" ];
    privateKeyFile = "/home/maxhero/wireguard-keys/private";
  };

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

  graphical-interface.enable = true;

  gaming.enable = false;

  environment = {
    systemPackages = with pkgs; [
      waynergy
      airgeddon
    ];
    variables = {
      "VK_ICD_FILENAMES" = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/radeon_icd.i686.json";
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  services.xserver = {
    exportConfiguration = true;
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        middleEmulation = true;
        tapping = true;
      };
    };
    serverFlagsSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
    '';
    xrandrHeads = [
      {
        output = "eDP";
      }
      {
        output = "HDMI-1-0";
        primary = true;
      }
    ];
    windowManager.i3.extraSessionCommands = ''
      xrandr --output eDP --mode 1920x1080 --output HDMI-1-0 --primary --mode 3840x2160 --right-of eDP
    '';
  };

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  specialisation = {
    nvidia-proprietary.configuration = {
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        open = false;
        prime = {
          reverseSync.enable = true;
          amdgpuBusId = "PCI:5:0:0"; # Bus ID of the AMD GPU.
          nvidiaBusId = "PCI:1:0:0"; # Bus ID of the NVIDIA GPU.
        };
        modesetting.enable = true;
      };
    };
    nvidia-open.configuration = {
      system.nixos.tags = [ "nvidia-open" ];
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        open = lib.mkForce true;
        prime = {
          reverseSync.enable = true;
          amdgpuBusId = "PCI:5:0:0"; # Bus ID of the AMD GPU.
          nvidiaBusId = "PCI:1:0:0"; # Bus ID of the NVIDIA GPU.
        };
        modesetting.enable = true;
      };
    };
  };

  system.stateVersion = "22.11";
}
