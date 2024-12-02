{ options, config, pkgs, lib, nixpkgs, ... }:
let
  cfg = config.gaming;
in
{
  options = {
    gaming.enable = lib.mkEnableOption "Enables the gaming module";
  };
  config = lib.mkIf cfg.enable {
    environment.variables = {
      GAMEMODERUNEXEC = "mangohud WINEFSYNC=1 PROTON_WINEDBG_DISABLE=1 DXVK_LOG_PATH=none DXVK_HUD=compiler ALSOFT_DRIVERS=alsa";
    };

    environment.systemPackages = with pkgs; [
      mangohud
      mesa-demos
      lutris
      pcsx2
      dolphin-emu
      retroarchFull
      vulkan-tools
      winetricks
    ];

    nixpkgs.config.packageOverrides = pkgs: {
      steam = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [ gamemode mangohud ];
      };
    };

    programs.gamemode.enable = true;
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    services.udev.extraRules = ''
      # This rule is needed for basic functionality of the controller in
      # Steam and keyboard/mouse emulation
      SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0666"
      # This rule is necessary for gamepad emulation; make sure you
      # replace 'pgriffais' with a group that the user that runs Steam
      # belongs to
      KERNEL=="uinput", MODE="0660", GROUP="pgriffais", OPTIONS+="static_node=uinput"
      # Valve HID devices over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="28de", MODE="0666"
      # Valve HID devices over bluetooth hidraw
      KERNEL=="hidraw*", KERNELS=="*28DE:*", MODE="0666"
      # DualShock 4 over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0666"
      # Dualsense over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ce6", MODE="0666"
      # DualShock 4 wireless adapter over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ba0", MODE="0666"
      # DualShock 4 Slim over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09cc", MODE="0666"
      # DualShock 4 over bluetooth hidraw
      KERNEL=="hidraw*", KERNELS=="*054C:05C4*", MODE="0666"
      # DualShock 4 Slim over bluetooth hidraw
      KERNEL=="hidraw*", KERNELS=="*054C:09CC*", MODE="0666"

      # -============================== Wooting Portion ===================================-
      # Wooting One Legacy
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff01", TAG+="uaccess"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff01", TAG+="uaccess"

      # Wooting One update mode
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2402", TAG+="uaccess"

      # Wooting Two Legacy
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff02", TAG+="uaccess"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff02", TAG+="uaccess"

      # Wooting Two update mode
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2403", TAG+="uaccess"

      # Generic Wootings
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", TAG+="uaccess"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="31e3", TAG+="uaccess"
    '';
  };
}
