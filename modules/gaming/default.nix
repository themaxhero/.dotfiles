{ pkgs, nixpkgs, ... }:
let
  username = config.username;
in
{
  options.gaming.enable = lib.mkEnableOption "Enable Gaming Module";
  config = lib.mkIf config.gaming.enable {
    environment.variables = {
      GAMEMODERUNEXEC = "mangohud WINEFSYNC=1 PROTON_WINEDBG_DISABLE=1 DXVK_LOG_PATH=none DXVK_HUD=compiler ALSOFT_DRIVERS=alsa";
    };

    environment.systemPackages = with pkgs; [
      # Gaming
      mangohud
      minecraft
      mesa-demos
      lutris
      #nix-gaming.packages.x85_64-linux.wine-tkg
      vulkan-tools
      winetricks
    ];

    nixpkgs.config.packageOverrides = pkgs: {
      steam = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [ gamemode mangohud ];
      };
    };

    programs.gamemode.enable = lib.mkDefault true;
    programs.steam = lib.mkDefault {
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
    '';

    # User-Level Stuff
    home-manager.users."${username}" = lib.mkDefault {
      programs.mangohud = {
        enable = true;
        settings = {
          arch = true;
          background_alpha = "0.05";
          battery = true;
          cpu_temp = true;
          engine_version = true;
          font_size = 17;
          gl_vsync = -1;
          gpu_temp = true;
          io_read = true;
          io_write = true;
          position = "top-right";
          round_corners = 8;
          vram = true;
          vsync = 0;
          vulkan_driver = true;
          width = 260;
          wine = true;
        };
      };
    };
  };
}
