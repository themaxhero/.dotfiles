{ config, pkgs, lib, home-manager, nix-gaming, ... }: {
  networking = {
    hostId = "cc1f83cb";
    hostName = "uchigatana";
  };
  services.minidlna.friendlyName = "uchigatana";
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
      #nvidia-offload
    ];
   #variables = {
   #   "VK_ICD_FILENAMES" = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/radeon_icd.i686.json";
   # }; 
  };
  /*
  nixpkgs.overlays =
    let
      thisConfigsOverlay = final: prev: {
        # Allow steam to find nvidia-offload script
        steam = prev.steam.override {
          extraPkgs = pkgs: [ final.nvidia-offload ];
        };
         # NVIDIA Offloading (ajusted to work on Wayland and XWayland).
        nvidia-offload = final.callPackage ../../shared/nvidia-offload.nix { };
      };
    in
    [ thisConfigsOverlay ];

  specialisation.nvidia-proprietary.configuration = {
    system.nixos.tags = [ "nvidia-proprietary" ];
    hardware.nvidia.open = lib.mkForce false;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    open = true;
    prime = {
      offload.enable = true;
      amdgpuBusId = "PCI:5:0:0"; # Bus ID of the AMD GPU.
      nvidiaBusId = "PCI:1:0:0"; # Bus ID of the NVIDIA GPU.
    };
    powerManagement = {
      enable = true;
      finegrained = true;
    };
  };
  */
  system.stateVersion = "21.11";
}
