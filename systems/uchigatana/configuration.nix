{ config, pkgs, lib, home-manager, nix-gaming, ... }:
let
  uchigatanaDisplay = "00ffffffffffff0030e47e0600000000001e0104a522137807a895a6544b9b260f505400000001010101010101010101010101010101003980a0703859403020350058c21000001a000000fd003ca5c1c129010a202020202020000000fe005459393056813135365746470a000000000002413f9e001100000f010a202001347013790000030114b89c00847f079f002f801f0037045800020004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f890";
  asusMonitor4K = "00ffffffffffff0006b3ca28e8740100171f0103803e22782aad65ad50459f250e50542308008140818081c081009500b300d1c001014dd000a0f0703e80303035006d552100001a565e00a0a0a02950302035006d552100001e000000fd00283c1ea03c000a202020202020000000fc0041535553205647323839513141016d02034df154010304121305141f1007060260610e0f15161d1e2309070783010000e200d567030c002000383c67d85dc401788003681a00000101283ef0e305e301e40f003000e606070159521c023a801871382d40582c45006d552100001e00000000000000000000000000000000000000000000000000000000000000008e";
in
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
    videoDrivers = [ "nvidia" ];
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
  hardware.nvidia = {
    open = false;
    prime = {
      reverseSync.enable = true;
      amdgpuBusId = "PCI:5:0:0"; # Bus ID of the AMD GPU.
      nvidiaBusId = "PCI:1:0:0"; # Bus ID of the NVIDIA GPU.
    };
    modesetting.enable = true;
  };

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  specialisation = {
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
