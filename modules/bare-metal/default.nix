{ pkgs, config, ... }: {
  # Better voltage and temperature
  boot.extraModulePackages = with config.boot.kernelPackages; [ zenpower ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  # Use Systemd Boot
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  hardware.bluetooth.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ rocm-opencl-icd rocm-opencl-runtime ];
  };
  hardware.i2c.enable = true;

  programs.nm-applet.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs;
      [
        xdg-desktop-portal-gtk
      ];
    config.common.default = "*";
  };
  services.udisks2.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  # sound.mediaKeys.enable = true;
  services.blueman.enable = true;
  services.flatpak.enable = true;
  services.minidlna = {
    enable = true;
    settings.media_dirs = [ "/home/upnp-shared/Media" ];
  };
  services.acpid.enable = true;
  services.fwupd.enable = true;
  services.ntp.enable = true;
  services.tumbler.enable = true;
}
