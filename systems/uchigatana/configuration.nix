{ config, pkgs, lib, home-manager, nix-gaming, ... }:
let
  nowl = (import ../tools/nowl.nix) pkgs;
in
{
  networking = {
    hostId = "cc1f83cb";
    hostName = "uchigatana";
  };
  services.minidlna.friendlyName = "uchigatana";
  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.100.0.4/24" "fdb7:2e96:8e57::4/64" ];
    privateKeyFile = "/home/maxhero/wireguard-keys/private";
  };
  
  # Nvidia Related Stuff
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      open = true;

      prime = {
      offload.enable = true;
      amdgpuBusId = "PCI:5:0:0"; # Bus ID of the Intel GPU.
      nvidiaBusId = "PCI:1:0:0"; # Bus ID of the NVIDIA GPU.
      };

      powerManagement = {
      enable = true;
      finegrained = true;
      };
  };
  environment = {
      systemPackages = with pkgs; [
      airgeddon
      nvidia-offload
      ];
      variables = {
      "VK_ICD_FILENAMES" = "/run/opengl-driver/share/vulkan/icd.d/intel_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/in
  tel_icd.i686.json";
      };
  };


  # Override some packages' settings, sources, etc...
  nixpkgs.overlays =
    let
      thisConfigsOverlay = final: prev: {
        # Allow steam to find nvidia-offload script
        steam = prev.steam.override {
          extraPkgs = pkgs: [ final.nvidia-offload ];
        };

        # NVIDIA Offloading (ajusted to work on Wayland and XWayland).
        nvidia-offload = final.callPackage ../shared/nvidia-offload.nix { };
      };
    in
    [ thisConfigsOverlay ];

  # Creates a second boot entry without nvidia-open
  specialisation.nvidia-proprietary.configuration = {
    system.nixos.tags = [ "nvidia-proprietary" ];
    hardware.nvidia.open = lib.mkForce false;
  };
}
